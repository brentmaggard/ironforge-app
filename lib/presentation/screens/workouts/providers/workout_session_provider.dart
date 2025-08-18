import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../domain/entities/workout.dart';
import '../../../../domain/entities/workout_set.dart';
import '../../../../domain/entities/exercise.dart';
import '../../../../domain/repositories/workout_repository.dart';
import '../../../../core/providers/database_providers.dart';

// Workout session data model
class WorkoutSessionData {
  final Workout workout;
  final List<WorkoutExercise> exercises;
  final Duration elapsedTime;

  WorkoutSessionData({
    required this.workout,
    required this.exercises,
    required this.elapsedTime,
  });

  WorkoutSessionData copyWith({
    Workout? workout,
    List<WorkoutExercise>? exercises,
    Duration? elapsedTime,
  }) {
    return WorkoutSessionData(
      workout: workout ?? this.workout,
      exercises: exercises ?? this.exercises,
      elapsedTime: elapsedTime ?? this.elapsedTime,
    );
  }
}

// Workout exercise data model
class WorkoutExercise {
  final Exercise exercise;
  final int plannedSets;
  final int targetReps;
  final double targetWeight;
  final List<WorkoutSet> completedSets;

  WorkoutExercise({
    required this.exercise,
    required this.plannedSets,
    required this.targetReps,
    required this.targetWeight,
    required this.completedSets,
  });

  WorkoutExercise copyWith({
    Exercise? exercise,
    int? plannedSets,
    int? targetReps,
    double? targetWeight,
    List<WorkoutSet>? completedSets,
  }) {
    return WorkoutExercise(
      exercise: exercise ?? this.exercise,
      plannedSets: plannedSets ?? this.plannedSets,
      targetReps: targetReps ?? this.targetReps,
      targetWeight: targetWeight ?? this.targetWeight,
      completedSets: completedSets ?? this.completedSets,
    );
  }
}

// Workout session provider
class WorkoutSessionNotifier extends StateNotifier<WorkoutSessionData?> {
  final WorkoutRepository _workoutRepository;
  final Ref _ref;
  
  WorkoutSessionNotifier(this._workoutRepository, this._ref) : super(null);

  // Helper method to trigger workout list refresh
  void _triggerWorkoutRefresh() {
    final current = _ref.read(workoutRefreshProvider);
    _ref.read(workoutRefreshProvider.notifier).state = current + 1;
  }

  // Helper method to recalculate and update workout stats in database
  Future<void> _updateWorkoutStats() async {
    if (state != null) {
      // Calculate current stats from all sets
      int totalSets = state!.exercises.fold(0, (sum, ex) => sum + ex.completedSets.length);
      int totalReps = state!.exercises.fold(0, (sum, ex) => 
          sum + ex.completedSets.fold(0, (setSum, set) => setSum + set.reps));
      double totalVolume = state!.exercises.fold(0.0, (sum, ex) => 
          sum + ex.completedSets.fold(0.0, (setSum, set) => setSum + set.volume));

      // Update workout with new stats
      final updatedWorkout = state!.workout.copyWith(
        totalSets: totalSets,
        totalReps: totalReps,
        totalVolume: totalVolume,
        updatedAt: DateTime.now(),
      );

      try {
        // Save updated workout to database
        await _workoutRepository.updateWorkout(updatedWorkout);
        
        // Update local state
        state = state!.copyWith(workout: updatedWorkout);
      } catch (e) {
        print('Failed to update workout stats: $e');
      }
    }
  }

  void startWorkout(Workout workout) async {
    // Save workout to database if not already saved
    try {
      await _workoutRepository.createWorkout(workout);
    } catch (e) {
      // Workout might already exist, update it instead
      await _workoutRepository.updateWorkout(workout);
    }
    
    // Load existing exercises and sets from database
    final existingExercisesWithSets = await _workoutRepository.getWorkoutExercisesWithSets(workout.id);
    
    // Convert database exercises to WorkoutExercise format
    final List<WorkoutExercise> exercises = existingExercisesWithSets.map((exerciseData) {
      // Filter out placeholder sets (setNumber = 0 with 0 reps and 0 weight)
      final realSets = exerciseData.sets.where((set) => 
        !(set.setNumber == 0 && set.reps == 0 && set.weight == 0.0)).toList();
      
      return WorkoutExercise(
        exercise: exerciseData.exercise,
        plannedSets: 3, // Default planned sets - could be made configurable
        targetReps: 10, // Default target reps - could be made configurable  
        targetWeight: realSets.isNotEmpty ? realSets.last.weight : 0.0,
        completedSets: realSets,
      );
    }).toList();
    
    state = WorkoutSessionData(
      workout: workout,
      exercises: exercises,
      elapsedTime: Duration.zero,
    );
  }

  void updateElapsedTime(Duration elapsedTime) {
    if (state != null) {
      state = state!.copyWith(elapsedTime: elapsedTime);
    }
  }

