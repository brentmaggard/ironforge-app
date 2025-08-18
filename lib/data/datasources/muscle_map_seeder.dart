import 'dart:convert';
import 'package:drift/drift.dart';
import 'database.dart';

class MuscleMapSeeder {
  /// Maps existing muscle names to ScreenMuscle groups
  static const Map<String, String> muscleToScreenMuscleMap = {
    // Chest muscles
    'chest': 'chest',
    'pectoralis': 'chest',
    'pectoralis_major': 'chest',
    'pectoral': 'chest',
    
    // Back muscles
    'back': 'back',
    'latissimus_dorsi': 'back',
    'lat': 'back',
    'lats': 'back',
    'rhomboids': 'back',
    'trapezius': 'back',
    'trap': 'back',
    'traps': 'back',
    'rear_delt': 'back',
    'posterior_deltoid': 'back',
    'middle_trapezius': 'back',
    'lower_trapezius': 'back',
    'upper_trapezius': 'back',
    
    // Shoulders
    'shoulders': 'shoulders',
    'shoulder': 'shoulders',
    'deltoids': 'shoulders',
    'deltoid': 'shoulders',
    'anterior_deltoid': 'shoulders',
    'front_delt': 'shoulders',
    'medial_deltoid': 'shoulders',
    'side_delt': 'shoulders',
    'lateral_deltoid': 'shoulders',
    
    // Biceps
    'biceps': 'biceps',
    'bicep': 'biceps',
    'biceps_brachii': 'biceps',
    'brachialis': 'biceps',
    
    // Triceps
    'triceps': 'triceps',
    'tricep': 'triceps',
    'triceps_brachii': 'triceps',
    
    // Abs/Core
    'abs': 'abs',
    'core': 'abs',
    'abdominals': 'abs',
    'rectus_abdominis': 'abs',
    'obliques': 'abs',
    'transverse_abdominis': 'abs',
    
    // Quadriceps
    'quadriceps': 'quadriceps',
    'quads': 'quadriceps',
    'quad': 'quadriceps',
    'vastus_lateralis': 'quadriceps',
    'vastus_medialis': 'quadriceps',
    'vastus_intermedius': 'quadriceps',
    'rectus_femoris': 'quadriceps',
    
    // Hamstrings
    'hamstrings': 'hamstrings',
    'hamstring': 'hamstrings',
    'biceps_femoris': 'hamstrings',
    'semitendinosus': 'hamstrings',
    'semimembranosus': 'hamstrings',
    
    // Glutes
    'glutes': 'glutes',
    'glute': 'glutes',
    'gluteus_maximus': 'glutes',
    'gluteus_medius': 'glutes',
    'gluteus_minimus': 'glutes',
    
    // Calves
    'calves': 'calves',
    'calf': 'calves',
    'gastrocnemius': 'calves',
    'soleus': 'calves',
    
    // Forearms
    'forearms': 'forearms',
    'forearm': 'forearms',
    'wrist_flexors': 'forearms',
    'wrist_extensors': 'forearms',
  };
  
