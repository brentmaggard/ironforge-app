# IronForge Muscle Map Implementation Plan

## 🎯 Project Overview

**Goal**: Add Liftosaur-inspired muscle map visualization to IronForge Flutter app with exercise details integration.

**Priority**: This should come after your current **Phase 4.3 Program Builder System** is complete, as it's an enhancement feature that builds on your existing exercise database.

**Estimated Timeline**: 2-3 weeks after Program Builder completion

---

## 📋 Integration Points with Current IronForge Architecture

### Fits Into Existing Structure
- **Domain Layer**: New muscle-related entities
- **Data Layer**: Extend existing exercise models with muscle data
- **Presentation Layer**: New screens and widgets
- **Database**: Extend current exercise schema (Schema v6)

### Dependencies on Current Work
- ✅ **Exercise Database System** (Phase 4.2 - COMPLETED)
- 🔄 **Program Builder System** (Phase 4.3 - IN PROGRESS)
- 📅 **Workout Logging** (Phase 4.4 - PENDING)

---

## 🗂️ Phase 1: Database Schema Extension (Schema v6)

### 1.1 New Tables
```sql
-- Muscle groups and classifications
CREATE TABLE muscle_groups (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL, -- "Chest", "Back", "Shoulders"
  screen_muscle TEXT NOT NULL, -- Maps to ScreenMuscle enum
  created_at DATETIME NOT NULL,
  updated_at DATETIME NOT NULL
);

-- Individual muscles (full anatomical names)
CREATE TABLE muscles (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL, -- "Pectoralis Major Sternal Head"
  muscle_group_id TEXT NOT NULL,
  description TEXT,
  image_path TEXT, -- "assets/muscles/muscle-pectoralis-major.jpeg"
  created_at DATETIME NOT NULL,
  updated_at DATETIME NOT NULL,
  FOREIGN KEY (muscle_group_id) REFERENCES muscle_groups(id)
);

-- Exercise muscle targeting
CREATE TABLE exercise_muscles (
  id TEXT PRIMARY KEY,
  exercise_id TEXT NOT NULL,
  muscle_id TEXT NOT NULL,
  role TEXT CHECK (role IN ('target', 'synergist')) NOT NULL,
  activation_level INTEGER DEFAULT 100, -- 100 for target, 30 for synergist
  created_at DATETIME NOT NULL,
  updated_at DATETIME NOT NULL,
  FOREIGN KEY (exercise_id) REFERENCES exercises(id),
  FOREIGN KEY (muscle_id) REFERENCES muscles(id),
  UNIQUE(exercise_id, muscle_id, role)
);
```

### 1.2 Extend Existing Exercise Table
```sql
-- Add muscle-related fields to exercises table
ALTER TABLE exercises ADD COLUMN exercise_types JSON; -- ["Compound", "Push", "Upper Body"]
ALTER TABLE exercises ADD COLUMN target_muscle_groups JSON; -- Screen muscle groups
ALTER TABLE exercises ADD COLUMN synergist_muscle_groups JSON; -- Secondary groups
```

---

## 📁 Phase 2: Asset Preparation & Setup

### 2.1 Asset Structure
```
assets/
└── muscles/
    ├── body/
    │   ├── front_body.svg
    │   └── back_body.svg
    └── anatomy/
        ├── muscle-chest.jpeg
        ├── muscle-back.jpeg
        ├── muscle-shoulders.jpeg
        ├── muscle-biceps.jpeg
        ├── muscle-triceps.jpeg
        ├── muscle-abs.jpeg
        ├── muscle-quadriceps.jpeg
        ├── muscle-hamstrings.jpeg
        ├── muscle-glutes.jpeg
        ├── muscle-calves.jpeg
        └── muscle-forearms.jpeg
```

### 2.2 Update pubspec.yaml
```yaml
dependencies:
  flutter_svg: ^2.0.9
  xml: ^6.4.2

flutter:
  assets:
    - assets/muscles/body/
    - assets/muscles/anatomy/
```

---

## 🏗️ Phase 3: Data Models & Architecture

### 3.1 Domain Entities
```dart
// lib/domain/entities/muscle.dart
class Muscle {
  final String id;
  final String name;
  final String muscleGroupId;
  final String? description;
  final String? imagePath;
  final DateTime createdAt;
  final DateTime updatedAt;
}

// lib/domain/entities/muscle_group.dart
class MuscleGroup {
  final String id;
  final String name;
  final ScreenMuscle screenMuscle;
  final DateTime createdAt;
  final DateTime updatedAt;
}

// lib/domain/entities/exercise_muscle.dart
class ExerciseMuscle {
  final String id;
  final String exerciseId;
  final String muscleId;
  final MuscleRole role; // target, synergist
  final int activationLevel;
}

enum MuscleRole { target, synergist }
enum ScreenMuscle {
  shoulders, triceps, back, abs, glutes, hamstrings, 
  quadriceps, chest, biceps, calves, forearms
}
```

