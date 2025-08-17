import '../../domain/entities/workout.dart';
import '../../domain/entities/workout_set.dart';
import '../../domain/repositories/workout_repository.dart';
import '../datasources/local_data_source.dart';

class WorkoutRepositoryImpl implements WorkoutRepository {
  final LocalDataSource _localDataSource;

  WorkoutRepositoryImpl(this._localDataSource);

  @override
  Future<List<Workout>> getWorkoutsByUserId(String userId) async {
    return await _localDataSource.getWorkoutsByUserId(userId);
  }

  @override
  Future<List<Workout>> getRecentWorkouts(String userId, {int limit = 10}) async {
    return await _localDataSource.getRecentWorkouts(userId, limit: limit);
  }

  @override
  Future<Workout?> getWorkoutById(String id) async {
    return await _localDataSource.getWorkoutById(id);
  }

  @override
  Future<Workout?> getActiveWorkout(String userId) async {
    return await _localDataSource.getActiveWorkout(userId);
  }

  @override
  Future<List<WorkoutSet>> getWorkoutSets(String workoutId) async {
    return await _localDataSource.getWorkoutSets(workoutId);
  }

  @override
  Future<void> createWorkout(Workout workout) async {
    await _localDataSource.createWorkout(workout);
  }

  @override
  Future<void> updateWorkout(Workout workout) async {
    await _localDataSource.updateWorkout(workout);
  }

  @override
  Future<void> deleteWorkout(String id) async {
    await _localDataSource.deleteWorkout(id);
  }

  @override
  Future<void> startWorkout(String workoutId) async {
    final workout = await _localDataSource.getWorkoutById(workoutId);
    if (workout != null) {
      final updatedWorkout = workout.copyWith(
        status: 'in_progress',
        startedAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      await _localDataSource.updateWorkout(updatedWorkout);
    }
  }

  @override
  Future<void> completeWorkout(String workoutId) async {
    final workout = await _localDataSource.getWorkoutById(workoutId);
    if (workout != null) {
      final updatedWorkout = workout.copyWith(
        status: 'completed',
        completedAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      await _localDataSource.updateWorkout(updatedWorkout);
    }
  }

  @override
  Future<void> addWorkoutSet(WorkoutSet workoutSet) async {
    await _localDataSource.addWorkoutSet(workoutSet);
  }

  @override
  Future<void> updateWorkoutSet(WorkoutSet workoutSet) async {
    await _localDataSource.updateWorkoutSet(workoutSet);
  }

  @override
  Future<void> deleteWorkoutSet(String setId) async {
    await _localDataSource.deleteWorkoutSet(setId);
  }

  @override
  Future<List<WorkoutExerciseData>> getWorkoutExercisesWithSets(String workoutId) async {
    // Get all sets grouped by exercise
    final exerciseSetsMap = await _localDataSource.getWorkoutSetsByExercise(workoutId);
    
    final List<WorkoutExerciseData> exercisesWithSets = [];
    
    for (final exerciseId in exerciseSetsMap.keys) {
      final exercise = await _localDataSource.getExerciseById(exerciseId);
      if (exercise != null) {
        exercisesWithSets.add(WorkoutExerciseData(
          exercise: exercise,
          sets: exerciseSetsMap[exerciseId]!,
        ));
      }
    }
    
    return exercisesWithSets;
  }
}