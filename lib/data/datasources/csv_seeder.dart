import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'database.dart';
import 'csv_parser.dart';
import 'json_seeder.dart';

/// CSV-based seeder that imports real data from CSV files
class CsvSeeder {
  static const String _dataPath = 'data bk';
  static const _uuid = Uuid();

  /// Seed all data from CSV files
  static Future<void> seedAllData(AppDatabase database) async {
    try {
      if (kIsWeb) {
        // Web platform - use demo data
        await seedWebDemoData(database);
      } else {
        // Native platforms - use JSON files as assets (more reliable than CSV)
        print('Starting JSON data seeding for native platform...');
        await JsonSeeder.seedAllData(database);
        print('JSON data seeding completed successfully');
      }
    } catch (e) {
      print('Error during data seeding: $e');
      // Fallback to demo data if CSV fails
      print('Falling back to demo data...');
      await seedWebDemoData(database);
    }
  }

  /// Seed demo data for web platform
  static Future<void> seedWebDemoData(AppDatabase database) async {
    try {
      print('Seeding demo data for web platform...');
      
      // Seed demo exercises
      await _seedDemoExercises(database);
      
      // Seed demo goals
      await _seedDemoGoals(database);
      
      print('Demo data seeded successfully');
    } catch (e) {
      print('Error seeding demo data: $e');
    }
  }

  /// Seed exercises from CSV file
  static Future<void> seedExercises(AppDatabase database) async {
    try {
      print('Seeding exercises from CSV...');
      final csvPath = '$_dataPath/exercises_rows.csv';
      final exercises = await CsvParser.parseExercises(csvPath);
      
      if (exercises.isEmpty) {
        print('No exercises found in CSV file');
        return;
      }

      // Clear existing exercises (optional)
      await database.delete(database.exercises).go();

      // Insert exercises in batches
      const batchSize = 50;
      for (int i = 0; i < exercises.length; i += batchSize) {
        final exerciseBatch = exercises.skip(i).take(batchSize).toList();
        await database.batch((batchInsert) {
          for (final exercise in exerciseBatch) {
            batchInsert.insert(database.exercises, exercise);
          }
        });
      }

      print('Successfully seeded ${exercises.length} exercises');
    } catch (e) {
      print('Error seeding exercises: $e');
      rethrow;
    }
  }

  /// Seed goals from CSV file
  static Future<void> seedGoals(AppDatabase database) async {
    try {
      print('Seeding goals from CSV...');
      final csvPath = '$_dataPath/goals_rows.csv';
      final goals = await CsvParser.parseGoals(csvPath);
      
      if (goals.isEmpty) {
        print('No goals found in CSV file');
        return;
      }

      // Clear existing goals (optional)
      await database.delete(database.goals).go();

      // Insert goals
      for (final goal in goals) {
        await database.into(database.goals).insert(goal);
      }

      print('Successfully seeded ${goals.length} goals');
    } catch (e) {
      print('Error seeding goals: $e');
      rethrow;
    }
  }

  /// Seed exercise categories from CSV file
  static Future<void> seedExerciseCategories(AppDatabase database) async {
    try {
      print('Seeding exercise categories from CSV...');
      final csvPath = '$_dataPath/exercise_categories_rows.csv';
      final categories = await CsvParser.parseExerciseCategories(csvPath);
      
      if (categories.isEmpty) {
        print('No exercise categories found in CSV file');
        return;
      }

      // Clear existing categories (optional)
      await database.delete(database.exerciseCategories).go();

      // Insert categories
      for (final category in categories) {
        await database.into(database.exerciseCategories).insert(category);
      }

      print('Successfully seeded ${categories.length} exercise categories');
    } catch (e) {
      print('Error seeding exercise categories: $e');
      rethrow;
    }
  }

  /// Seed equipment from CSV file
  static Future<void> seedEquipment(AppDatabase database) async {
    try {
      print('Seeding equipment from CSV...');
      final csvPath = '$_dataPath/exercise_equipment_rows.csv';
      final equipment = await CsvParser.parseEquipment(csvPath);
      
      if (equipment.isEmpty) {
        print('No equipment found in CSV file');
        return;
      }

      // Clear existing equipment (optional)
      await database.delete(database.equipment).go();

      // Insert equipment
      for (final equipmentItem in equipment) {
        await database.into(database.equipment).insert(equipmentItem);
      }

      print('Successfully seeded ${equipment.length} equipment items');
    } catch (e) {
      print('Error seeding equipment: $e');
      rethrow;
    }
  }

  /// Seed goal progress from CSV file
  static Future<void> seedGoalProgress(AppDatabase database) async {
    try {
      print('Seeding goal progress from CSV...');
      final csvPath = '$_dataPath/goal_progress_rows.csv';
      final progressEntries = await CsvParser.parseGoalProgress(csvPath);
      
      if (progressEntries.isEmpty) {
        print('No goal progress found in CSV file');
        return;
      }

      // Clear existing goal progress (optional)
      await database.delete(database.goalProgress).go();

      // Insert goal progress
      for (final progress in progressEntries) {
        await database.into(database.goalProgress).insert(progress);
      }

      print('Successfully seeded ${progressEntries.length} goal progress entries');
    } catch (e) {
      print('Error seeding goal progress: $e');
      rethrow;
    }
  }

  /// Check if seeding is needed (database is empty)
  static Future<bool> needsSeeding(AppDatabase database) async {
    final exerciseCount = await (database.select(database.exercises)..limit(1)).get();
    return exerciseCount.isEmpty;
  }