### 3.2 Extend Exercise Entity
```dart
// Update lib/domain/entities/exercise.dart
class Exercise {
  // ... existing fields
  final List<String>? exerciseTypes;
  final List<String>? targetMuscleGroups;
  final List<String>? synergistMuscleGroups;
  
  // Add convenience getters
  List<Muscle> get targetMuscles => _targetMuscles ?? [];
  List<Muscle> get synergistMuscles => _synergistMuscles ?? [];
}
```

---

## 🌱 Phase 4: Seed Data Creation

### 4.1 Muscle Groups Seed Data
```dart
// lib/data/datasources/muscle_seeder.dart
class MuscleSeeder {
  static final List<MuscleGroup> muscleGroups = [
    MuscleGroup(
      id: 'chest',
      name: 'Chest',
      screenMuscle: ScreenMuscle.chest,
    ),
    MuscleGroup(
      id: 'back',
      name: 'Back',
      screenMuscle: ScreenMuscle.back,
    ),
    // ... complete list for all 11 screen muscles
  ];

  static final List<Muscle> muscles = [
    // Chest muscles
    Muscle(
      id: 'pectoralis-major-sternal',
      name: 'Pectoralis Major Sternal Head',
      muscleGroupId: 'chest',
      description: 'The lower portion of the chest muscle...',
      imagePath: 'assets/muscles/anatomy/muscle-chest.jpeg',
    ),
    Muscle(
      id: 'pectoralis-major-clavicular',
      name: 'Pectoralis Major Clavicular Head',
      muscleGroupId: 'chest',
      description: 'The upper portion of the chest muscle...',
      imagePath: 'assets/muscles/anatomy/muscle-chest.jpeg',
    ),
    // ... complete anatomical muscle list (50+ muscles)
  ];
}
```

### 4.2 Exercise-Muscle Mappings
```dart
// Based on your existing 52 exercises, create mappings
class ExerciseMuscleSeeder {
  static final Map<String, ExerciseMuscleMapping> exerciseMappings = {
    'bench_press': ExerciseMuscleMapping(
      exerciseTypes: ['Compound', 'Push', 'Upper Body'],
      targetMuscles: ['pectoralis-major-sternal', 'pectoralis-major-clavicular'],
      synergistMuscles: ['deltoid-anterior', 'triceps-brachii'],
      targetMuscleGroups: ['chest'],
      synergistMuscleGroups: ['shoulders', 'triceps'],
    ),
    'bent_over_row': ExerciseMuscleMapping(
      exerciseTypes: ['Compound', 'Pull', 'Upper Body'],
      targetMuscles: ['latissimus-dorsi', 'trapezius-middle'],
      synergistMuscles: ['biceps-brachii', 'deltoid-posterior'],
      targetMuscleGroups: ['back'],
      synergistMuscleGroups: ['biceps', 'shoulders'],
    ),
    // ... mappings for all 52 exercises
  };
}
```

---

## 🎨 Phase 5: Core Muscle Map Components

### 5.1 Muscle Map Models
```dart
// lib/presentation/muscles/models/muscle_map_models.dart
class MuscleMapPoints {
  final Map<ScreenMuscle, double> strength;
  final Map<ScreenMuscle, double> hypertrophy;

  MuscleMapPoints({
    required this.strength,
    required this.hypertrophy,
  });
}

class ExercisePoints {
  final Map<String, Map<ScreenMuscle, double>> strength;
  final Map<String, Map<ScreenMuscle, double>> hypertrophy;

  ExercisePoints({
    required this.strength,
    required this.hypertrophy,
  });
}

class PointsBundle {
  final MuscleMapPoints screen;
  final ExercisePoints exercise;

  PointsBundle({
    required this.screen,
    required this.exercise,
  });
}
```

