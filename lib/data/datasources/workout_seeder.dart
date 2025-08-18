import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart';
import 'database.dart';

class WorkoutSeeder {
  static const _uuid = Uuid();
  
  static Future<void> seedSampleWorkouts(AppDatabase database, {bool force = false}) async {
    // Check if we already have workouts
    final existingWorkouts = await database.select(database.workouts).get();
    if (existingWorkouts.isNotEmpty && !force) {
      print('Workouts already exist, skipping seeding (use force: true to override)');
      return;
    }

    if (force && existingWorkouts.isNotEmpty) {
      print('Force seeding - clearing existing workout data...');
      await database.transaction(() async {
        await database.delete(database.workoutSets).go();
        await database.delete(database.workouts).go();
      });
    }

    print('Seeding sample workouts with exercises and sets...');

    // Get some real exercises from the database to use
    final exercises = await database.select(database.exercises).get();
    if (exercises.isEmpty) {
      print('No exercises found in database, cannot seed workouts');
      return;
    }

    await database.transaction(() async {
      final now = DateTime.now();
      final yesterday = now.subtract(const Duration(days: 1));

      // Workout 1: Push Day (Completed)
      final workout1Id = _uuid.v4();
      await database.into(database.workouts).insert(WorkoutsCompanion.insert(
        id: workout1Id,
        userId: 'demo-user',
        name: 'Push Day - Chest & Shoulders',
        notes: Value('Great session, felt strong on bench press'),
        status: Value('completed'),
        startedAt: Value(yesterday.subtract(const Duration(hours: 1, minutes: 30))),
        completedAt: Value(yesterday),
        totalSets: Value(12),
        totalReps: Value(96),
        totalVolume: Value(8640.0),
        durationMinutes: Value(75),
        createdAt: Value(yesterday.subtract(const Duration(hours: 2))),
        updatedAt: Value(yesterday),
      ));

      // Find exercises for Push Day
      final benchPress = exercises.firstWhere(
        (e) => e.name.toLowerCase().contains('bench') || e.name.toLowerCase().contains('press'),
        orElse: () => exercises.first,
      );
      
      final shoulderPress = exercises.firstWhere(
        (e) => e.name.toLowerCase().contains('shoulder') || e.name.toLowerCase().contains('overhead'),
        orElse: () => exercises[1 % exercises.length],
      );

      // Bench Press Sets (4 sets)
      for (int i = 1; i <= 4; i++) {
        await database.into(database.workoutSets).insert(WorkoutSetsCompanion.insert(
          id: _uuid.v4(),
          workoutId: workout1Id,
          exerciseId: benchPress.id,
          setNumber: i,
          reps: 8 - i + 1, // 8, 7, 6, 5 reps
          weight: 185.0,
          rpe: Value(6.0 + i), // 7, 8, 9, 10 RPE
          isCompleted: Value(true),
          completedAt: Value(yesterday.subtract(Duration(minutes: 60 - (i * 5)))),
          createdAt: Value(yesterday.subtract(Duration(minutes: 65 - (i * 5)))),
          updatedAt: Value(yesterday.subtract(Duration(minutes: 60 - (i * 5)))),
        ));
      }

      // Shoulder Press Sets (3 sets)
      for (int i = 1; i <= 3; i++) {
        await database.into(database.workoutSets).insert(WorkoutSetsCompanion.insert(
          id: _uuid.v4(),
          workoutId: workout1Id,
          exerciseId: shoulderPress.id,
          setNumber: i,
          reps: 11 - i, // 10, 9, 8 reps
          weight: 135.0,
          rpe: Value(6.0 + (i * 0.5)), // 6.5, 7, 7.5 RPE
          isCompleted: Value(true),
          completedAt: Value(yesterday.subtract(Duration(minutes: 35 - (i * 5)))),
          createdAt: Value(yesterday.subtract(Duration(minutes: 40 - (i * 5)))),
          updatedAt: Value(yesterday.subtract(Duration(minutes: 35 - (i * 5)))),
        ));
      }

      // Workout 2: Pull Day (In Progress)
      final workout2Id = _uuid.v4();
      await database.into(database.workouts).insert(WorkoutsCompanion.insert(
        id: workout2Id,
        userId: 'demo-user',
        name: 'Pull Day - Back & Biceps',
        notes: Value('Focus on form and mind-muscle connection'),
        status: Value('in_progress'),
        startedAt: Value(now.subtract(const Duration(minutes: 25))),
        totalSets: Value(6),
        totalReps: Value(48),
        totalVolume: Value(4320.0),
        createdAt: Value(now.subtract(const Duration(minutes: 30))),
        updatedAt: Value(now.subtract(const Duration(minutes: 5))),
      ));

      // Find exercises for Pull Day
      final pullUps = exercises.firstWhere(
        (e) => e.name.toLowerCase().contains('pull') || e.name.toLowerCase().contains('chin'),
        orElse: () => exercises[2 % exercises.length],
      );

      final barbellRow = exercises.firstWhere(
        (e) => e.name.toLowerCase().contains('row') || e.name.toLowerCase().contains('bent'),
        orElse: () => exercises[3 % exercises.length],
      );

      // Pull-ups Sets (3 sets - 2 completed, 1 in progress)
      for (int i = 1; i <= 3; i++) {
        final isCompleted = i <= 2; // First 2 sets completed
        await database.into(database.workoutSets).insert(WorkoutSetsCompanion.insert(
          id: _uuid.v4(),
          workoutId: workout2Id,
          exerciseId: pullUps.id,
          setNumber: i,
          reps: 9 - i, // 8, 7, 6 reps
          weight: 0.0, // Bodyweight
          rpe: Value(6.5 + (i * 0.5)), // 7, 7.5, 8 RPE
          isCompleted: Value(isCompleted),
          completedAt: isCompleted ? Value(now.subtract(Duration(minutes: 20 - (i * 5)))) : Value.absent(),
          createdAt: Value(now.subtract(Duration(minutes: 25 - (i * 5)))),
          updatedAt: Value(now.subtract(Duration(minutes: 20 - (i * 5)))),
        ));
      }

      // Barbell Row Sets (3 sets - 2 completed, 1 in progress)
      for (int i = 1; i <= 3; i++) {
        final isCompleted = i <= 2; // First 2 sets completed
        await database.into(database.workoutSets).insert(WorkoutSetsCompanion.insert(
          id: _uuid.v4(),
          workoutId: workout2Id,
          exerciseId: barbellRow.id,
          setNumber: i,
          reps: 11 - i, // 10, 9, 8 reps
          weight: 155.0,
          rpe: Value(6.0 + (i * 0.5)), // 6.5, 7, 7.5 RPE
          isCompleted: Value(isCompleted),
          completedAt: isCompleted ? Value(now.subtract(Duration(minutes: 12 - (i * 4)))) : Value.absent(),
          createdAt: Value(now.subtract(Duration(minutes: 16 - (i * 4)))),
          updatedAt: Value(now.subtract(Duration(minutes: 12 - (i * 4)))),
        ));
      }
    });

    print('Successfully seeded 2 sample workouts:');
    print('- Workout 1: Push Day (Completed) - 7 sets total');
    print('- Workout 2: Pull Day (In Progress) - 6 sets total');
  }
}