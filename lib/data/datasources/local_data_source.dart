import 'package:drift/drift.dart';
import 'database.dart';
import 'csv_seeder.dart';
import 'program_seeder.dart';
import '../models/exercise_model.dart';
import '../models/goal_model.dart';
import '../models/workout_model.dart';
import '../models/workout_set_model.dart';
import '../models/program_model.dart';
import '../models/user_program_model.dart';
import '../models/program_session_model.dart';
import '../../domain/entities/exercise.dart' as domain;
import '../../domain/entities/goal.dart' as domain;
import '../../domain/entities/workout.dart' as domain;
import '../../domain/entities/workout_set.dart' as domain;
import '../../domain/entities/program.dart' as domain;
import '../../domain/entities/user_program.dart' as domain;
import '../../domain/entities/program_session.dart' as domain;

class LocalDataSource {
  final AppDatabase _database;

  LocalDataSource(this._database);

  // Getter for accessing database (for seeding operations)
  AppDatabase get database => _database;

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

  Future<domain.Exercise?> getExerciseByExerciseId(String exerciseId) async {
    final exercise = await (_database.select(_database.exercises)
          ..where((e) => e.exerciseId.equals(exerciseId)))
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

  // Workout operations
  Future<List<domain.Workout>> getWorkoutsByUserId(String userId) async {
    final workouts = await (_database.select(_database.workouts)
          ..where((w) => w.userId.equals(userId))
          ..orderBy([(w) => OrderingTerm.desc(w.createdAt)]))
        .get();
    return workouts.map((w) => w.toEntity()).toList();
  }

  Future<List<domain.Workout>> getRecentWorkouts(String userId, {int limit = 10}) async {
    final workouts = await (_database.select(_database.workouts)
          ..where((w) => w.userId.equals(userId))
          ..orderBy([(w) => OrderingTerm.desc(w.createdAt)])
          ..limit(limit))
        .get();
    return workouts.map((w) => w.toEntity()).toList();
  }

  Future<domain.Workout?> getWorkoutById(String id) async {
    final workout = await (_database.select(_database.workouts)
          ..where((w) => w.id.equals(id)))
        .getSingleOrNull();
    return workout?.toEntity();
  }

  Future<domain.Workout?> getActiveWorkout(String userId) async {
    final workout = await (_database.select(_database.workouts)
          ..where((w) => w.userId.equals(userId) & w.status.equals('in_progress')))
        .getSingleOrNull();
    return workout?.toEntity();
  }

  Future<List<domain.WorkoutSet>> getWorkoutSets(String workoutId) async {
    final sets = await (_database.select(_database.workoutSets)
          ..where((s) => s.workoutId.equals(workoutId))
          ..orderBy([(s) => OrderingTerm.asc(s.setNumber)]))
        .get();
    return sets.map((s) => s.toEntity()).toList();
  }

  Future<void> createWorkout(domain.Workout workout) async {
    await _database.into(_database.workouts).insert(workout.toCompanion());
  }

  Future<void> updateWorkout(domain.Workout workout) async {
    await (_database.update(_database.workouts)
          ..where((w) => w.id.equals(workout.id)))
        .write(workout.toCompanion());
  }

  Future<void> deleteWorkout(String id) async {
    await _database.transaction(() async {
      // Delete workout sets first
      await (_database.delete(_database.workoutSets)
            ..where((s) => s.workoutId.equals(id)))
          .go();
      // Delete workout
      await (_database.delete(_database.workouts)
            ..where((w) => w.id.equals(id)))
          .go();
    });
  }

  Future<void> addWorkoutSet(domain.WorkoutSet workoutSet) async {
    await _database.into(_database.workoutSets).insert(workoutSet.toCompanion());
  }

  Future<void> updateWorkoutSet(domain.WorkoutSet workoutSet) async {
    await (_database.update(_database.workoutSets)
          ..where((s) => s.id.equals(workoutSet.id)))
        .write(workoutSet.toCompanion());
  }

  Future<void> deleteWorkoutSet(String setId) async {
    await (_database.delete(_database.workoutSets)
          ..where((s) => s.id.equals(setId)))
        .go();
  }

  Future<Map<String, List<domain.WorkoutSet>>> getWorkoutSetsByExercise(String workoutId) async {
    final sets = await (_database.select(_database.workoutSets)
          ..where((s) => s.workoutId.equals(workoutId))
          ..orderBy([(s) => OrderingTerm.asc(s.setNumber)]))
        .get();
    
    final Map<String, List<domain.WorkoutSet>> exerciseSets = {};
    for (final set in sets) {
      final exerciseId = set.exerciseId;
      if (!exerciseSets.containsKey(exerciseId)) {
        exerciseSets[exerciseId] = [];
      }
      exerciseSets[exerciseId]!.add(set.toEntity());
    }
    
    return exerciseSets;
  }

  // Program operations
  Future<List<domain.Program>> getAllPrograms() async {
    final programs = await _database.select(_database.programs).get();
    return programs.map((p) => p.toEntity()).toList();
  }

  Future<List<domain.Program>> getProgramTemplates() async {
    final programs = await (_database.select(_database.programs)
          ..where((p) => p.isTemplate.equals(true)))
        .get();
    return programs.map((p) => p.toEntity()).toList();
  }

  Future<domain.Program?> getProgramById(String id) async {
    final program = await (_database.select(_database.programs)
          ..where((p) => p.id.equals(id)))
        .getSingleOrNull();
    return program?.toEntity();
  }

  Future<void> createProgram(domain.Program program) async {
    await _database.into(_database.programs).insert(program.toCompanion());
  }

  Future<void> updateProgram(domain.Program program) async {
    await (_database.update(_database.programs)
          ..where((p) => p.id.equals(program.id)))
        .write(program.toCompanion());
  }

  Future<void> deleteProgram(String id) async {
    await (_database.delete(_database.programs)
          ..where((p) => p.id.equals(id)))
        .go();
  }

  // UserProgram operations
  Future<List<domain.UserProgram>> getUserPrograms(String userId) async {
    final userPrograms = await (_database.select(_database.userPrograms)
          ..where((up) => up.userId.equals(userId))
          ..orderBy([(up) => OrderingTerm.desc(up.createdAt)]))
        .get();
    return userPrograms.map((up) => up.toEntity()).toList();
  }

  Future<domain.UserProgram?> getActiveUserProgram(String userId) async {
    final userProgram = await (_database.select(_database.userPrograms)
          ..where((up) => up.userId.equals(userId) & up.status.equals('active')))
        .getSingleOrNull();
    return userProgram?.toEntity();
  }

  Future<domain.UserProgram?> getUserProgramById(String id) async {
    final userProgram = await (_database.select(_database.userPrograms)
          ..where((up) => up.id.equals(id)))
        .getSingleOrNull();
    return userProgram?.toEntity();
  }

  Future<void> createUserProgram(domain.UserProgram userProgram) async {
    await _database.into(_database.userPrograms).insert(userProgram.toCompanion());
  }

  Future<void> updateUserProgram(domain.UserProgram userProgram) async {
    await (_database.update(_database.userPrograms)
          ..where((up) => up.id.equals(userProgram.id)))
        .write(userProgram.toCompanion());
  }

  Future<void> deleteUserProgram(String id) async {
    await _database.transaction(() async {
      // Delete associated program sessions first
      await (_database.delete(_database.programSessions)
            ..where((ps) => ps.userProgramId.equals(id)))
          .go();
      // Delete user program
      await (_database.delete(_database.userPrograms)
            ..where((up) => up.id.equals(id)))
          .go();
    });
  }

  // ProgramSession operations
  Future<List<domain.ProgramSession>> getSessionsByUserProgram(String userProgramId) async {
    final sessions = await (_database.select(_database.programSessions)
          ..where((ps) => ps.userProgramId.equals(userProgramId))
          ..orderBy([(ps) => OrderingTerm.asc(ps.weekNumber), (ps) => OrderingTerm.asc(ps.dayNumber)]))
        .get();
    return sessions.map((ps) => ps.toEntity()).toList();
  }

  Future<domain.ProgramSession?> getSessionById(String id) async {
    final session = await (_database.select(_database.programSessions)
          ..where((ps) => ps.id.equals(id)))
        .getSingleOrNull();
    return session?.toEntity();
  }

  Future<domain.ProgramSession?> getSessionByWeekDay(String userProgramId, int weekNumber, int dayNumber) async {
    final session = await (_database.select(_database.programSessions)
          ..where((ps) => ps.userProgramId.equals(userProgramId) 
              & ps.weekNumber.equals(weekNumber) 
              & ps.dayNumber.equals(dayNumber)))
        .getSingleOrNull();
    return session?.toEntity();
  }

  Future<void> createProgramSession(domain.ProgramSession session) async {
    await _database.into(_database.programSessions).insert(session.toCompanion());
  }

  Future<void> updateProgramSession(domain.ProgramSession session) async {
    await (_database.update(_database.programSessions)
          ..where((ps) => ps.id.equals(session.id)))
        .write(session.toCompanion());
  }

  Future<void> deleteProgramSession(String id) async {
    await (_database.delete(_database.programSessions)
          ..where((ps) => ps.id.equals(id)))
        .go();
  }

  Future<List<domain.ProgramSession>> getUpcomingSessions(String userProgramId, {int limit = 7}) async {
    final sessions = await (_database.select(_database.programSessions)
          ..where((ps) => ps.userProgramId.equals(userProgramId) & ps.status.equals('scheduled'))
          ..orderBy([(ps) => OrderingTerm.asc(ps.scheduledDate)])
          ..limit(limit))
        .get();
    return sessions.map((ps) => ps.toEntity()).toList();
  }

  Future<List<domain.ProgramSession>> getCompletedSessions(String userProgramId) async {
    final sessions = await (_database.select(_database.programSessions)
          ..where((ps) => ps.userProgramId.equals(userProgramId) & ps.status.equals('completed'))
          ..orderBy([(ps) => OrderingTerm.desc(ps.completedAt)]))
        .get();
    return sessions.map((ps) => ps.toEntity()).toList();
  }

  // Database utility operations
  Future<void> initializeDatabase() async {
    await seedExercises();
    await ProgramSeeder.seedProgramTemplates(_database);
  }

  Future<void> clearAllData() async {
    await _database.transaction(() async {
      await _database.delete(_database.exercises).go();
      await _database.delete(_database.goals).go();
      await _database.delete(_database.workouts).go();
      await _database.delete(_database.workoutSets).go();
      await _database.delete(_database.progressEntries).go();
      await _database.delete(_database.programs).go();
      await _database.delete(_database.userPrograms).go();
      await _database.delete(_database.programSessions).go();
    });
  }
}