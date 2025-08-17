import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/database.dart';
import '../../data/datasources/local_data_source.dart';
import '../../data/repositories/exercise_repository_impl.dart';
import '../../data/repositories/goal_repository_impl.dart';
import '../../data/repositories/exercise_favorites_repository_impl.dart';
import '../../data/repositories/workout_repository_impl.dart';
import '../../data/repositories/program_repository_impl.dart';
import '../../data/repositories/user_program_repository_impl.dart';
import '../../data/repositories/program_session_repository_impl.dart';
import '../../domain/repositories/exercise_repository.dart';
import '../../domain/repositories/goal_repository.dart';
import '../../domain/repositories/exercise_favorites_repository.dart';
import '../../domain/repositories/workout_repository.dart';
import '../../domain/repositories/program_repository.dart';
import '../../domain/repositories/user_program_repository.dart';
import '../../domain/repositories/program_session_repository.dart';
import '../../domain/entities/goal.dart' as domain;
import '../../domain/entities/exercise.dart' as domain_exercise;

/// Database provider - singleton instance
final databaseProvider = Provider<AppDatabase>((ref) {
  final database = AppDatabase();
  ref.onDispose(() => database.close());
  return database;
});

/// Local data source provider
final localDataSourceProvider = Provider<LocalDataSource>((ref) {
  final database = ref.watch(databaseProvider);
  return LocalDataSource(database);
});

/// Exercise repository provider
final exerciseRepositoryProvider = Provider<ExerciseRepository>((ref) {
  final localDataSource = ref.watch(localDataSourceProvider);
  return ExerciseRepositoryImpl(localDataSource);
});

/// Goal repository provider
final goalRepositoryProvider = Provider<GoalRepository>((ref) {
  final localDataSource = ref.watch(localDataSourceProvider);
  return GoalRepositoryImpl(localDataSource);
});

/// Exercise favorites repository provider
final exerciseFavoritesRepositoryProvider = Provider<ExerciseFavoritesRepository>((ref) {
  final database = ref.watch(databaseProvider);
  return ExerciseFavoritesRepositoryImpl(database);
});

/// Workout repository provider
final workoutRepositoryProvider = Provider<WorkoutRepository>((ref) {
  final localDataSource = ref.watch(localDataSourceProvider);
  return WorkoutRepositoryImpl(localDataSource);
});

/// Program repository provider
final programRepositoryProvider = Provider<ProgramRepository>((ref) {
  final localDataSource = ref.watch(localDataSourceProvider);
  return ProgramRepositoryImpl(localDataSource);
});

/// User program repository provider
final userProgramRepositoryProvider = Provider<UserProgramRepository>((ref) {
  final localDataSource = ref.watch(localDataSourceProvider);
  return UserProgramRepositoryImpl(localDataSource);
});

/// Program session repository provider
final programSessionRepositoryProvider = Provider<ProgramSessionRepository>((ref) {
  final localDataSource = ref.watch(localDataSourceProvider);
  return ProgramSessionRepositoryImpl(localDataSource);
});

/// Database initialization provider
/// This provider ensures the database is properly initialized and seeded
final databaseInitializationProvider = FutureProvider<void>((ref) async {
  final localDataSource = ref.watch(localDataSourceProvider);
  await localDataSource.initializeDatabase();
});

/// User goals provider - gets all goals for a specific user
final userGoalsProvider = FutureProvider.family<List<domain.Goal>, String>((ref, userId) async {
  final goalRepository = ref.watch(goalRepositoryProvider);
  return await goalRepository.getGoalsByUserId(userId);
});

/// All exercises provider - gets all exercises from the database
final allExercisesProvider = FutureProvider<List<domain_exercise.Exercise>>((ref) async {
  await ref.watch(databaseInitializationProvider.future);
  final exerciseRepository = ref.watch(exerciseRepositoryProvider);
  return await exerciseRepository.getAllExercises();
});