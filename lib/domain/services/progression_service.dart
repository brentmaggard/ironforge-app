import '../entities/program.dart';
import '../entities/user_program.dart';
import '../entities/program_session.dart';
import '../entities/workout.dart';
import '../entities/workout_set.dart';

class ProgressionService {
  /// Calculate the weight for an exercise based on progression rules and current week
  static double calculateWeight({
    required ProgramExercise exercise,
    required int currentWeek,
    required int currentDay,
    double? baseWeight,
    double? lastWeight,
    bool? lastSessionSuccessful,
  }) {
    final progression = exercise.progression;
    if (progression == null) {
      return baseWeight ?? 45.0; // Default barbell weight
    }

    // Use base weight or default
    double calculationBase = baseWeight ?? 45.0;

    switch (progression.type) {
      case 'linear':
        return _calculateLinearProgression(
          baseWeight: calculationBase,
          increment: progression.increment,
          currentWeek: currentWeek,
          frequency: 1, // Default frequency
        );

      case 'percentage':
        return _calculatePercentageProgression(
          baseWeight: calculationBase,
          percentage: 100.0, // Default percentage
          currentWeek: currentWeek,
        );

      case 'weekly':
        return _calculateWeeklyProgression(
          baseWeight: calculationBase,
          increment: progression.increment,
          currentWeek: currentWeek,
        );

      case 'session':
        return _calculateSessionProgression(
          baseWeight: calculationBase,
          increment: progression.increment,
          lastWeight: lastWeight,
          lastSessionSuccessful: lastSessionSuccessful ?? true,
        );

      default:
        return calculationBase;
    }
  }

  /// Generate workout for a specific week and day of a program
  static Workout generateWorkout({
    required Program program,
    required UserProgram userProgram,
    required int weekNumber,
    required int dayNumber,
    String? workoutId,
  }) {
    final schedule = program.schedule;
    if (dayNumber > schedule.length) {
      throw ArgumentError('Day $dayNumber exceeds program schedule length');
    }

    final workoutKey = schedule[dayNumber - 1];
    final programWorkout = program.workouts[workoutKey];
    if (programWorkout == null) {
      throw ArgumentError('Workout $workoutKey not found in program');
    }

    final workoutSets = <WorkoutSet>[];
    int setCounter = 1;

    for (final programExercise in programWorkout.exercises) {
      final weight = calculateWeight(
        exercise: programExercise,
        currentWeek: weekNumber,
        currentDay: dayNumber,
        baseWeight: 45.0, // Default starting weight
      );

      // Generate sets for this exercise
      for (int i = 0; i < programExercise.sets.length; i++) {
        final programSet = programExercise.sets[i];
        
        workoutSets.add(WorkoutSet(
          id: 'set_${setCounter}_${DateTime.now().millisecondsSinceEpoch}',
          workoutId: workoutId ?? 'workout_${DateTime.now().millisecondsSinceEpoch}',
          exerciseId: programExercise.exerciseId,
          setNumber: setCounter,
          reps: programSet.targetReps,
          weight: weight,
          rpe: null,
          restSeconds: programExercise.restTime,
          notes: programSet.isAmrap ? 'AMRAP (As Many Reps As Possible)' : null,
          isCompleted: false,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ));
        
        setCounter++;
      }
    }

    return Workout(
      id: workoutId ?? 'workout_${DateTime.now().millisecondsSinceEpoch}',
      userId: userProgram.userId,
      programId: userProgram.programId,
      name: programWorkout.name,
      notes: 'Week $weekNumber, Day $dayNumber - ${programWorkout.name}',
      totalSets: workoutSets.length,
      totalReps: workoutSets.fold(0, (sum, set) => sum + set.reps),
      totalVolume: workoutSets.fold(0.0, (sum, set) => sum + set.volume),
      status: 'planned',
      startedAt: null,
      completedAt: null,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  /// Check if a workout session was successful based on completion criteria
  static bool isSessionSuccessful(List<WorkoutSet> workoutSets) {
    if (workoutSets.isEmpty) return false;

    int completedSets = 0;
    int totalSets = workoutSets.length;

    for (final set in workoutSets) {
      if (set.isCompleted) {
        // Consider successful if completed at least 80% of target reps
        final completionRate = (set.reps / set.reps);
        if (completionRate >= 0.8) {
          completedSets++;
        }
      }
    }

    // Session is successful if at least 80% of sets were completed successfully
    return (completedSets / totalSets) >= 0.8;
  }

  /// Calculate next week's progression based on current performance
  static UserProgram calculateNextWeekProgression(
    UserProgram userProgram,
    List<ProgramSession> completedSessions,
  ) {
    // Simple progression: advance to next week if current week is completed
    int completedSessionsThisWeek = completedSessions
        .where((s) => s.weekNumber == userProgram.currentWeek && s.status == 'completed')
        .length;

    // Assuming 3 sessions per week by default
    int sessionsPerWeek = 3; // This should come from program configuration
    
    if (completedSessionsThisWeek >= sessionsPerWeek) {
      return userProgram.copyWith(
        currentWeek: userProgram.currentWeek + 1,
        currentDay: 1,
        updatedAt: DateTime.now(),
      );
    }

    return userProgram;
  }

  // Private helper methods for different progression types

  static double _calculateLinearProgression({
    required double baseWeight,
    required double increment,
    required int currentWeek,
    required int frequency,
  }) {
    // Linear progression: add increment every week (or based on frequency)
    int progressionCycles = ((currentWeek - 1) / frequency).floor();
    return baseWeight + (increment * progressionCycles);
  }

  static double _calculatePercentageProgression({
    required double baseWeight,
    required double percentage,
    required int currentWeek,
  }) {
    // Percentage-based progression (e.g., 5/3/1 style)
    return baseWeight * (percentage / 100.0);
  }

  static double _calculateWeeklyProgression({
    required double baseWeight,
    required double increment,
    required int currentWeek,
  }) {
    // Add increment every week
    return baseWeight + (increment * (currentWeek - 1));
  }

  static double _calculateSessionProgression({
    required double baseWeight,
    required double increment,
    double? lastWeight,
    required bool lastSessionSuccessful,
  }) {
    // Progress based on last session performance
    double currentWeight = lastWeight ?? baseWeight;
    
    if (lastSessionSuccessful) {
      return currentWeight + increment;
    } else {
      // Deload by 10% if session was not successful
      return currentWeight * 0.9;
    }
  }

  /// Generate a deload week with reduced weights
  static List<WorkoutSet> generateDeloadSets(
    List<WorkoutSet> originalSets,
    double deloadPercentage,
  ) {
    return originalSets.map((set) => set.copyWith(
      weight: set.weight * deloadPercentage,
    )).toList();
  }

  /// Calculate 1RM estimate from workout performance
  static double estimate1RM(double weight, int reps) {
    if (reps <= 0) return weight;
    if (reps == 1) return weight;
    
    // Using Epley formula: 1RM = weight * (1 + reps/30)
    return weight * (1 + reps / 30.0);
  }

  /// Suggest weight based on target reps and estimated 1RM
  static double suggestWeight(double oneRepMax, int targetReps) {
    if (targetReps <= 1) return oneRepMax;
    
    // Reverse Epley formula to find training weight
    return oneRepMax / (1 + targetReps / 30.0);
  }
}