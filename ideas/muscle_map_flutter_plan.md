# Create/overwrite the updated Markdown plan file with integrated exercise-details section
from pathlib import Path

content = r"""
# Muscle Map Feature — Flutter Implementation Plan (Ironforge)

This plan ports Liftosaur’s muscle-map to Flutter and adds **exercise details page integration**, keeping parity with how the web app lists muscle groups, shows per‑muscle descriptions/images, and (optionally) opens a full muscle map view.

---

## 0) Scope & Deliverables

**Deliverables**
1. Flutter muscle-map renderer (front & back body) with per–muscle-group tinting (opacity 0–1).
2. Data model & normalization utilities for strength/hypertrophy points.
3. Reusable widgets:
   - `MuscleMapView` (standalone map, Strength/Hypertrophy tabs).
   - `MuscleChip` / `MuscleList` (sorted list with percentages & color coding).
   - `MuscleDescriptionSheet` (image + paragraphs with responsive layout).
4. **Exercise details integration** mirroring Liftosaur’s `MuscleGroups` section:
   - Show exercise types, target & synergist groups, and target & synergist muscles.
   - Tap muscle name → open description bottom sheet (mobile) / dialog (large).
   - Optional “Open Muscle Map” action for the current exercise only.
5. Unit/widget tests and sample seeded data.

**Non-Goals (MVP)**
- In-app SVG authoring tools.
- Editing/annotating the SVG assets at runtime beyond fill/opacity injection.

---

## 1) Assets

**Required assets** (under `assets/muscles/`):
- Base silhouettes: `front_body.svg`, `back_body.svg` (with child `<path>` per screen muscle; each path has a stable `id`, e.g., `chest`, `back`, `biceps`, etc.).
- Optional per-region overlays (if you choose image stacking instead of SVG patching): `front_chest.svg`, `front_biceps.svg`, … `back_back.svg`, etc.
- Per–anatomy images for description sheets: `muscle-<dashcase>.jpeg` (e.g., `muscle-deltoid-anterior.jpeg`).

**Acceptance**
- Every screen muscle region has a path with a unique `id`.
- All images referenced in descriptions are present and load on device.

---

## 2) Data Model (Dart)

Create `lib/muscles/models.dart`:

```dart
enum ScreenMuscle {
  shoulders, triceps, back, abs, glutes, hamstrings, quadriceps, chest, biceps, calves, forearms
}

class MuscleDescriptions {
  // Map of full muscle names to paragraphs.
  static const Map<String, List<String>> text = {/* seed with JSON */};
  static String imageUrl(String fullNameDashcase) =>
      "assets/muscles/muscle-$fullNameDashcase.jpeg";
}

class MuscleMapPoints {
  final Map<ScreenMuscle, double> strength;
  final Map<ScreenMuscle, double> hypertrophy;
  MuscleMapPoints({required this.strength, required this.hypertrophy});
}

class ExercisePoints { // per-exercise breakdown (optional display)
  final Map<String, Map<ScreenMuscle, double>> strength;
  final Map<String, Map<ScreenMuscle, double>> hypertrophy;
  ExercisePoints({required this.strength, required this.hypertrophy});
}

class PointsBundle { // identical to Liftosaur IPoints
  final MuscleMapPoints screen;
  final ExercisePoints exercise;
  PointsBundle({required this.screen, required this.exercise});
}
```

Mapping full muscles ↔ screen muscles (static):

```dart
const Map<ScreenMuscle, List<String>> screenToFull = {
  ScreenMuscle.shoulders: ["Deltoid Anterior","Deltoid Lateral","Deltoid Posterior","Infraspinatus","Teres Major","Teres Minor"],
  ScreenMuscle.triceps: ["Triceps Brachii"],
  ScreenMuscle.back: ["Erector Spinae","Latissimus Dorsi","Levator Scapulae","Trapezius Lower Fibers","Trapezius Middle Fibers","Trapezius Upper Fibers","Sternocleidomastoid","Splenius"],
  ScreenMuscle.abs: ["Obliques","Rectus Abdominis","Iliopsoas"],
  ScreenMuscle.glutes: ["Gluteus Maximus","Gluteus Medius","Tensor Fasciae Latae"],
  ScreenMuscle.hamstrings: ["Adductor Magnus","Adductor Brevis","Adductor Longus","Hamstrings"],
  ScreenMuscle.quadriceps: ["Adductor Brevis","Adductor Longus","Pectineous","Quadriceps","Sartorius"],
  ScreenMuscle.chest: ["Pectoralis Major Clavicular Head","Pectoralis Major Sternal Head","Serratus Anterior"],
  ScreenMuscle.biceps: ["Biceps Brachii","Brachialis"],
  ScreenMuscle.calves: ["Gastrocnemius","Soleus","Tibialis Anterior"],
  ScreenMuscle.forearms: ["Brachioradialis","Wrist Extensors","Wrist Flexors"],
};
```

---

## 3) Normalization & Point Math (Dart)

Create `lib/muscles/points_math.dart`:

```dart
import 'models.dart';
import 'dart:math';

Map<ScreenMuscle, double> _normalize(Map<ScreenMuscle, double> src, double maxVal) {
  if (src.isEmpty) return {};
  if (maxVal <= 0) return { for (final k in src.keys) k: 0.0 };
  return { for (final e in src.entries) e.key: (e.value) / maxVal };
}

PointsBundle normalizePoints(PointsBundle p) {
  final maxStrength = p.screen.strength.values.fold<double>(0, max);
  final maxHypertrophy = p.screen.hypertrophy.values.fold<double>(0, max);
  return PointsBundle(
    screen: MuscleMapPoints(
      strength: _normalize(p.screen.strength, maxStrength),
      hypertrophy: _normalize(p.screen.hypertrophy, maxHypertrophy),
    ),
    exercise: ExercisePoints(
      strength: {
        for (final ex in p.exercise.strength.keys)
          ex: _normalize(p.exercise.strength[ex]!, maxStrength)
      },
      hypertrophy: {
        for (final ex in p.exercise.hypertrophy.keys)
          ex: _normalize(p.exercise.hypertrophy[ex]!, maxHypertrophy)
      },
    ),
  );
}

/// Compute points for a single exercise set.
/// If reps >= 8 → hypertrophy; else → strength.
PointsBundle pointsForExercise({
  required String exerciseId,
  required List<String> targetMusclesFullNames,
  required List<String> synergistMusclesFullNames,
  required int reps,
}) {
  const targetPts = 100.0;
  const synergistPts = 30.0;

  Map<ScreenMuscle, double> sm(Map<ScreenMuscle, double> m, ScreenMuscle k, double v) {
    m[k] = (m[k] ?? 0) + v; return m;
  }

  final screenTargets = <ScreenMuscle>{};
  final screenSynergists = <ScreenMuscle>{};
  screenToFull.forEach((smuscle, fulls) {
    if (fulls.any(targetMusclesFullNames.contains)) screenTargets.add(smuscle);
    if (fulls.any(synergistMusclesFullNames.contains)) screenSynergists.add(smuscle);
  });

  final isHyp = reps >= 8;
  final screenStr = <ScreenMuscle, double>{};
  final screenHyp = <ScreenMuscle, double>{};
  final exStr = <String, Map<ScreenMuscle, double>>{};
  final exHyp = <String, Map<ScreenMuscle, double>>{};

  if (isHyp) {
    for (final m in screenTargets) sm(screenHyp, m, targetPts);
    for (final m in screenSynergists) sm(screenHyp, m, synergistPts);
    exHyp[exerciseId] = {...screenHyp};
  } else {
    for (final m in screenTargets) sm(screenStr, m, targetPts);
    for (final m in screenSynergists) sm(screenStr, m, synergistPts);
    exStr[exerciseId] = {...screenStr};
  }

  return PointsBundle(
    screen: MuscleMapPoints(strength: screenStr, hypertrophy: screenHyp),
    exercise: ExercisePoints(strength: exStr, hypertrophy: exHyp),
  );
}
```

---

## 4) Rendering: `MuscleMapView` (Flutter)

Create `lib/muscles/muscle_map_view.dart` that supports **two strategies**:

**A. SVG patching (recommended)**
1. Load SVG string (e.g., `rootBundle.loadString('assets/muscles/front_body.svg')`).
2. Parse XML, find `<path id="...">` per screen muscle, and inject:
   - `fill="#28839F"` (or theme color),
   - `fill-opacity="<0..1>"` from normalized points.
3. Use `SvgPicture.string(modifiedSvg)` (package: `flutter_svg`).

**B. Overlay stacking (fallback)**
1. `Stack(children: [...])` with per‑muscle transparent assets over a base silhouette.
2. Wrap each overlay with `Opacity(opacity: value)` or `ColorFiltered` to tint.

**Props**
- `points: Map<ScreenMuscle, double>` (per view: strength or hypertrophy).
- `orientation: front/back`.
- Optional legend & list toggle.

**Acceptance**
- Inactive muscles show faint base; active muscles tint smoothly (0–1 opacity).
- Switching tabs switches the dataset (strength/hypertrophy).

---

## 5) UI: Tabs & Lists

- Use `DefaultTabController(length: 2)` with “Strength” and “Hypertrophy” tabs.
- Under each tab, show:
  1) `MuscleMapView` (front + back, vertically stacked or paged).
  2) A sorted `ListView` of screen muscles with percentage labels.
     - Percent = `(value / max) * 100` within that tab’s dataset.
     - Color code: high→green, mid→yellow, low→red.

---

## 6) Exercise Details Page Integration (Parity with Liftosaur)

**Goal**: Mirror the web `MuscleGroups` section on Ironforge’s exercise detail page, and (optionally) allow opening the dedicated muscle map for the current exercise.

### 6.1 Data
- From your exercise catalog, expose for each exercise:
  - `types: List<String>` (e.g., “Compound”, “Push”, etc.).
  - `targetMuscleGroups: List<String>` and `synergistMuscleGroups: List<String>`.
  - `targetMusclesFull: List<String>` and `synergistMusclesFull: List<String>` (full names must match `screenToFull` lists).
- Build a small resolver for “screen muscle” chips from `screenToFull` mapping.

### 6.2 Widgets
- `ExerciseMuscleGroupsSection` (column layout):
  - **Exercise image** (optional) at the top.
  - **“Muscle Groups”** header.
  - **Type** list (simple `Wrap` of `Chip` widgets).
  - **Target** group list → tap to filter exercises by that group (optional).
  - **Synergist** group list → same.
  - **Muscles** header.
    - **Target** muscles list.
    - **Synergist** muscles list.
- Each muscle in the list is a `TextButton`/`InkWell`:
  - On tap: `showModalBottomSheet` → `MuscleDescriptionSheet(muscleFullName)`.
  - On large screens: use a `Dialog` instead for a desktop‑like feel.

`MuscleDescriptionSheet`:
- Left: `Image.asset(MuscleDescriptions.imageUrl(dashcase(fullName)))`
- Right: paragraphs from `MuscleDescriptions.text[fullName]`.
- Full width on mobile; constrained width on tablet/desktop.

### 6.3 “Open Muscle Map” for Current Exercise
- Add an icon button in the exercise header (`IconButton(Icons.fitness_center)`):
  - Action: push `ExerciseMuscleMapScreen(exerciseId)` which:
    1. Computes points for the exercise’s *representative set* (use current reps from the UI if available; else default).
       - `pointsForExercise(...)` → returns `PointsBundle` for one set.
    2. Calls `normalizePoints(...)`.
    3. Shows the two tabs (Strength/Hypertrophy) with `MuscleMapView`.
- Optionally list the per‑exercise `%` breakdown under the map for transparency.

### 6.4 Filtering & Navigation (Optional)
- Provide a “Filter by type/group” chip row above the exercise list.
- When a user taps a group chip (e.g., “Back”), navigate to a filtered exercise list view.

### 6.5 Acceptance
- Exercise details page shows Types, Target Groups, Synergist Groups, Target Muscles, Synergist Muscles.
- Tapping a muscle opens the description sheet with image and paragraphs.
- “Open Muscle Map” shows a map reflecting that exercise’s targets/synergists (with 100/30 weighting and Strength/Hypertrophy split by reps).

---

## 7) Navigation, State & Theming

- State: keep `PointsBundle` in a simple provider or pass down via constructors.
- Theming: pull muscle color from theme; support dark mode (adjust base silhouette).
- Accessibility: add semantics labels to muscle names; ensure contrast meet AA.

---

## 8) Testing

- Unit tests for normalization and `pointsForExercise` logic.
- Golden tests for `MuscleMapView` with synthetic inputs (e.g., only `chest` active).
- Widget tests for `MuscleDescriptionSheet` and exercise page interactions.

---

## 9) Build Steps (Checklist)

1. Add `flutter_svg` to `pubspec.yaml`; register `assets/muscles/**`.
2. Create models (`models.dart`) & mapping `screenToFull`.
3. Implement `points_math.dart` (`normalizePoints`, `pointsForExercise`).
4. Implement `MuscleMapView` with SVG patching; add fallback stacking.
5. Build tabs & list UI (Strength/Hypertrophy).
6. Seed `MuscleDescriptions.text` and drop images into assets.
7. Implement `ExerciseMuscleGroupsSection` for exercise screen.
8. Add “Open Muscle Map” flow and route.
9. Tests: unit + widget + goldens.
10. Hook into real exercise data sources.

---

## 10) Future Enhancements

- Tap regions on the SVG to open the description sheet (hit‑testing by path).
- Animate transitions when changing tabs or exercises.
- Persist “last viewed tab” (Strength/Hypertrophy) in user settings.
"""

path = Path("muscle_map_flutter_plan.md")
path.write_text(content, encoding="utf-8")
print(str(path.resolve()))
