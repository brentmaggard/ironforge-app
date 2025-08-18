/// Screen-level muscle groups for simplified muscle map visualization
enum ScreenMuscle {
  chest('chest', 'Chest'),
  back('back', 'Back'),
  shoulders('shoulders', 'Shoulders'),
  biceps('biceps', 'Biceps'),
  triceps('triceps', 'Triceps'),
  abs('abs', 'Abs'),
  quadriceps('quadriceps', 'Quadriceps'),
  hamstrings('hamstrings', 'Hamstrings'),
  glutes('glutes', 'Glutes'),
  calves('calves', 'Calves'),
  forearms('forearms', 'Forearms');

  const ScreenMuscle(this.id, this.displayName);

  final String id;
  final String displayName;

  /// Convert string to ScreenMuscle enum
  static ScreenMuscle? fromString(String value) {
    for (final muscle in ScreenMuscle.values) {
      if (muscle.id == value.toLowerCase()) {
        return muscle;
      }
    }
    return null;
  }

  /// Get all muscle group IDs as a list
  static List<String> get allIds => ScreenMuscle.values.map((m) => m.id).toList();

  /// Get all muscle group display names as a list
  static List<String> get allDisplayNames => ScreenMuscle.values.map((m) => m.displayName).toList();
}

/// Muscle activation points for a single exercise
class MuscleActivation {
  final Map<ScreenMuscle, double> targetMuscles;
  final Map<ScreenMuscle, double> synergistMuscles;

  const MuscleActivation({
    required this.targetMuscles,
    required this.synergistMuscles,
  });

  /// Get all activated muscles with their intensity levels
  Map<ScreenMuscle, double> get allActivations {
    final combined = <ScreenMuscle, double>{};
    combined.addAll(targetMuscles);
    
    // Add synergist muscles, but don't override if target muscle already exists
    for (final entry in synergistMuscles.entries) {
      if (!combined.containsKey(entry.key)) {
        combined[entry.key] = entry.value;
      }
    }
    
    return combined;
  }

  /// Check if a muscle is activated (either target or synergist)
  bool isActivated(ScreenMuscle muscle) {
    return targetMuscles.containsKey(muscle) || synergistMuscles.containsKey(muscle);
  }

  /// Get activation level for a specific muscle (0.0 if not activated)
  double getActivationLevel(ScreenMuscle muscle) {
    if (targetMuscles.containsKey(muscle)) {
      return targetMuscles[muscle]!;
    }
    if (synergistMuscles.containsKey(muscle)) {
      return synergistMuscles[muscle]!;
    }
    return 0.0;
  }
}