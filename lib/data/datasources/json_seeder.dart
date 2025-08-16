import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import 'database.dart';

/// JSON-based seeder that imports data from JSON asset files
/// This is more reliable than CSV parsing for complex data structures
class JsonSeeder {
  static const _uuid = Uuid();

  /// Seed all data from JSON files
  static Future<void> seedAllData(AppDatabase database) async {
    try {
      print('Starting JSON data seeding...');
      // Skip equipment and categories for now due to schema issues
      // await seedEquipment(database);
      // await seedExerciseCategories(database);
      await seedExercises(database);
      // Skip goals for now due to date parsing issues
      print('JSON data seeding completed successfully');
    } catch (e) {
      print('Error during JSON data seeding: $e');
      rethrow;
    }
  }

  /// Seed exercises from JSON file
  static Future<void> seedExercises(AppDatabase database) async {
    try {
      print('Seeding exercises from JSON...');
      final jsonString = await rootBundle.loadString('assets/data/exercises_rows.json');
      final List<dynamic> exerciseData = jsonDecode(jsonString);
      
      print('Found ${exerciseData.length} exercises in JSON');
      
      final exercises = <ExercisesCompanion>[];
      
      for (final data in exerciseData) {
        try {
          final exercise = ExercisesCompanion.insert(
            id: _uuid.v4(),
            exerciseId: data['exercise_id'] ?? 'unknown',
            name: data['name'] ?? 'Unknown Exercise',
            defaultEquipment: data['default_equipment'] ?? 'bodyweight',
            availableEquipment: data['available_equipment'] != null 
                ? Value(jsonEncode(data['available_equipment']))
                : const Value.absent(),
            exerciseTypes: data['exercise_types'] != null 
                ? Value(jsonEncode(data['exercise_types']))
                : const Value.absent(),
            primaryMuscles: data['primary_muscles'] != null 
                ? Value(jsonEncode(data['primary_muscles']))
                : const Value.absent(),
            secondaryMuscles: data['secondary_muscles'] != null 
                ? Value(jsonEncode(data['secondary_muscles']))
                : const Value.absent(),
            bodyParts: data['body_parts'] != null 
                ? Value(jsonEncode(data['body_parts']))
                : const Value.absent(),
            startingWeightLbs: data['starting_weight_lbs'] != null && data['starting_weight_lbs'].toString().isNotEmpty
                ? Value(double.tryParse(data['starting_weight_lbs'].toString()) ?? 0.0)
                : const Value.absent(),
            startingWeightKg: data['starting_weight_kg'] != null && data['starting_weight_kg'].toString().isNotEmpty
                ? Value(double.tryParse(data['starting_weight_kg'].toString()) ?? 0.0)
                : const Value.absent(),
            defaultWarmupWeight: data['default_warmup_weight'] != null && data['default_warmup_weight'].toString().isNotEmpty
                ? Value(double.tryParse(data['default_warmup_weight'].toString()) ?? 0.0)
                : const Value.absent(),
            description: data['description'] != null 
                ? Value(data['description'].toString())
                : const Value.absent(),
            instructions: data['instructions'] != null 
                ? Value(data['instructions'].toString())
                : const Value.absent(),
            tips: data['tips'] != null 
                ? Value(data['tips'].toString())
                : const Value.absent(),
            videoUrl: data['video_url'] != null 
                ? Value(data['video_url'].toString())
                : const Value.absent(),
            imageUrlSmall: data['image_url_small'] != null 
                ? Value(data['image_url_small'].toString())
                : const Value.absent(),
            imageUrlLarge: data['image_url_large'] != null 
                ? Value(data['image_url_large'].toString())
                : const Value.absent(),
            hasCustomImage: data['has_custom_image'] != null 
                ? Value(data['has_custom_image'] == true)
                : const Value(false),
            difficultyLevel: data['difficulty_level'] != null 
                ? Value(data['difficulty_level'])
                : const Value(3),
            safetyRating: data['safety_rating'] != null 
                ? Value(data['safety_rating'])
                : const Value(3),
            isCompound: data['is_compound'] != null 
                ? Value(data['is_compound'] == true)
                : const Value(false),
            isUnilateral: data['is_unilateral'] != null 
                ? Value(data['is_unilateral'] == true)
                : const Value(false),
            requiresSpotter: data['requires_spotter'] != null 
                ? Value(data['requires_spotter'] == true)
                : const Value(false),
            isActive: data['is_active'] != null 
                ? Value(data['is_active'] == true)
                : const Value(true),
          );
          
          exercises.add(exercise);
        } catch (e) {
          print('Error parsing exercise: ${data['name']} - $e');
          continue;
        }
      }
      
      // Batch insert exercises
      const batchSize = 20;
      for (int i = 0; i < exercises.length; i += batchSize) {
        final exerciseBatch = exercises.skip(i).take(batchSize).toList();
        await database.batch((batch) {
          for (final exercise in exerciseBatch) {
            batch.insert(database.exercises, exercise);
          }
        });
      }
      
      print('Successfully seeded ${exercises.length} exercises');
    } catch (e) {
      print('Error seeding exercises: $e');
      rethrow;
    }
  }

