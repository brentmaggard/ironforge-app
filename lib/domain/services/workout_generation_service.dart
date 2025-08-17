import '../entities/program.dart';
import '../entities/user_program.dart';
import '../entities/workout.dart';
import '../entities/workout_set.dart';
import '../repositories/program_repository.dart';
import '../repositories/user_program_repository.dart';
import '../repositories/workout_repository.dart';
import 'progression_service.dart';

class WorkoutGenerationService {
  final ProgramRepository _programRepository;
  final UserProgramRepository _userProgramRepository;
  final WorkoutRepository _workoutRepository;

  WorkoutGenerationService(
    this._programRepository,
    this._userProgramRepository,
    this._workoutRepository,
  );

  /// Generate the next workout for a user program
  Future<Workout> generateNextWorkout(String userProgramId) async {
    final userProgram = await _userProgramRepository.getUserProgramById(userProgramId);
    if (userProgram == null) {
      throw ArgumentError('UserProgram not found: $userProgramId');
    }

    final program = await _programRepository.getProgramById(userProgram.programId);
    if (program == null) {
      throw ArgumentError('Program not found: ${userProgram.programId}');
    }

    // Get user's workout history for progression calculations
    final workoutHistory = await _workoutRepository.getWorkoutsByUserId(userProgram.userId);
    final userWorkoutHistory = workoutHistory
        .where((w) => w.programId == userProgram.programId)
        .toList();

    return _generateWorkoutForWeekAndDay(
      program: program,
      userProgram: userProgram,
      weekNumber: userProgram.currentWeek,
      dayNumber: userProgram.currentDay,
      workoutHistory: userWorkoutHistory,
    );
  }

  /// Generate a specific workout for a given week and day
  Future<Workout> generateWorkoutForWeekAndDay({
    required String userProgramId,
    required int weekNumber,
    required int dayNumber,
  }) async {
    final userProgram = await _userProgramRepository.getUserProgramById(userProgramId);
    if (userProgram == null) {
      throw ArgumentError('UserProgram not found: $userProgramId');
    }

    final program = await _programRepository.getProgramById(userProgram.programId);
    if (program == null) {
      throw ArgumentError('Program not found: ${userProgram.programId}');
    }

    final workoutHistory = await _workoutRepository.getWorkoutsByUserId(userProgram.userId);
    final userWorkoutHistory = workoutHistory
        .where((w) => w.programId == userProgram.programId)
        .toList();

    return _generateWorkoutForWeekAndDay(
      program: program,
      userProgram: userProgram,
      weekNumber: weekNumber,
      dayNumber: dayNumber,
      workoutHistory: userWorkoutHistory,
    );
  }