  /// Exercise-specific muscle group mappings for common exercises
  static const Map<String, ExerciseMuscleMapping> exerciseMuscleOverrides = {
    // Chest exercises
    'bench_press': ExerciseMuscleMapping(
      targetMuscleGroups: ['chest'],
      synergistMuscleGroups: ['shoulders', 'triceps'],
    ),
    'barbell_bench_press': ExerciseMuscleMapping(
      targetMuscleGroups: ['chest'],
      synergistMuscleGroups: ['shoulders', 'triceps'],
    ),
    'dumbbell_bench_press': ExerciseMuscleMapping(
      targetMuscleGroups: ['chest'],
      synergistMuscleGroups: ['shoulders', 'triceps'],
    ),
    'incline_bench_press': ExerciseMuscleMapping(
      targetMuscleGroups: ['chest'],
      synergistMuscleGroups: ['shoulders', 'triceps'],
    ),
    'push_ups': ExerciseMuscleMapping(
      targetMuscleGroups: ['chest'],
      synergistMuscleGroups: ['shoulders', 'triceps', 'abs'],
    ),
    'chest_fly': ExerciseMuscleMapping(
      targetMuscleGroups: ['chest'],
      synergistMuscleGroups: ['shoulders'],
    ),
    'dumbbell_fly': ExerciseMuscleMapping(
      targetMuscleGroups: ['chest'],
      synergistMuscleGroups: ['shoulders'],
    ),
    
    // Back exercises
    'bent_over_row': ExerciseMuscleMapping(
      targetMuscleGroups: ['back'],
      synergistMuscleGroups: ['biceps', 'shoulders'],
    ),
    'barbell_bent_over_row': ExerciseMuscleMapping(
      targetMuscleGroups: ['back'],
      synergistMuscleGroups: ['biceps', 'shoulders'],
    ),
    'dumbbell_row': ExerciseMuscleMapping(
      targetMuscleGroups: ['back'],
      synergistMuscleGroups: ['biceps', 'shoulders'],
    ),
    'pull_ups': ExerciseMuscleMapping(
      targetMuscleGroups: ['back'],
      synergistMuscleGroups: ['biceps'],
    ),
    'chin_ups': ExerciseMuscleMapping(
      targetMuscleGroups: ['back'],
      synergistMuscleGroups: ['biceps'],
    ),
    'lat_pulldown': ExerciseMuscleMapping(
      targetMuscleGroups: ['back'],
      synergistMuscleGroups: ['biceps'],
    ),
    'cable_row': ExerciseMuscleMapping(
      targetMuscleGroups: ['back'],
      synergistMuscleGroups: ['biceps', 'shoulders'],
    ),
    'deadlift': ExerciseMuscleMapping(
      targetMuscleGroups: ['back', 'hamstrings', 'glutes'],
      synergistMuscleGroups: ['quadriceps', 'forearms', 'abs'],
    ),
    
    // Leg exercises
    'squat': ExerciseMuscleMapping(
      targetMuscleGroups: ['quadriceps', 'glutes'],
      synergistMuscleGroups: ['hamstrings', 'abs'],
    ),
    'barbell_squat': ExerciseMuscleMapping(
      targetMuscleGroups: ['quadriceps', 'glutes'],
      synergistMuscleGroups: ['hamstrings', 'abs'],
    ),
    'front_squat': ExerciseMuscleMapping(
      targetMuscleGroups: ['quadriceps'],
      synergistMuscleGroups: ['glutes', 'abs'],
    ),
    'leg_press': ExerciseMuscleMapping(
      targetMuscleGroups: ['quadriceps', 'glutes'],
      synergistMuscleGroups: ['hamstrings'],
    ),
    'romanian_deadlift': ExerciseMuscleMapping(
      targetMuscleGroups: ['hamstrings', 'glutes'],
      synergistMuscleGroups: ['back'],
    ),
    'leg_curl': ExerciseMuscleMapping(
      targetMuscleGroups: ['hamstrings'],
      synergistMuscleGroups: [],
    ),
    'leg_extension': ExerciseMuscleMapping(
      targetMuscleGroups: ['quadriceps'],
      synergistMuscleGroups: [],
    ),
    'calf_raise': ExerciseMuscleMapping(
      targetMuscleGroups: ['calves'],
      synergistMuscleGroups: [],
    ),
    'standing_calf_raise': ExerciseMuscleMapping(
      targetMuscleGroups: ['calves'],
      synergistMuscleGroups: [],
    ),
    'seated_calf_raise': ExerciseMuscleMapping(
      targetMuscleGroups: ['calves'],
      synergistMuscleGroups: [],
    ),
    
    // Shoulder exercises
    'shoulder_press': ExerciseMuscleMapping(
      targetMuscleGroups: ['shoulders'],
      synergistMuscleGroups: ['triceps', 'abs'],
    ),
    'dumbbell_shoulder_press': ExerciseMuscleMapping(
      targetMuscleGroups: ['shoulders'],
      synergistMuscleGroups: ['triceps', 'abs'],
    ),
    'overhead_press': ExerciseMuscleMapping(
      targetMuscleGroups: ['shoulders'],
      synergistMuscleGroups: ['triceps', 'abs'],
    ),
    'lateral_raise': ExerciseMuscleMapping(
      targetMuscleGroups: ['shoulders'],
      synergistMuscleGroups: [],
    ),
    'front_raise': ExerciseMuscleMapping(
      targetMuscleGroups: ['shoulders'],
      synergistMuscleGroups: [],
    ),
    'rear_delt_fly': ExerciseMuscleMapping(
      targetMuscleGroups: ['shoulders'],
      synergistMuscleGroups: ['back'],
    ),
    
    // Arm exercises
    'bicep_curl': ExerciseMuscleMapping(
      targetMuscleGroups: ['biceps'],
      synergistMuscleGroups: ['forearms'],
    ),
    'barbell_curl': ExerciseMuscleMapping(
      targetMuscleGroups: ['biceps'],
      synergistMuscleGroups: ['forearms'],
    ),
    'dumbbell_curl': ExerciseMuscleMapping(
      targetMuscleGroups: ['biceps'],
      synergistMuscleGroups: ['forearms'],
    ),
    'hammer_curl': ExerciseMuscleMapping(
      targetMuscleGroups: ['biceps'],
      synergistMuscleGroups: ['forearms'],
    ),
    'tricep_extension': ExerciseMuscleMapping(
      targetMuscleGroups: ['triceps'],
      synergistMuscleGroups: [],
    ),
    'tricep_dips': ExerciseMuscleMapping(
      targetMuscleGroups: ['triceps'],
      synergistMuscleGroups: ['chest', 'shoulders'],
    ),
    'close_grip_bench_press': ExerciseMuscleMapping(
      targetMuscleGroups: ['triceps'],
      synergistMuscleGroups: ['chest', 'shoulders'],
    ),
    
    // Core exercises
    'plank': ExerciseMuscleMapping(
      targetMuscleGroups: ['abs'],
      synergistMuscleGroups: ['shoulders', 'glutes'],
    ),
    'crunch': ExerciseMuscleMapping(
      targetMuscleGroups: ['abs'],
      synergistMuscleGroups: [],
    ),
    'sit_ups': ExerciseMuscleMapping(
      targetMuscleGroups: ['abs'],
      synergistMuscleGroups: [],
    ),
    'russian_twist': ExerciseMuscleMapping(
      targetMuscleGroups: ['abs'],
      synergistMuscleGroups: [],
    ),
    'mountain_climbers': ExerciseMuscleMapping(
      targetMuscleGroups: ['abs'],
      synergistMuscleGroups: ['shoulders', 'quadriceps'],
    ),
  };
  
