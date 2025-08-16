import 'package:flutter_test/flutter_test.dart';
import 'package:ironforge_app/data/datasources/database.dart';
import 'package:ironforge_app/data/datasources/csv_seeder.dart';
import 'package:ironforge_app/data/models/exercise_model.dart';
import 'package:drift/native.dart';
import 'package:drift/drift.dart';

void main() {
  group('CSV Import Tests', () {
    late AppDatabase database;

    setUp(() {
      // Create in-memory database for testing
      database = AppDatabase.forTesting(NativeDatabase.memory());
    });

    tearDown(() async {
      await database.close();
    });

    test('Database schema migration works', () async {
      // Test that the database can be created with new schema
      final exerciseCount = await database.select(database.exercises).get();
      expect(exerciseCount, isEmpty);
    });

    test('CSV seeder needs seeding when database is empty', () async {
      final needsSeeding = await CsvSeeder.needsSeeding(database);
      expect(needsSeeding, isTrue);
    });

    test('Database has correct structure for new fields', () async {
      // Insert a test exercise with new structure
      final testExercise = ExercisesCompanion.insert(
        id: 'test-id',
        exerciseId: 'test-exercise',
        name: 'Test Exercise',
        defaultEquipment: 'barbell',
      );

      await database.into(database.exercises).insert(testExercise);
      
      final exercises = await database.select(database.exercises).get();
      expect(exercises.length, 1);
      expect(exercises.first.name, 'Test Exercise');
      expect(exercises.first.defaultEquipment, 'barbell');
    });

    test('Exercise entity conversion works with new fields', () async {
      // Test the new entity conversion
      final testExercise = ExercisesCompanion.insert(
        id: 'test-id',
        exerciseId: 'test-exercise',
        name: 'Test Exercise',
        defaultEquipment: 'barbell',
      );

      await database.into(database.exercises).insert(testExercise);
      
      final exercises = await database.select(database.exercises).get();
      final entity = exercises.first.toEntity();
      
      expect(entity.name, 'Test Exercise');
      expect(entity.defaultEquipment, 'barbell');
      expect(entity.equipment, 'barbell'); // Legacy compatibility
    });
  });
}