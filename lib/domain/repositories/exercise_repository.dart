import '../entities/exercise.dart';

abstract class ExerciseRepository {
  Future<List<Exercise>> getAllExercises();
  Future<List<Exercise>> getExercisesByMuscleGroup(String muscleGroup);
  Future<List<Exercise>> getExercisesByEquipment(String equipment);
  Future<List<Exercise>> searchExercises(String query);
  Future<Exercise?> getExerciseById(String id);
  Future<List<Exercise>> getFavoriteExercises(String userId);
  Future<List<Exercise>> getRecentExercises(String userId);
  Future<void> createExercise(Exercise exercise);
  Future<void> updateExercise(Exercise exercise);
  Future<void> deleteExercise(String id);
  Future<void> seedExercises();
}