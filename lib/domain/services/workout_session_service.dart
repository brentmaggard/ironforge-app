import 'package:uuid/uuid.dart';
import '../entities/workout.dart';
import '../entities/workout_set.dart';
import '../entities/workout_session.dart';
import '../repositories/workout_repository.dart';
import '../repositories/exercise_repository.dart';

const _uuid = Uuid();

/// Service for managing workout sessions and their persistence
/// Handles conversion between WorkoutSession entities (UI layer) and 
/// Workout/WorkoutSet entities (database layer)
class WorkoutSessionService {
  final WorkoutRepository _workoutRepository;
  final ExerciseRepository _exerciseRepository;

  WorkoutSessionService(this._workoutRepository, this._exerciseRepository);

  /// Creates a new workout session in the database
  /// Returns the created workout ID for tracking
  Future<String> createWorkoutSession(WorkoutSession session, String userId) async {
    final workout = _sessionToWorkout(session, userId);
    await _workoutRepository.createWorkout(workout);
    
    // Create initial workout sets for the session
    await _saveWorkoutSets(session, workout.id);
    
    return workout.id;
  }

  /// Loads a workout session from database by workout ID
  Future<WorkoutSession?> loadWorkoutSession(String workoutId) async {
    final workout = await _workoutRepository.getWorkoutById(workoutId);
    if (workout == null) return null;

    final exercisesWithSets = await _workoutRepository.getWorkoutExercisesWithSets(workoutId);
    
    return await _workoutToSession(workout, exercisesWithSets);
  }

  /// Gets the active workout session for a user (if any)
  Future<WorkoutSession?> getActiveWorkoutSession(String userId) async {
    final activeWorkout = await _workoutRepository.getActiveWorkout(userId);
    if (activeWorkout == null) return null;
    
    return await loadWorkoutSession(activeWorkout.id);
  }

  /// Auto-saves workout session changes to database
  /// Called frequently during workout to persist progress
  Future<void> autoSaveSession(WorkoutSession session, String workoutId) async {
    // Update workout metadata
    final workout = await _workoutRepository.getWorkoutById(workoutId);
    if (workout == null) return;

    final updatedWorkout = workout.copyWith(
      name: session.title,
      notes: session.notes,
      startedAt: session.startedAt,
      status: session.isPaused ? 'in_progress' : 'in_progress',
      durationMinutes: session.elapsed.inMinutes,
      updatedAt: DateTime.now(),
    );

    await _workoutRepository.updateWorkout(updatedWorkout);
    
    // Update all workout sets
    await _saveWorkoutSets(session, workoutId);
  }

  /// Completes a workout session
  /// Calculates final statistics and marks as completed
  Future<void> completeWorkoutSession(WorkoutSession session, String workoutId) async {
    final workout = await _workoutRepository.getWorkoutById(workoutId);
    if (workout == null) return;

    // Calculate final statistics
    final stats = _calculateWorkoutStats(session);
    
    final completedWorkout = workout.copyWith(
      name: session.title,
      notes: session.notes,
      startedAt: session.startedAt,
      completedAt: DateTime.now(),
      status: 'completed',
      totalSets: stats.totalSets,
      totalReps: stats.totalReps,
      totalVolume: stats.totalVolume,
      durationMinutes: session.elapsed.inMinutes,
      updatedAt: DateTime.now(),
    );

    await _workoutRepository.updateWorkout(completedWorkout);
    
    // Mark completed sets
    await _saveWorkoutSets(session, workoutId, markCompleted: true);
  }

  /// Starts a workout session by updating status to in_progress
  Future<void> startWorkoutSession(String workoutId) async {
    await _workoutRepository.startWorkout(workoutId);
  }

