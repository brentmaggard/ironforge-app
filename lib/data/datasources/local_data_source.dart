import 'package:drift/drift.dart';
import 'database.dart';
import 'csv_seeder.dart';
import '../models/exercise_model.dart';
import '../models/goal_model.dart';
import '../../domain/entities/exercise.dart' as domain;
import '../../domain/entities/goal.dart' as domain;

class LocalDataSource {
  final AppDatabase _database;

  LocalDataSource(this._database);

  // Exercise operations
  Future<List<domain.Exercise>> getAllExercises() async {
    final exercises = await _database.select(_database.exercises).get();
    return exercises.map((e) => e.toEntity()).toList();
  }

  Future<List<domain.Exercise>> getExercisesByMuscleGroup(String muscleGroup) async {
    final exercises = await (_database.select(_database.exercises)
          ..where((e) => e.primaryMuscles.contains(muscleGroup)))
        .get();
    return exercises.map((e) => e.toEntity()).toList();
  }

  Future<List<domain.Exercise>> getExercisesByEquipment(String equipment) async {
    final exercises = await (_database.select(_database.exercises)
          ..where((e) => e.defaultEquipment.equals(equipment)))
        .get();
    return exercises.map((e) => e.toEntity()).toList();
  }

  Future<List<domain.Exercise>> searchExercises(String query) async {
    final exercises = await (_database.select(_database.exercises)
          ..where((e) => 
              e.name.contains(query) | 
              e.instructions.contains(query) |
              e.primaryMuscles.contains(query)))
        .get();
    return exercises.map((e) => e.toEntity()).toList();
  }

  Future<domain.Exercise?> getExerciseById(String id) async {
    final exercise = await (_database.select(_database.exercises)
          ..where((e) => e.id.equals(id)))
        .getSingleOrNull();
    return exercise?.toEntity();
  }

  Future<void> createExercise(domain.Exercise exercise) async {
    await _database.into(_database.exercises).insert(exercise.toCompanion());
  }

  Future<void> updateExercise(domain.Exercise exercise) async {
    await _database.update(_database.exercises).replace(exercise.toCompanion());
  }

  Future<void> deleteExercise(String id) async {
    await (_database.delete(_database.exercises)
          ..where((e) => e.id.equals(id)))
        .go();
  }

  Future<void> seedExercises() async {
    // Check if we have enough exercises (should be 50+ from JSON, not just 3 from demo)
    final count = await _database.exercises.count().getSingle();
    if (count >= 50) {
      print('Database already properly seeded with $count exercises');
      return; // Already properly seeded
    }

    print('Database has only $count exercises, re-seeding with production data...');
    
    // Clear existing data and reseed with production data
    await _database.delete(_database.exercises).go();
    await _database.delete(_database.exerciseCategories).go();
    await _database.delete(_database.equipment).go();
    
    // Use JSON seeder for rich data
    await CsvSeeder.seedAllData(_database);
  }

  // Goal operations
  Future<List<domain.Goal>> getGoalsByUserId(String userId) async {
    final goals = await (_database.select(_database.goals)
          ..where((g) => g.userId.equals(userId))
          ..orderBy([(g) => OrderingTerm.desc(g.createdAt)]))
        .get();
    return goals.map((g) => g.toEntity()).toList();
  }

  Future<List<domain.Goal>> getActiveGoals(String userId) async {
    final goals = await (_database.select(_database.goals)
          ..where((g) => g.userId.equals(userId) & g.isCompleted.equals(false))
          ..orderBy([(g) => OrderingTerm.desc(g.createdAt)]))
        .get();
    return goals.map((g) => g.toEntity()).toList();
  }

  Future<List<domain.Goal>> getCompletedGoals(String userId) async {
    final goals = await (_database.select(_database.goals)
          ..where((g) => g.userId.equals(userId) & g.isCompleted.equals(true))
          ..orderBy([(g) => OrderingTerm.desc(g.completedAt)]))
        .get();
    return goals.map((g) => g.toEntity()).toList();
  }

  Future<domain.Goal?> getGoalById(String id) async {
    final goal = await (_database.select(_database.goals)
          ..where((g) => g.id.equals(id)))
        .getSingleOrNull();
    return goal?.toEntity();
  }

  Future<void> createGoal(domain.Goal goal) async {
    await _database.into(_database.goals).insert(goal.toCompanion());
  }

  Future<void> updateGoal(domain.Goal goal) async {
    await _database.update(_database.goals).replace(goal.toCompanion());
  }

  Future<void> deleteGoal(String id) async {
    await (_database.delete(_database.goals)
          ..where((g) => g.id.equals(id)))
        .go();
  }

  Future<void> updateGoalProgress(String goalId, double newProgress) async {
    await (_database.update(_database.goals)
          ..where((g) => g.id.equals(goalId)))
        .write(GoalsCompanion(
          currentValue: Value(newProgress),
          updatedAt: Value(DateTime.now()),
        ));
  }

  Future<void> completeGoal(String goalId) async {
    final now = DateTime.now();
    await (_database.update(_database.goals)
          ..where((g) => g.id.equals(goalId)))
        .write(GoalsCompanion(
          isCompleted: const Value(true),
          completedAt: Value(now),
          updatedAt: Value(now),
        ));
  }

  // Database utility operations
  Future<void> initializeDatabase() async {
    await seedExercises();
  }

  Future<void> clearAllData() async {
    await _database.transaction(() async {
      await _database.delete(_database.exercises).go();
      await _database.delete(_database.goals).go();
      await _database.delete(_database.workouts).go();
      await _database.delete(_database.workoutSets).go();
      await _database.delete(_database.progressEntries).go();
    });
  }
}