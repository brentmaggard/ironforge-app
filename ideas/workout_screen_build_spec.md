
# Workout Screen — Build Spec (No Colors/Themes)

**Goal:** Implement the workout logging screen shown in the reference screenshot. Follow these instructions exactly but **inherit all colors, typography, and spacing from the app’s current theme**. This spec defines layout, states, behaviors, data model, and QA checks so an engineer or agent can ship the screen end‑to‑end.

---

## 1) Screen Overview

- **Route name:** `WorkoutSessionScreen`
- **Initial state:** Active session running; elapsed timer starts automatically.
- **Primary entities:** `WorkoutSession`, `ExerciseBlock` (e.g., Bench Press), `SetEntry`
- **Primary interactions:**
  - Start/Pause/Resume timer
  - Edit weight and reps for each set (warm-up & working)
  - Toggle units (lb/kg) during entry
  - Use plate/weight helper during entry
  - Add/remove/reorder sets
  - Expand/collapse Warm-up group
  - Overflow actions per set and per exercise
  - Complete/Exit session with confirmation

---

## 2) Layout & Component Hierarchy

```
SafeAreaView
└─ ScreenContainer (scrollable; vertical)
   ├─ TopActionBar
   │  ├─ LeadingCloseButton (icon: X)
   │  ├─ TitleArea
   │  │  ├─ WorkoutName (e.g., "JN - Push")
   │  │  └─ ElapsedTimer (hh:mm:ss)
   │  ├─ ActionCluster
   │  │  ├─ PauseResumeButton (toggle)
   │  │  ├─ SessionSettingsButton (gear)
   │  │  └─ CompleteButton (checkmark)
   ├─ ExerciseCard (repeat for each exercise in the block order)
   │  ├─ CardHeader
   │  │  ├─ ExerciseTitle (e.g., "Bench Press")
   │  │  └─ ExerciseHelpButton (? icon)
   │  ├─ WarmupGroup (collapsible)
   │  │  ├─ GroupHeader ("Warm-up" + add button)
   │  │  └─ WarmupSetRow[] (0..n)
   │  └─ WorkingSetList
   │     └─ SetRow[] (1..n)
   └─ BottomSafeSpacer
```

**SetRow / WarmupSetRow anatomy**

```
SetRow
├─ LeftIcon
│  ├─ Warm-up: stretching/figure icon
│  └─ Working: circular numbered badge (1,2,3,...)
├─ WeightField (read-only chip; tap to edit)
│  └─ value like "235 lb"
├─ RepsField (read-only chip; tap to edit)
│  └─ value like "8 reps"
└─ RowOverflowMenu (⋮)
```

---

## 3) Bottom Sheet: Numeric Entry

**Component:** `WeightRepsBottomSheet`

- **Trigger:** Tap `WeightField` or `RepsField` on any row.
- **Presentation:** Modal bottom sheet over the screen; dismiss with swipe down, system back, or Done.
- **Sections:**
  1. **Accessory Bar**
     - **PlateHelperToggle** (compact barbell/plate icon control)
     - **UnitSwitcher** with two states `lb` and `kg`. Switching converts value using `1 kg = 2.20462262185 lb` and rounds via the app’s rounding rule (see §6).
     - **DoneButton**
  2. **Keypad**
     - Numeric keypad `0–9` with decimal point and backspace.
     - Updates a focused field:
       - If launched from WeightField ⇒ focus `weight`.
       - If launched from RepsField ⇒ focus `reps` (integer only; decimal disabled).

**Behavior:**
- Input is appended left-to-right; backspace removes last char.
- Weight accepts decimal to one place (configurable). Reps accepts integers (≥ 0).
- `Done` commits, validates, persists, and closes.

---

## 4) Data Model

```ts
type Unit = 'lb' | 'kg';

type SetEntry = {
  id: string;
  kind: 'warmup' | 'working';
  order: number;          // 1-based for working sets
  weight: number | null;  // stored in session.unit (see WorkoutSession.unit)
  reps: number | null;    // allow 0 to record failed or attempted sets
  completedAt?: string;   // ISO timestamp when user taps 'complete' (optional future)
  notes?: string;
};

type ExerciseBlock = {
  id: string;
  name: string;           // "Bench Press"
  helpUrl?: string;
  warmups: SetEntry[];    // kind='warmup'
  sets: SetEntry[];       // kind='working'
  isWarmupCollapsed: boolean;
};

type WorkoutSession = {
  id: string;
  title: string;          // "JN - Push"
  startedAt: string;      // ISO
  elapsedMs: number;      // timer storage when paused/resumed
  isPaused: boolean;
  unit: Unit;             // global unit for display/input; stored values use this unit
  exercises: ExerciseBlock[];
};
```

---

## 5) State Machine — Timer

```
IDLE → (open screen) → RUNNING
RUNNING → (Pause button) → PAUSED  [freeze elapsed; remember last tick]
PAUSED  → (Resume button) → RUNNING [continue]
Any     → (Complete or Close) → ConfirmDialog
```

- Timer updates every 1 second; avoid drift by computing `now - startedAt - pausedDuration`.
- Persist state on app background/foreground transitions.

---

## 6) Units, Rounding, and Plate Math

- **Canonical unit:** `WorkoutSession.unit`. All weights are stored in that unit.
- **Toggling unit in bottom sheet:**
  - Convert current typed value immediately using factor **2.20462262185**.
  - **Rounding:** round to nearest `2.5 lb` or `1 kg` *only when using PlateHelper apply*. Otherwise keep numeric precision user entered.