  void addExercise(WorkoutExercise exercise) async {
    if (state != null) {
      final updatedExercises = [...state!.exercises, exercise];
      state = state!.copyWith(exercises: updatedExercises);
      
      // Create a placeholder set to ensure the exercise is persisted to database
      // This allows the exercise to be restored when the workout is resumed
      if (exercise.completedSets.isEmpty) {
        final placeholderSet = WorkoutSet(
          id: '${exercise.exercise.id}_placeholder_${DateTime.now().millisecondsSinceEpoch}',
          workoutId: state!.workout.id,
          exerciseId: exercise.exercise.id,
          setNumber: 0, // Placeholder set number
          reps: 0,
          weight: 0.0,
          isCompleted: false,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        
        try {
          await _workoutRepository.addWorkoutSet(placeholderSet);
        } catch (e) {
          // If adding placeholder fails, that's okay - the exercise just won't persist
          // In a production app, this could be logged to a proper logging service
        }
      }
    }
  }

  void removeExercise(int index) {
    if (state != null && index < state!.exercises.length) {
      final updatedExercises = [...state!.exercises]..removeAt(index);
      state = state!.copyWith(exercises: updatedExercises);
    }
  }

  void reorderExercises(int oldIndex, int newIndex) {
    if (state != null) {
      final exercises = [...state!.exercises];
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final exercise = exercises.removeAt(oldIndex);
      exercises.insert(newIndex, exercise);
      state = state!.copyWith(exercises: exercises);
    }
  }

  void addSet(int exerciseIndex, WorkoutSet set) async {
    if (state != null && exerciseIndex < state!.exercises.length) {
      try {
        // Save set to database
        await _workoutRepository.addWorkoutSet(set);
        
        // Update local state only if database save succeeds
        final exercises = [...state!.exercises];
        final exercise = exercises[exerciseIndex];
        final updatedSets = [...exercise.completedSets, set];
        exercises[exerciseIndex] = exercise.copyWith(completedSets: updatedSets);
        state = state!.copyWith(exercises: exercises);
        
        // Update workout stats in database
        await _updateWorkoutStats();
        
        // Trigger workout list refresh
        _triggerWorkoutRefresh();
      } catch (e) {
        // If database save fails, still update local state for UX
        // In production, this would be logged properly
        print('Failed to save set to database: $e');
        
        final exercises = [...state!.exercises];
        final exercise = exercises[exerciseIndex];
        final updatedSets = [...exercise.completedSets, set];
        exercises[exerciseIndex] = exercise.copyWith(completedSets: updatedSets);
        state = state!.copyWith(exercises: exercises);
        
        // Try to update stats even if set save failed
        await _updateWorkoutStats();
        
        // Still trigger refresh even on error to show any partial updates
        _triggerWorkoutRefresh();
      }
    }
  }

  void updateSet(int exerciseIndex, int setIndex, WorkoutSet updatedSet) async {
    if (state != null && 
        exerciseIndex < state!.exercises.length &&
        setIndex < state!.exercises[exerciseIndex].completedSets.length) {
      // Save set to database
      await _workoutRepository.updateWorkoutSet(updatedSet);
      
      // Update local state
      final exercises = [...state!.exercises];
      final exercise = exercises[exerciseIndex];
      final updatedSets = [...exercise.completedSets];
      updatedSets[setIndex] = updatedSet;
      exercises[exerciseIndex] = exercise.copyWith(completedSets: updatedSets);
      state = state!.copyWith(exercises: exercises);
      
      // Update workout stats in database
      await _updateWorkoutStats();
      
      // Trigger workout list refresh
      _triggerWorkoutRefresh();
    }
  }

  void removeSet(int exerciseIndex, int setIndex) async {
    if (state != null && 
        exerciseIndex < state!.exercises.length &&
        setIndex < state!.exercises[exerciseIndex].completedSets.length) {
      final setToDelete = state!.exercises[exerciseIndex].completedSets[setIndex];
      
      // Delete from database
      await _workoutRepository.deleteWorkoutSet(setToDelete.id);
      
      // Update local state
      final exercises = [...state!.exercises];
      final exercise = exercises[exerciseIndex];
      final updatedSets = [...exercise.completedSets]..removeAt(setIndex);
      exercises[exerciseIndex] = exercise.copyWith(completedSets: updatedSets);
      state = state!.copyWith(exercises: exercises);
      
      // Update workout stats in database
      await _updateWorkoutStats();
      
      // Trigger workout list refresh
      _triggerWorkoutRefresh();
    }
  }

  void completeWorkout() async {
    if (state != null) {
      // Calculate final stats
      int totalSets = state!.exercises.fold(0, (sum, ex) => sum + ex.completedSets.length);
      int totalReps = state!.exercises.fold(0, (sum, ex) => 
          sum + ex.completedSets.fold(0, (setSum, set) => setSum + set.reps));
      double totalVolume = state!.exercises.fold(0.0, (sum, ex) => 
          sum + ex.completedSets.fold(0.0, (setSum, set) => setSum + set.volume));

      final completedWorkout = state!.workout.copyWith(
        status: 'completed',
        completedAt: DateTime.now(),
        totalSets: totalSets,
        totalReps: totalReps,
        totalVolume: totalVolume,
        durationMinutes: state!.elapsedTime.inMinutes,
        updatedAt: DateTime.now(),
      );

      // Save completed workout to database
      await _workoutRepository.updateWorkout(completedWorkout);
      
      state = state!.copyWith(workout: completedWorkout);
      
      // Trigger workout list refresh
      _triggerWorkoutRefresh();
    }
  }

  void endSession() {
    state = null;
  }
}

// Provider for workout session
final workoutSessionProvider = StateNotifierProvider<WorkoutSessionNotifier, WorkoutSessionData?>(
  (ref) {
    final workoutRepository = ref.watch(workoutRepositoryProvider);
    return WorkoutSessionNotifier(workoutRepository, ref);
  },
);