### 5.2 Points Calculation Logic
```dart
// lib/presentation/muscles/utils/points_calculator.dart
class PointsCalculator {
  static const double targetPoints = 100.0;
  static const double synergistPoints = 30.0;

  static PointsBundle calculateExercisePoints({
    required Exercise exercise,
    required int reps,
  }) {
    final isHypertrophy = reps >= 8;
    
    // Calculate screen muscle activation
    final Map<ScreenMuscle, double> strengthMap = {};
    final Map<ScreenMuscle, double> hypertrophyMap = {};
    
    // Add target muscle points
    for (final group in exercise.targetMuscleGroups ?? []) {
      final screenMuscle = _stringToScreenMuscle(group);
      if (screenMuscle != null) {
        if (isHypertrophy) {
          hypertrophyMap[screenMuscle] = (hypertrophyMap[screenMuscle] ?? 0) + targetPoints;
        } else {
          strengthMap[screenMuscle] = (strengthMap[screenMuscle] ?? 0) + targetPoints;
        }
      }
    }
    
    // Add synergist muscle points
    for (final group in exercise.synergistMuscleGroups ?? []) {
      final screenMuscle = _stringToScreenMuscle(group);
      if (screenMuscle != null) {
        if (isHypertrophy) {
          hypertrophyMap[screenMuscle] = (hypertrophyMap[screenMuscle] ?? 0) + synergistPoints;
        } else {
          strengthMap[screenMuscle] = (strengthMap[screenMuscle] ?? 0) + synergistPoints;
        }
      }
    }
    
    return PointsBundle(
      screen: MuscleMapPoints(
        strength: strengthMap,
        hypertrophy: hypertrophyMap,
      ),
      exercise: ExercisePoints(
        strength: {exercise.id: strengthMap},
        hypertrophy: {exercise.id: hypertrophyMap},
      ),
    );
  }

  static PointsBundle normalizePoints(PointsBundle points) {
    // Normalization logic (0-1 scale)
    // Implementation matches the provided spec
  }
}
```

### 5.3 Muscle Map View Widget
```dart
// lib/presentation/muscles/widgets/muscle_map_view.dart
class MuscleMapView extends StatelessWidget {
  final Map<ScreenMuscle, double> points;
  final MuscleMapOrientation orientation;
  final bool showLegend;

  const MuscleMapView({
    Key? key,
    required this.points,
    required this.orientation,
    this.showLegend = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: _buildSvgMuscleMap(context),
        ),
        if (showLegend) _buildLegend(context),
      ],
    );
  }

  Widget _buildSvgMuscleMap(BuildContext context) {
    return FutureBuilder<String>(
      future: _loadAndModifySvg(context),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SvgPicture.string(
            snapshot.data!,
            fit: BoxFit.contain,
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }

  Future<String> _loadAndModifySvg(BuildContext context) async {
    final svgPath = orientation == MuscleMapOrientation.front
        ? 'assets/muscles/body/front_body.svg'
        : 'assets/muscles/body/back_body.svg';
    
    final svgString = await rootBundle.loadString(svgPath);
    return _injectMuscleColors(svgString);
  }

  String _injectMuscleColors(String svgString) {
    // Parse SVG and inject fill/opacity for each muscle
    // Implementation uses xml package to modify <path> elements
  }
}

enum MuscleMapOrientation { front, back }
```

---

## 🔗 Phase 6: Exercise Details Integration

### 6.1 Exercise Muscle Groups Section
```dart
// lib/presentation/exercises/widgets/exercise_muscle_groups_section.dart
class ExerciseMuscleGroupsSection extends ConsumerWidget {
  final Exercise exercise;

  const ExerciseMuscleGroupsSection({
    Key? key,
    required this.exercise,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(context),
            const SizedBox(height: 12),
            _buildExerciseTypes(context),
            const SizedBox(height: 16),
            _buildMuscleGroups(context),
            const SizedBox(height: 16),
            _buildMuscles(context, ref),
            const SizedBox(height: 16),
            _buildMuscleMapButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildMuscles(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Muscles',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        _buildMuscleList(
          context,
          ref,
          'Target',
          exercise.targetMuscles,
          Colors.green,
        ),
        const SizedBox(height: 8),
        _buildMuscleList(
          context,
          ref,
          'Synergist',
          exercise.synergistMuscles,
          Colors.orange,
        ),
      ],
    );
  }

  Widget _buildMuscleList(
    BuildContext context,
    WidgetRef ref,
    String label,
    List<Muscle> muscles,
    Color color,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label:', style: Theme.of(context).textTheme.bodySmall),
        Wrap(
          spacing: 8,
          children: muscles.map((muscle) {
            return ActionChip(
              label: Text(muscle.name),
              backgroundColor: color.withOpacity(0.1),
              onPressed: () => _showMuscleDescription(context, muscle),
            );
          }).toList(),
        ),
      ],
    );
  }

  void _showMuscleDescription(BuildContext context, Muscle muscle) {
    if (MediaQuery.of(context).size.width > 600) {
      // Desktop/tablet - show dialog
      showDialog(
        context: context,
        builder: (context) => MuscleDescriptionDialog(muscle: muscle),
      );
    } else {
      // Mobile - show bottom sheet
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => MuscleDescriptionSheet(muscle: muscle),
      );
    }
  }

  Widget _buildMuscleMapButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () => _openMuscleMap(context),
        icon: const Icon(Icons.fitness_center),
        label: const Text('View Muscle Map'),
      ),
    );
  }

  void _openMuscleMap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ExerciseMuscleMapScreen(exercise: exercise),
      ),
    );
  }
}
```