  /// Seed exercise categories from JSON file
  static Future<void> seedExerciseCategories(AppDatabase database) async {
    try {
      print('Seeding exercise categories from JSON...');
      final jsonString = await rootBundle.loadString('assets/data/exercise_categories_rows.json');
      final List<dynamic> categoryData = jsonDecode(jsonString);
      
      final categories = <ExerciseCategoriesCompanion>[];
      
      for (final data in categoryData) {
        final category = ExerciseCategoriesCompanion(
          id: Value(_uuid.v4()),
          name: Value(data['name'] ?? 'Unknown Category'),
          description: data['description'] != null 
              ? Value(data['description'].toString())
              : const Value.absent(),
          color: data['color'] != null 
              ? Value(data['color'].toString())
              : const Value.absent(),
          icon: data['icon'] != null 
              ? Value(data['icon'].toString())
              : const Value.absent(),
          sortOrder: data['sort_order'] != null 
              ? Value(data['sort_order'])
              : const Value(0),
          isActive: data['is_active'] != null 
              ? Value(data['is_active'] == true)
              : const Value(true),
        );
        
        categories.add(category);
      }
      
      for (final category in categories) {
        await database.into(database.exerciseCategories).insert(category);
      }
      
      print('Successfully seeded ${categories.length} exercise categories');
    } catch (e) {
      print('Error seeding exercise categories: $e');
      rethrow;
    }
  }

  /// Seed equipment from JSON file
  static Future<void> seedEquipment(AppDatabase database) async {
    try {
      print('Seeding equipment from JSON...');
      final jsonString = await rootBundle.loadString('assets/data/exercise_equipment_rows.json');
      final List<dynamic> equipmentData = jsonDecode(jsonString);
      
      final equipment = <EquipmentCompanion>[];
      
      for (final data in equipmentData) {
        // Create equipment without equipmentId to avoid column mismatch
        final equipmentItem = EquipmentCompanion(
          id: Value(_uuid.v4()),
          name: Value(data['name'] ?? 'Unknown Equipment'),
          description: data['description'] != null 
              ? Value(data['description'].toString())
              : const Value.absent(),
          isActive: data['is_active'] != null 
              ? Value(data['is_active'] == true)
              : const Value(true),
        );
        
        equipment.add(equipmentItem);
      }
      
      for (final item in equipment) {
        await database.into(database.equipment).insert(item);
      }
      
      print('Successfully seeded ${equipment.length} equipment items');
    } catch (e) {
      print('Error seeding equipment: $e');
      rethrow;
    }
  }

  /// Check if database needs seeding
  static Future<bool> needsSeeding(AppDatabase database) async {
    final exerciseCount = await database.select(database.exercises).get();
    final categoryCount = await database.select(database.exerciseCategories).get();
    final equipmentCount = await database.select(database.equipment).get();
    
    return exerciseCount.isEmpty || categoryCount.isEmpty || equipmentCount.isEmpty;
  }
}