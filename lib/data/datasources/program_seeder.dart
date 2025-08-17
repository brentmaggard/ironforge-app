import 'database.dart';
import 'program_templates.dart';
import '../models/program_model.dart';

class ProgramSeeder {
  /// Seed program templates into the database
  static Future<void> seedProgramTemplates(AppDatabase database) async {
    // Check if we already have program templates
    final count = await (database.select(database.programs)..where((p) => p.isTemplate.equals(true))).get();
    if (count.isNotEmpty) {
      print('Database already has ${count.length} program templates, skipping seeding');
      return;
    }

    print('Seeding program templates...');

    try {
      // Insert all program templates
      for (final program in ProgramTemplates.allTemplates) {
        await database.into(database.programs).insert(program.toCompanion());
        print('Seeded program: ${program.name}');
      }

      final newCount = await database.select(database.programs).get();
      print('Successfully seeded ${ProgramTemplates.allTemplates.length} program templates');
      print('Total programs in database: ${newCount.length}');
    } catch (e) {
      print('Error seeding program templates: $e');
      rethrow;
    }
  }

  /// Clear all program data
  static Future<void> clearPrograms(AppDatabase database) async {
    await database.transaction(() async {
      await database.delete(database.programSessions).go();
      await database.delete(database.userPrograms).go();
      await database.delete(database.programs).go();
    });
    print('Cleared all program data');
  }

  /// Reseed program templates (clear and recreate)
  static Future<void> reseedProgramTemplates(AppDatabase database) async {
    await clearPrograms(database);
    await seedProgramTemplates(database);
  }
}