### 6.2 Muscle Description Components
```dart
// lib/presentation/muscles/widgets/muscle_description_sheet.dart
class MuscleDescriptionSheet extends StatelessWidget {
  final Muscle muscle;

  const MuscleDescriptionSheet({
    Key? key,
    required this.muscle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      maxChildSize: 0.9,
      minChildSize: 0.3,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            children: [
              _buildHandle(),
              _buildHeader(context),
              Expanded(
                child: _buildContent(context, scrollController),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildContent(BuildContext context, ScrollController scrollController) {
    return SingleChildScrollView(
      controller: scrollController,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (muscle.imagePath != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                muscle.imagePath!,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          const SizedBox(height: 16),
          if (muscle.description != null)
            Text(
              muscle.description!,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
        ],
      ),
    );
  }
}
```

---

## 🧪 Phase 7: Testing & Quality

### 7.1 Unit Tests
```dart
// test/presentation/muscles/utils/points_calculator_test.dart
void main() {
  group('PointsCalculator', () {
    test('should calculate strength points for low reps', () {
      final exercise = _createTestExercise();
      final result = PointsCalculator.calculateExercisePoints(
        exercise: exercise,
        reps: 5,
      );
      
      expect(result.screen.strength[ScreenMuscle.chest], equals(100.0));
      expect(result.screen.hypertrophy[ScreenMuscle.chest], equals(0.0));
    });

    test('should calculate hypertrophy points for high reps', () {
      final exercise = _createTestExercise();
      final result = PointsCalculator.calculateExercisePoints(
        exercise: exercise,
        reps: 12,
      );
      
      expect(result.screen.hypertrophy[ScreenMuscle.chest], equals(100.0));
      expect(result.screen.strength[ScreenMuscle.chest], equals(0.0));
    });
  });
}
```

### 7.2 Widget Tests
```dart
// test/presentation/muscles/widgets/muscle_map_view_test.dart
void main() {
  testWidgets('MuscleMapView should render muscle map', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: MuscleMapView(
          points: {ScreenMuscle.chest: 0.8},
          orientation: MuscleMapOrientation.front,
        ),
      ),
    );

    expect(find.byType(SvgPicture), findsOneWidget);
  });
}
```

---

## 📅 Implementation Timeline

### Week 1: Foundation
- **Days 1-2**: Database schema migration (v6)
- **Days 3-4**: Domain entities and data models
- **Days 5-7**: Asset preparation and seeding system

### Week 2: Core Components
- **Days 1-3**: Muscle map rendering (SVG patching)
- **Days 4-5**: Points calculation logic
- **Days 6-7**: Basic muscle map UI with tabs

### Week 3: Integration & Polish
- **Days 1-3**: Exercise details integration
- **Days 4-5**: Muscle description sheets
- **Days 6-7**: Testing and refinements

---

## 🔧 Development Commands

```bash
# Add new dependencies
flutter pub add flutter_svg xml

# Generate database code after schema changes
dart run build_runner build --delete-conflicting-outputs

# Run muscle map specific tests
flutter test test/presentation/muscles/

# Run with assets
flutter run --debug
```

---

## 🎯 Success Criteria

### MVP Requirements
- ✅ Muscle map renders with proper color coding (0-1 opacity)
- ✅ Strength/Hypertrophy tabs switch datasets correctly
- ✅ Exercise details show muscle groups and individual muscles
- ✅ Tapping muscles opens description sheets
- ✅ "View Muscle Map" opens exercise-specific visualization
- ✅ All 52 existing exercises have muscle mappings

### Future Enhancements
- Interactive SVG tap detection for muscle regions
- Animated transitions between tabs
- Workout-based muscle activation tracking
- Progress tracking over time

---

## 💡 Integration Notes

This muscle map system integrates perfectly with your existing IronForge architecture:

1. **Extends Current Exercise System**: Builds on your completed Phase 4.2 exercise database
2. **Complements Program Builder**: Will enhance your upcoming Phase 4.3 program visualization  
3. **Enhances Workout Logging**: Future integration with Phase 4.4 for real-time muscle tracking
4. **Fits Clean Architecture**: Follows your established domain/data/presentation patterns
5. **Material 3 Compliant**: Matches your existing UI design system

The muscle map becomes a powerful tool for users to understand exercise selection and program design within your comprehensive fitness tracking ecosystem!