  /// Start a workout session and mark as in progress
  Future<Workout> startWorkoutSession(String workoutId) async {
    final workout = await _workoutRepository.getWorkoutById(workoutId);
    if (workout == null) {
      throw ArgumentError('Workout not found: $workoutId');
    }

    final updatedWorkout = workout.copyWith(
      status: 'in_progress',
      startedAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await _workoutRepository.updateWorkout(updatedWorkout);
    return updatedWorkout;
  }

  /// Complete a workout session and calculate progression
  Future<Workout> completeWorkoutSession(
    String workoutId,
    List<WorkoutSet> completedSets,
  ) async {
    final workout = await _workoutRepository.getWorkoutById(workoutId);
    if (workout == null) {
      throw ArgumentError('Workout not found: $workoutId');
    }

    // Update workout status
    final completedWorkout = workout.copyWith(
      status: 'completed',
      completedAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await _workoutRepository.updateWorkout(completedWorkout);

    // Calculate if session was successful for progression
    final sessionSuccessful = ProgressionService.isSessionSuccessful(completedSets);

    // Update user program progression if needed
    if (workout.programId != null) {
      await _updateUserProgramProgression(workout.userId, workout.programId!, sessionSuccessful);
    }

    return completedWorkout;
  }

  /// Generate a preview of upcoming workouts for a user program
  Future<List<Workout>> generateUpcomingWorkouts(
    String userProgramId, {
    int count = 7,
  }) async {
    final userProgram = await _userProgramRepository.getUserProgramById(userProgramId);
    if (userProgram == null) {
      throw ArgumentError('UserProgram not found: $userProgramId');
    }

    final program = await _programRepository.getProgramById(userProgram.programId);
    if (program == null) {
      throw ArgumentError('Program not found: ${userProgram.programId}');
    }

    final workoutHistory = await _workoutRepository.getWorkoutsByUserId(userProgram.userId);
    final userWorkoutHistory = workoutHistory
        .where((w) => w.programId == userProgram.programId)
        .toList();

    final upcomingWorkouts = <Workout>[];
    int currentWeek = userProgram.currentWeek;
    int currentDay = userProgram.currentDay;

    for (int i = 0; i < count; i++) {
      try {
        final workout = _generateWorkoutForWeekAndDay(
          program: program,
          userProgram: userProgram,
          weekNumber: currentWeek,
          dayNumber: currentDay,
          workoutHistory: userWorkoutHistory,
        );
        
        upcomingWorkouts.add(workout);

        // Advance to next day
        currentDay++;
        if (currentDay > program.schedule.length) {
          currentDay = 1;
          currentWeek++;
        }

        // Stop if we exceed program duration
        if (program.durationWeeks != null && currentWeek > program.durationWeeks!) {
          break;
        }
      } catch (e) {
        // Stop if we can't generate more workouts
        break;
      }
    }

    return upcomingWorkouts;
  }

  // Private helper methods

  Workout _generateWorkoutForWeekAndDay({
    required Program program,
    required UserProgram userProgram,
    required int weekNumber,
    required int dayNumber,
    required List<Workout> workoutHistory,
  }) {
    final schedule = program.schedule;
    if (dayNumber > schedule.length) {
      throw ArgumentError('Day $dayNumber exceeds program schedule length (${schedule.length})');
    }

    final workoutKey = schedule[dayNumber - 1];
    final programWorkout = program.workouts[workoutKey];
    if (programWorkout == null) {
      throw ArgumentError('Workout $workoutKey not found in program');
    }

    final workoutId = 'workout_${userProgram.id}_w${weekNumber}_d${dayNumber}';
    final workoutSets = <WorkoutSet>[];
    int setCounter = 1;

    for (final programExercise in programWorkout.exercises) {
      // Get last performance for this exercise
      final lastPerformance = _getLastPerformanceForExercise(
        workoutHistory,
        programExercise.exerciseId,
      );

      final weight = ProgressionService.calculateWeight(
        exercise: programExercise,
        currentWeek: weekNumber,
        currentDay: dayNumber,
        baseWeight: 45.0, // Default starting weight
        lastWeight: lastPerformance?.weight,
        lastSessionSuccessful: lastPerformance?.isCompleted,
      );

      // Generate sets for this exercise
      for (int i = 0; i < programExercise.sets.length; i++) {
        final programSet = programExercise.sets[i];
        
        workoutSets.add(WorkoutSet(
          id: 'set_${workoutId}_$setCounter',
          workoutId: workoutId,
          exerciseId: programExercise.exerciseId,
          setNumber: setCounter,
          reps: programSet.targetReps,
          weight: weight,
          rpe: null,
          notes: programSet.isAmrap ? 'AMRAP (As Many Reps As Possible)' : null,
          restSeconds: programExercise.restTime,
          isCompleted: false,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ));
        
        setCounter++;
      }
    }

    return Workout(
      id: workoutId,
      userId: userProgram.userId,
      programId: userProgram.programId,
      name: '${programWorkout.name} - Week $weekNumber',
      notes: 'Week $weekNumber, Day $dayNumber: ${programWorkout.name}',
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

  WorkoutSet? _getLastPerformanceForExercise(
    List<Workout> workoutHistory,
    String exerciseId,
  ) {
    // This would need to be implemented with actual workout set data
    // For now, return null as we don't have complete workout set tracking yet
    return null;
  }

  Future<void> _updateUserProgramProgression(
    String userId,
    String programId,
    bool sessionSuccessful,
  ) async {
    final userProgram = await _userProgramRepository.getActiveUserProgram(userId);
    if (userProgram == null || userProgram.programId != programId) {
      return;
    }

    // Simple progression: advance to next day
    int nextDay = userProgram.currentDay + 1;
    int nextWeek = userProgram.currentWeek;

    final program = await _programRepository.getProgramById(programId);
    if (program != null && nextDay > program.schedule.length) {
      nextDay = 1;
      nextWeek++;
    }

    final updatedUserProgram = userProgram.copyWith(
      currentDay: nextDay,
      currentWeek: nextWeek,
      updatedAt: DateTime.now(),
    );

    await _userProgramRepository.updateUserProgram(updatedUserProgram);
  }
}