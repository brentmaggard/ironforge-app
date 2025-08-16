import 'dart:convert';
import 'package:flutter/services.dart';

/// Simple test function to check if JSON assets can be loaded
Future<void> testJsonLoading() async {
  try {
    print('=== Testing JSON Asset Loading ===');
    
    // Test loading exercises JSON
    try {
      final exercisesJson = await rootBundle.loadString('assets/data/exercises_rows.json');
      final exercisesData = jsonDecode(exercisesJson) as List;
      print('✅ Exercises JSON loaded: ${exercisesData.length} items');
      
      if (exercisesData.isNotEmpty) {
        final firstExercise = exercisesData.first;
        print('First exercise: ${firstExercise['name']}');
      }
    } catch (e) {
      print('❌ Failed to load exercises JSON: $e');
    }

    // Test loading categories JSON
    try {
      final categoriesJson = await rootBundle.loadString('assets/data/exercise_categories_rows.json');
      final categoriesData = jsonDecode(categoriesJson) as List;
      print('✅ Categories JSON loaded: ${categoriesData.length} items');
    } catch (e) {
      print('❌ Failed to load categories JSON: $e');
    }

    // Test loading equipment JSON
    try {
      final equipmentJson = await rootBundle.loadString('assets/data/exercise_equipment_rows.json');
      final equipmentData = jsonDecode(equipmentJson) as List;
      print('✅ Equipment JSON loaded: ${equipmentData.length} items');
    } catch (e) {
      print('❌ Failed to load equipment JSON: $e');
    }

    print('=== JSON Loading Test Complete ===');
  } catch (e) {
    print('❌ Overall test failed: $e');
  }
}