  /// Creates a new workout session from a list of exercises
  /// Used when starting a fresh workout or from a program
  Future<WorkoutSession> createWorkoutSessionFromExercises({
    required String title,
    required List<String> exerciseIds,
    String? programId,
    String? userProgramId,
    Unit unit = Unit.lb,
  }) async {
    final exercises = <ExerciseBlock>[];

    for (final exerciseId in exerciseIds) {
      try {
        final exercise = await _exerciseRepository.getExerciseByExerciseId(exerciseId);
        if (exercise != null) {
          exercises.add(ExerciseBlock(
            id: _uuid.v4(),
            name: exercise.name,
            exerciseId: exercise.id,
            warmups: [
              // Add default warmup sets
              SetEntry(
                id: _uuid.v4(),
                kind: SetKind.warmup,
                order: 1,
              ),
            ],
            sets: [
              // Add default working sets
              SetEntry(
                id: _uuid.v4(),
                kind: SetKind.working,
                order: 1,
              ),
              SetEntry(
                id: _uuid.v4(),
                kind: SetKind.working,
                order: 2,
              ),
              SetEntry(
                id: _uuid.v4(),
                kind: SetKind.working,
                order: 3,
              ),
            ],
            isWarmupCollapsed: false,
          ));
        } else {
          // Fallback: create a placeholder exercise if lookup fails
          exercises.add(ExerciseBlock(
            id: _uuid.v4(),
            name: exerciseId.split('_').map((word) => 
              word[0].toUpperCase() + word.substring(1)).join(' '),
            exerciseId: exerciseId,
            warmups: [
              SetEntry(
                id: _uuid.v4(),
                kind: SetKind.warmup,
                order: 1,
              ),
            ],
            sets: [
              SetEntry(
                id: _uuid.v4(),
                kind: SetKind.working,
                order: 1,
              ),
              SetEntry(
                id: _uuid.v4(),
                kind: SetKind.working,
                order: 2,
              ),
              SetEntry(
                id: _uuid.v4(),
                kind: SetKind.working,
                order: 3,
              ),
            ],
            isWarmupCollapsed: false,
          ));
        }
      } catch (e) {
        // If there's an error, create a placeholder exercise
        exercises.add(ExerciseBlock(
          id: _uuid.v4(),
          name: exerciseId.split('_').map((word) => 
            word[0].toUpperCase() + word.substring(1)).join(' '),
          exerciseId: exerciseId,
          warmups: [
            SetEntry(
              id: _uuid.v4(),
              kind: SetKind.warmup,
              order: 1,
            ),
          ],
          sets: [
            SetEntry(
              id: _uuid.v4(),
              kind: SetKind.working,
              order: 1,
            ),
            SetEntry(
              id: _uuid.v4(),
              kind: SetKind.working,
              order: 2,
            ),
            SetEntry(
              id: _uuid.v4(),
              kind: SetKind.working,
              order: 3,
            ),
          ],
          isWarmupCollapsed: false,
        ));
      }
    }

    // If no exercises were loaded, add a fallback exercise
    if (exercises.isEmpty) {
      exercises.add(ExerciseBlock(
        id: _uuid.v4(),
        name: 'Sample Exercise',
        exerciseId: 'sample_exercise',
        warmups: [
          SetEntry(
            id: _uuid.v4(),
            kind: SetKind.warmup,
            order: 1,
          ),
        ],
        sets: [
          SetEntry(
            id: _uuid.v4(),
            kind: SetKind.working,
            order: 1,
          ),
          SetEntry(
            id: _uuid.v4(),
            kind: SetKind.working,
            order: 2,
          ),
          SetEntry(
            id: _uuid.v4(),
            kind: SetKind.working,
            order: 3,
          ),
        ],
        isWarmupCollapsed: false,
      ));
    }

    return WorkoutSession(
      id: _uuid.v4(),
      title: title,
      startedAt: DateTime.now(),
      elapsedMs: 0,
      isPaused: false,
      unit: unit,
      exercises: exercises,
      programId: programId,
      userProgramId: userProgramId,
      notes: null,
    );
  }

