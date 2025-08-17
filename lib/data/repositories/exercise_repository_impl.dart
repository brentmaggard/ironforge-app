import '../../domain/entities/exercise.dart' as domain;
import '../../domain/repositories/exercise_repository.dart';
import '../datasources/local_data_source.dart';

class ExerciseRepositoryImpl implements ExerciseRepository {
  final LocalDataSource _localDataSource;

  ExerciseRepositoryImpl(this._localDataSource);

  @override
  Future<List<domain.Exercise>> getAllExercises() async {
    return await _localDataSource.getAllExercises();
  }

  @override
  Future<List<domain.Exercise>> getExercisesByMuscleGroup(String muscleGroup) async {
    return await _localDataSource.getExercisesByMuscleGroup(muscleGroup);
  }

  @override
  Future<List<domain.Exercise>> getExercisesByEquipment(String equipment) async {
    return await _localDataSource.getExercisesByEquipment(equipment);
  }

  @override
  Future<List<domain.Exercise>> searchExercises(String query) async {
    return await _localDataSource.searchExercises(query);
  }

  @override
  Future<domain.Exercise?> getExerciseById(String id) async {
    return await _localDataSource.getExerciseById(id);
  }

  @override
  Future<domain.Exercise?> getExerciseByExerciseId(String exerciseId) async {
    return await _localDataSource.getExerciseByExerciseId(exerciseId);
  }

  @override
  Future<List<domain.Exercise>> getFavoriteExercises(String userId) async {
    // TODO: Implement favorites functionality
    // For now, return recent exercises as placeholder
    return await getRecentExercises(userId);
  }

  @override
  Future<List<domain.Exercise>> getRecentExercises(String userId) async {
    // TODO: Implement by joining with workout_sets to find recently used exercises
    // For now, return a subset of all exercises
    final allExercises = await _localDataSource.getAllExercises();
    return allExercises.take(10).toList();
  }

  @override
  Future<void> createExercise(domain.Exercise exercise) async {
    await _localDataSource.createExercise(exercise);
  }

  @override
  Future<void> updateExercise(domain.Exercise exercise) async {
    await _localDataSource.updateExercise(exercise);
  }

  @override
  Future<void> deleteExercise(String id) async {
    await _localDataSource.deleteExercise(id);
  }

  @override
  Future<void> seedExercises() async {
    await _localDataSource.seedExercises();
  }
}