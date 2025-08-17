import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/database_providers.dart';
import '../../../../domain/services/progression_service.dart';
import '../../../../domain/services/workout_generation_service.dart';
import '../../../../domain/entities/workout.dart';
import '../../../../domain/entities/workout_set.dart';
import 'program_providers.dart';

// Progression service provider (static service - no instance needed)
// ProgressionService is a static utility class, so we don't need a provider for it

// Workout generation service provider
final workoutGenerationServiceProvider = Provider<WorkoutGenerationService>((ref) {
  final programRepository = ref.watch(programRepositoryProvider);
  final userProgramRepository = ref.watch(userProgramRepositoryProvider);
  final workoutRepository = ref.watch(workoutRepositoryProvider);
  
  return WorkoutGenerationService(
    programRepository,
    userProgramRepository,
    workoutRepository,
  );
});

// Generate next workout for a user program
final generateNextWorkoutProvider = FutureProvider.family<Workout, String>((ref, userProgramId) async {
  final workoutGenerationService = ref.read(workoutGenerationServiceProvider);
  return await workoutGenerationService.generateNextWorkout(userProgramId);
});

// Generate upcoming workouts preview
final upcomingWorkoutsProvider = FutureProvider.family<List<Workout>, String>((ref, userProgramId) async {
  final workoutGenerationService = ref.read(workoutGenerationServiceProvider);
  return await workoutGenerationService.generateUpcomingWorkouts(userProgramId, count: 7);
});

// Generate specific workout for week and day
final generateWorkoutForWeekDayProvider = FutureProvider.family<Workout, Map<String, dynamic>>((ref, params) async {
  final workoutGenerationService = ref.read(workoutGenerationServiceProvider);
  return await workoutGenerationService.generateWorkoutForWeekAndDay(
    userProgramId: params['userProgramId'] as String,
    weekNumber: params['weekNumber'] as int,
    dayNumber: params['dayNumber'] as int,
  );
});

// Start workout session
Future<Workout> startWorkoutSession(WidgetRef ref, String workoutId) async {
  final workoutGenerationService = ref.read(workoutGenerationServiceProvider);
  final updatedWorkout = await workoutGenerationService.startWorkoutSession(workoutId);
  
  // Invalidate related providers to refresh UI
  ref.invalidate(generateNextWorkoutProvider);
  ref.invalidate(upcomingWorkoutsProvider);
  
  return updatedWorkout;
}

// Complete workout session
Future<Workout> completeWorkoutSession(
  WidgetRef ref, 
  String workoutId, 
  List<WorkoutSet> completedSets,
) async {
  final workoutGenerationService = ref.read(workoutGenerationServiceProvider);
  final completedWorkout = await workoutGenerationService.completeWorkoutSession(
    workoutId, 
    completedSets,
  );
  
  // Invalidate related providers to refresh UI
  ref.invalidate(generateNextWorkoutProvider);
  ref.invalidate(upcomingWorkoutsProvider);
  ref.invalidate(userProgramsProvider);
  
  return completedWorkout;
}