  /// Converts WorkoutSession to Workout entity
  Workout _sessionToWorkout(WorkoutSession session, String userId) {
    return Workout(
      id: _uuid.v4(), // New workout ID
      userId: userId,
      programId: session.programId,
      name: session.title,
      notes: session.notes,
      startedAt: session.startedAt,
      completedAt: null,
      totalSets: 0, // Will be calculated on completion
      totalReps: 0, // Will be calculated on completion
      totalVolume: 0.0, // Will be calculated on completion
      durationMinutes: session.elapsed.inMinutes,
      status: 'in_progress',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  /// Converts Workout + WorkoutExerciseData to WorkoutSession
  Future<WorkoutSession> _workoutToSession(
    Workout workout, 
    List<WorkoutExerciseData> exercisesWithSets
  ) async {
    final exercises = <ExerciseBlock>[];

    for (final exerciseData in exercisesWithSets) {
      final exercise = exerciseData.exercise;
      final sets = exerciseData.sets;

      // Group sets by warmup vs working
      final warmups = <SetEntry>[];
      final workingSets = <SetEntry>[];
      
      for (final set in sets) {
        final setEntry = SetEntry(
          id: set.id,
          kind: set.setNumber < 0 ? SetKind.warmup : SetKind.working, // Negative setNumber = warmup
          order: set.setNumber.abs(),
          weight: set.weight,
          reps: set.reps,
          completedAt: set.completedAt,
          notes: set.notes,
        );

        if (set.setNumber < 0) {
          warmups.add(setEntry);
        } else {
          workingSets.add(setEntry);
        }
      }

      exercises.add(ExerciseBlock(
        id: _uuid.v4(),
        name: exercise.name,
        exerciseId: exercise.id,
        warmups: warmups,
        sets: workingSets,
        isWarmupCollapsed: false,
      ));
    }

    // Determine unit based on first weight entry (default to lb)
    Unit unit = Unit.lb;
    for (final exercise in exercises) {
      for (final set in [...exercise.warmups, ...exercise.sets]) {
        if (set.weight != null) {
          // Simple heuristic: if weight > 200, likely in lb; otherwise kg
          unit = set.weight! > 200 ? Unit.lb : Unit.kg;
          break;
        }
      }
      if (unit != Unit.lb) break;
    }

    return WorkoutSession(
      id: workout.id,
      title: workout.name,
      startedAt: workout.startedAt ?? workout.createdAt,
      elapsedMs: workout.durationMinutes != null 
          ? workout.durationMinutes! * 60 * 1000 
          : 0,
      isPaused: workout.status == 'in_progress' ? false : true, // Assume paused if not completed
      unit: unit,
      exercises: exercises,
      programId: workout.programId,
      userProgramId: null, // TODO: Add userProgramId to Workout entity
      notes: workout.notes,
    );
  }

  /// Saves all workout sets for a session
  Future<void> _saveWorkoutSets(WorkoutSession session, String workoutId, {bool markCompleted = false}) async {
    // Get existing sets to avoid duplicates
    final existingSets = await _workoutRepository.getWorkoutSets(workoutId);
    final existingSetIds = existingSets.map((s) => s.id).toSet();

    for (final exercise in session.exercises) {
      // Save warmup sets (use negative setNumber to identify)
      for (int i = 0; i < exercise.warmups.length; i++) {
        final warmup = exercise.warmups[i];
        
        if (!existingSetIds.contains(warmup.id)) {
          final workoutSet = WorkoutSet(
            id: warmup.id,
            workoutId: workoutId,
            exerciseId: exercise.exerciseId,
            setNumber: -(i + 1), // Negative number for warmups
            reps: warmup.reps ?? 0,
            weight: warmup.weight ?? 0.0,
            rpe: null,
            restSeconds: null,
            notes: warmup.notes,
            isCompleted: markCompleted ? warmup.isCompleted : (warmup.completedAt != null),
            completedAt: markCompleted ? DateTime.now() : warmup.completedAt,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          );
          
          await _workoutRepository.addWorkoutSet(workoutSet);
        } else {
          // Update existing set
          final existingSet = existingSets.firstWhere((s) => s.id == warmup.id);
          final updatedSet = existingSet.copyWith(
            reps: warmup.reps ?? 0,
            weight: warmup.weight ?? 0.0,
            notes: warmup.notes,
            isCompleted: markCompleted ? warmup.isCompleted : (warmup.completedAt != null),
            completedAt: markCompleted ? DateTime.now() : warmup.completedAt,
            updatedAt: DateTime.now(),
          );
          
          await _workoutRepository.updateWorkoutSet(updatedSet);
        }
      }

      // Save working sets (use positive setNumber)
      for (int i = 0; i < exercise.sets.length; i++) {
        final set = exercise.sets[i];
        
        if (!existingSetIds.contains(set.id)) {
          final workoutSet = WorkoutSet(
            id: set.id,
            workoutId: workoutId,
            exerciseId: exercise.exerciseId,
            setNumber: i + 1, // Positive number for working sets
            reps: set.reps ?? 0,
            weight: set.weight ?? 0.0,
            rpe: null,
            restSeconds: null,
            notes: set.notes,
            isCompleted: markCompleted ? set.isCompleted : (set.completedAt != null),
            completedAt: markCompleted ? DateTime.now() : set.completedAt,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          );
          
          await _workoutRepository.addWorkoutSet(workoutSet);
        } else {
          // Update existing set
          final existingSet = existingSets.firstWhere((s) => s.id == set.id);
          final updatedSet = existingSet.copyWith(
            reps: set.reps ?? 0,
            weight: set.weight ?? 0.0,
            notes: set.notes,
            isCompleted: markCompleted ? set.isCompleted : (set.completedAt != null),
            completedAt: markCompleted ? DateTime.now() : set.completedAt,
            updatedAt: DateTime.now(),
          );
          
          await _workoutRepository.updateWorkoutSet(updatedSet);
        }
      }
    }
  }

  /// Calculates workout statistics from session
  WorkoutStats _calculateWorkoutStats(WorkoutSession session) {
    int totalSets = 0;
    int totalReps = 0;
    double totalVolume = 0.0;

    for (final exercise in session.exercises) {
      for (final set in [...exercise.warmups, ...exercise.sets]) {
        if (set.isCompleted) {
          totalSets++;
          totalReps += set.reps ?? 0;
          totalVolume += (set.weight ?? 0.0) * (set.reps ?? 0);
        }
      }
    }

    return WorkoutStats(
      totalSets: totalSets,
      totalReps: totalReps,
      totalVolume: totalVolume,
    );
  }
}

/// Helper class for workout statistics
class WorkoutStats {
  final int totalSets;
  final int totalReps;
  final double totalVolume;

  const WorkoutStats({
    required this.totalSets,
    required this.totalReps,
    required this.totalVolume,
  });
}