  /// Verify seeded data
  static Future<void> verifySeedData(AppDatabase database) async {
    final exerciseCount = await database.select(database.exercises).get();
    final goalCount = await database.select(database.goals).get();
    final categoryCount = await database.select(database.exerciseCategories).get();
    final equipmentCount = await database.select(database.equipment).get();
    final progressCount = await database.select(database.goalProgress).get();

    print('Seed verification:');
    print('  Exercises: ${exerciseCount.length}');
    print('  Goals: ${goalCount.length}');
    print('  Categories: ${categoryCount.length}');
    print('  Equipment: ${equipmentCount.length}');
    print('  Goal Progress: ${progressCount.length}');
  }

  /// Seed demo exercises for web platform
  static Future<void> _seedDemoExercises(AppDatabase database) async {
    final demoExercises = [
      ExercisesCompanion.insert(
        id: _uuid.v4(),
        exerciseId: 'barbell-squat',
        name: 'Barbell Squat',
        defaultEquipment: 'barbell',
        availableEquipment: const Value('["barbell", "squat_rack"]'),
        exerciseTypes: const Value('["compound", "lower_body"]'),
        primaryMuscles: const Value('["quadriceps", "glutes"]'),
        secondaryMuscles: const Value('["hamstrings", "core"]'),
        bodyParts: const Value('["lower_body"]'),
        startingWeightLbs: const Value(95.0),
        startingWeightKg: const Value(43.0),
        description: const Value('The barbell squat is a fundamental compound exercise that targets the lower body muscles.'),
        instructions: const Value('1. Position the barbell on your upper back\n2. Stand with feet shoulder-width apart\n3. Lower into squat position\n4. Drive through heels to return to standing'),
        tips: const Value('Keep your chest up and knees tracking over toes. Start with bodyweight before adding load.'),
        difficultyLevel: const Value(3),
        safetyRating: const Value(4),
        isCompound: const Value(true),
        requiresSpotter: const Value(false),
      ),
      ExercisesCompanion.insert(
        id: _uuid.v4(),
        exerciseId: 'bench-press',
        name: 'Barbell Bench Press',
        defaultEquipment: 'barbell',
        availableEquipment: const Value('["barbell", "bench"]'),
        exerciseTypes: const Value('["compound", "upper_body"]'),
        primaryMuscles: const Value('["chest", "triceps"]'),
        secondaryMuscles: const Value('["shoulders"]'),
        bodyParts: const Value('["upper_body"]'),
        startingWeightLbs: const Value(65.0),
        startingWeightKg: const Value(29.0),
        description: const Value('The bench press is a classic upper body compound exercise targeting the chest, shoulders, and triceps.'),
        instructions: const Value('1. Lie on bench with feet flat on floor\n2. Grip barbell slightly wider than shoulders\n3. Lower bar to chest with control\n4. Press bar up explosively'),
        tips: const Value('Keep shoulder blades retracted and maintain arch in lower back. Always use a spotter when possible.'),
        difficultyLevel: const Value(3),
        safetyRating: const Value(3),
        isCompound: const Value(true),
        requiresSpotter: const Value(true),
      ),
      ExercisesCompanion.insert(
        id: _uuid.v4(),
        exerciseId: 'deadlift',
        name: 'Deadlift',
        defaultEquipment: 'barbell',
        availableEquipment: const Value('["barbell"]'),
        exerciseTypes: const Value('["compound", "full_body"]'),
        primaryMuscles: const Value('["hamstrings", "glutes", "erector_spinae"]'),
        secondaryMuscles: const Value('["quadriceps", "traps", "lats"]'),
        bodyParts: const Value('["full_body"]'),
        startingWeightLbs: const Value(135.0),
        startingWeightKg: const Value(61.0),
        description: const Value('The deadlift is one of the most effective full-body exercises, targeting the posterior chain.'),
        instructions: const Value('1. Stand with feet hip-width apart, bar over mid-foot\n2. Hinge at hips and grip bar\n3. Keep chest up, drive through heels\n4. Stand tall, then reverse the movement'),
        tips: const Value('Maintain neutral spine throughout the movement. Start light and focus on proper form.'),
        difficultyLevel: const Value(4),
        safetyRating: const Value(3),
        isCompound: const Value(true),
        requiresSpotter: const Value(false),
      ),
    ];

    for (final exercise in demoExercises) {
      await database.into(database.exercises).insert(exercise);
    }
  }

  /// Seed demo goals for web platform
  static Future<void> _seedDemoGoals(AppDatabase database) async {
    final demoGoals = [
      GoalsCompanion.insert(
        id: _uuid.v4(),
        userId: 'demo-user',
        name: 'Bench Press 1RM',
        description: const Value('Increase bench press one-rep max'),
        color: const Value('#FF5722'),
        goalType: 'strength',
        exerciseId: const Value('bench-press'),
        exerciseName: const Value('Barbell Bench Press'),
        targetValue: 200.0,
        currentValue: const Value(135.0),
        unit: 'lbs',
        startDate: Value(DateTime.now().subtract(const Duration(days: 30))),
        targetDate: Value(DateTime.now().add(const Duration(days: 60))),
      ),
      GoalsCompanion.insert(
        id: _uuid.v4(),
        userId: 'demo-user',
        name: 'Squat 225lbs',
        description: const Value('Achieve 225lb squat for 1 rep'),
        color: const Value('#4CAF50'),
        goalType: 'strength',
        exerciseId: const Value('barbell-squat'),
        exerciseName: const Value('Barbell Squat'),
        targetValue: 225.0,
        currentValue: const Value(185.0),
        unit: 'lbs',
        startDate: Value(DateTime.now().subtract(const Duration(days: 45))),
        targetDate: Value(DateTime.now().add(const Duration(days: 90))),
      ),
    ];

    for (final goal in demoGoals) {
      await database.into(database.goals).insert(goal);
    }
  }
}