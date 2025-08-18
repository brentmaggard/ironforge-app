import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../domain/services/workout_session_service.dart';
import '../../../../domain/entities/workout_session.dart';
import '../../../../core/providers/database_providers.dart';

/// Provider for WorkoutSessionService with dependency injection
final workoutSessionServiceProvider = Provider<WorkoutSessionService>((ref) {
  final workoutRepository = ref.watch(workoutRepositoryProvider);
  final exerciseRepository = ref.watch(exerciseRepositoryProvider);
  
  return WorkoutSessionService(workoutRepository, exerciseRepository);
});

/// Provider for active workout session state
final activeWorkoutSessionProvider = FutureProvider<WorkoutSession?>((ref) async {
  final service = ref.watch(workoutSessionServiceProvider);
  
  // TODO: Get actual user ID from auth system
  const userId = 'demo-user-id';
  
  return await service.getActiveWorkoutSession(userId);
});

/// Provider for loading a specific workout session by ID
final workoutSessionProvider = FutureProvider.family<WorkoutSession?, String>((ref, workoutId) async {
  final service = ref.watch(workoutSessionServiceProvider);
  
  return await service.loadWorkoutSession(workoutId);
});