- **Plate Helper (optional, but shown in UI):**
  - Visual plate stack control that suggests the nearest achievable weight using the configured barbell weight and available plate pairs.
  - Config:
    - `barbellWeight`: default 45 lb / 20 kg based on unit
    - `availablePlates`: user profile (pairs) e.g., [45, 35, 25, 10, 5, 2.5] in lb; [25, 20, 15, 10, 5, 2.5, 1.25] in kg
  - When engaged, compute per-side plates and return an exact load; write that value into `WeightField`.
  - If requested load < barbell weight, clamp to barbell weight.
  - If exact match not possible, suggest nearest lower achievable weight.

---

## 7) Interactions & Gestures

- **Tap WeightField/RepsField:** open bottom sheet focused on that field.
- **Long-press SetRow:** quick actions (Edit, Duplicate, Delete, Mark complete, Add note).
- **Swipe left on SetRow (optional):** reveal Delete.
- **Warm-up group header Add (+):** append a new warm-up set.
- **Overflow (⋮) per row:** same actions as long-press.
- **Complete button (✓):**
  - If any `weight` or `reps` are `null`, show confirm dialog:
    - Title: “Finish workout?”
    - Copy: “Some sets are incomplete. You can finish now or go back to fill them in.”
    - Actions: `Finish`, `Go back`
  - On confirm: persist, stop timer, navigate to summary.

---

## 8) Validation Rules

- Reps: integer ≥ 0. (Allow `0` to log attempts/failures; show it plainly in the row.)
- Weight: number ≥ 0. Supports one decimal place max by default.
- When unit is switched, convert numeric values; don’t zero them.
- Reject NaN and extremely large values (> 2000 lb / 900 kg) with inline error banner in bottom sheet.

---

## 9) Accessibility

- **Focus order:** TopActionBar → Exercise title → Warm-up header → rows (top to bottom).
- **Labels:**
  - Close: “Discard and exit”
  - Pause/Resume: “Pause timer” / “Resume timer”
  - Complete: “Finish workout”
  - Set row example: “Set 2, 235 pounds, 8 reps, button to edit”
  - Unit switcher: “Units, selected pounds/kilograms”
- All tappable targets ≥ 44×44 dp.
- Dynamic type: text scales with system setting; chips grow accordingly.
- VoiceOver/TalkBack readouts update when timer changes once per 5 seconds to reduce verbosity.

---

## 10) Performance & Persistence

- **Autosave** on every field commit and when app goes to background.
- Local store: `workout_sessions/{sessionId}.json` or app’s DB table.
- Debounce heavy writes (>1/second).
- Use virtualization if set count exceeds 30 rows.

---

## 11) Error & Empty States

- **No exercises:** show centered message “No exercises added yet” and action “Add exercise”.
- **Network loss (if cloud sync):** continue offline; queue sync.
- **Entry errors:** show inline helper text in the bottom sheet until corrected.

---

## 12) QA Checklist (Acceptance Criteria)

1. Opening a session starts the timer and shows “JN - Push” with `hh:mm:ss`.
2. Pause toggles to Resume and freezes time; Resume continues seamlessly.
3. Warm-up section can be collapsed/expanded; state persists during the session.
4. Tapping weight on Set 1 opens bottom sheet with keypad and `lb|kg` unit switcher and a plate helper control.
5. Switching `lb ↔ kg` converts the current value correctly.
6. `Done` commits new value to the correct set and closes the sheet.
7. Reps allow `0`; UI shows `0 reps` exactly as typed.
8. Long-press on a row surfaces actions including Delete; Delete removes the row after confirmation.
9. Pressing ✓ prompts if incomplete sets exist; finishing saves and navigates to summary.
10. All elements are accessible and meet hit target sizes.
11. Typography, spacing, and colors are **inherited from the app theme**; no hardcoded palette.

---

## 13) Example API (Pseudo)

```tsx
// React Native-like pseudocode
<WorkoutSessionScreen sessionId={id}>
  <TopActionBar
    title={session.title}
    elapsedMs={elapsed}
    paused={session.isPaused}
    onPauseToggle={togglePause}
    onClose={confirmExit}
    onComplete={attemptComplete}
    onSettings={openSettings}
  />
  {session.exercises.map(block => (
    <ExerciseCard key={block.id} title={block.name} helpUrl={block.helpUrl}>
      <WarmupGroup
        collapsed={block.isWarmupCollapsed}
        onToggle={() => toggleWarmup(block.id)}
        onAdd={() => appendWarmup(block.id)}
        rows={block.warmups}
        onEdit={openBottomSheet}
      />
      <WorkingSetList
        rows={block.sets}
        onEdit={openBottomSheet}
        onLongPress={openRowActions}
      />
    </ExerciseCard>
  ))}
  <WeightRepsBottomSheet
    visible={sheet.visible}
    field={sheet.field}        // 'weight' | 'reps'
    value={sheet.value}
    unit={session.unit}
    onChange={setSheetValue}
    onToggleUnit={setSessionUnit}
    onApply={commitValue}
  />
</WorkoutSessionScreen>
```

---

## 14) Analytics (Optional)

- `workout.timer.pause`, `workout.timer.resume`
- `workout.set.edit` with `{exercise, setOrder, field}`
- `workout.unit.toggle` with `{from, to}`
- `workout.complete` with `{incompleteSets}`

---

## 15) Notes

- Do **not** hardcode any colors or themes; use design tokens or theme variables.
- Respect safe areas and insets on devices with notches/home indicators.
- Keep the bottom sheet above the keyboard; keypad is custom within the sheet (do not trigger OS numeric keyboard).
