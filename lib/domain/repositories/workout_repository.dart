import '../entities/workout.dart';
import '../entities/workout_set.dart';
import '../entities/exercise.dart';

// Data structure for workout exercises with their sets
class WorkoutExerciseData {
  final Exercise exercise;
  final List<WorkoutSet> sets;
  
  const WorkoutExerciseData({
    required this.exercise,
    required this.sets,
  });
}

abstract class WorkoutRepository {
  Future<List<Workout>> getWorkoutsByUserId(String userId);
  Future<List<Workout>> getRecentWorkouts(String userId, {int limit = 10});
  Future<Workout?> getWorkoutById(String id);
  Future<Workout?> getActiveWorkout(String userId);
  Future<List<WorkoutSet>> getWorkoutSets(String workoutId);
  Future<List<WorkoutExerciseData>> getWorkoutExercisesWithSets(String workoutId);
  Future<void> createWorkout(Workout workout);
  Future<void> updateWorkout(Workout workout);
  Future<void> deleteWorkout(String id);
  Future<void> startWorkout(String workoutId);
  Future<void> completeWorkout(String workoutId);
  Future<void> addWorkoutSet(WorkoutSet workoutSet);
  Future<void> updateWorkoutSet(WorkoutSet workoutSet);
  Future<void> deleteWorkoutSet(String setId);
}