  /// Convert muscle names from database to ScreenMuscle groups
  static List<String> mapMuscleNamesToScreenMuscles(List<String>? muscleNames) {
    if (muscleNames == null || muscleNames.isEmpty) return [];
    
    final screenMuscles = <String>{};
    
    for (final muscle in muscleNames) {
      final normalizedMuscle = muscle.toLowerCase().replaceAll(' ', '_');
      
      // Check for exact match first
      if (muscleToScreenMuscleMap.containsKey(normalizedMuscle)) {
        screenMuscles.add(muscleToScreenMuscleMap[normalizedMuscle]!);
        continue;
      }
      
      // Check for partial matches
      for (final entry in muscleToScreenMuscleMap.entries) {
        if (normalizedMuscle.contains(entry.key) || entry.key.contains(normalizedMuscle)) {
          screenMuscles.add(entry.value);
          break;
        }
      }
    }
    
    return screenMuscles.toList();
  }
  
  /// Get muscle mapping for a specific exercise
  static ExerciseMuscleMapping? getExerciseMapping(String exerciseId) {
    return exerciseMuscleOverrides[exerciseId.toLowerCase()];
  }
  
  /// Seed muscle map data for all exercises in the database
  static Future<void> seedExerciseMuscleMap(AppDatabase database) async {
    print('Starting muscle map seeding...');
    
    final exercises = await database.select(database.exercises).get();
    print('Found ${exercises.length} exercises to update');
    
    int updatedCount = 0;
    
    for (final exercise in exercises) {
      List<String> targetMuscleGroups = [];
      List<String> synergistMuscleGroups = [];
      
      // Check for exercise-specific override first
      final override = getExerciseMapping(exercise.exerciseId);
      if (override != null) {
        targetMuscleGroups = override.targetMuscleGroups;
        synergistMuscleGroups = override.synergistMuscleGroups;
      } else {
        // Map from existing muscle data (stored as JSON arrays)
        List<String> primaryMuscles = [];
        List<String> secondaryMuscles = [];
        
        try {
          if (exercise.primaryMuscles != null) {
            final decoded = jsonDecode(exercise.primaryMuscles!) as List;
            primaryMuscles = decoded.cast<String>();
          }
        } catch (e) {
          primaryMuscles = [];
        }
        
        try {
          if (exercise.secondaryMuscles != null) {
            final decoded = jsonDecode(exercise.secondaryMuscles!) as List;
            secondaryMuscles = decoded.cast<String>();
          }
        } catch (e) {
          secondaryMuscles = [];
        }
            
        targetMuscleGroups = mapMuscleNamesToScreenMuscles(primaryMuscles);
        synergistMuscleGroups = mapMuscleNamesToScreenMuscles(secondaryMuscles);
      }
      
      // Update the exercise with muscle map data
      if (targetMuscleGroups.isNotEmpty || synergistMuscleGroups.isNotEmpty) {
        await (database.update(database.exercises)
              ..where((e) => e.id.equals(exercise.id)))
            .write(ExercisesCompanion(
              targetMuscleGroups: Value(targetMuscleGroups.isNotEmpty 
                  ? jsonEncode(targetMuscleGroups) 
                  : null),
              synergistMuscleGroups: Value(synergistMuscleGroups.isNotEmpty 
                  ? jsonEncode(synergistMuscleGroups) 
                  : null),
            ));
        
        updatedCount++;
        print('Updated ${exercise.name}: targets=$targetMuscleGroups, synergists=$synergistMuscleGroups');
      }
    }
    
    print('Muscle map seeding complete. Updated $updatedCount exercises.');
  }
}

class ExerciseMuscleMapping {
  final List<String> targetMuscleGroups;
  final List<String> synergistMuscleGroups;
  
  const ExerciseMuscleMapping({
    required this.targetMuscleGroups,
    required this.synergistMuscleGroups,
  });
}