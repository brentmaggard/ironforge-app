import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../../domain/entities/workout_session.dart';

const _uuid = Uuid();

final demoWorkoutSessionProvider = Provider<WorkoutSession>((ref) {
  return WorkoutSession(
    id: _uuid.v4(),
    title: 'Push Day - Upper Body',
    startedAt: DateTime.now().subtract(const Duration(minutes: 15)),
    elapsedMs: 15 * 60 * 1000, // 15 minutes
    isPaused: false,
    unit: Unit.lb,
    exercises: [
      ExerciseBlock(
        id: _uuid.v4(),
        name: 'Barbell Bench Press',
        exerciseId: 'bench_press',
        warmups: [
          SetEntry(
            id: _uuid.v4(),
            kind: SetKind.warmup,
            order: 1,
            weight: 95.0,
            reps: 8,
          ),
          SetEntry(
            id: _uuid.v4(),
            kind: SetKind.warmup,
            order: 2,
            weight: 115.0,
            reps: 5,
          ),
        ],
        sets: [
          SetEntry(
            id: _uuid.v4(),
            kind: SetKind.working,
            order: 1,
            weight: 185.0,
            reps: 8,
            completedAt: DateTime.now().subtract(const Duration(minutes: 10)),
          ),
          SetEntry(
            id: _uuid.v4(),
            kind: SetKind.working,
            order: 2,
            weight: 185.0,
            reps: 7,
            completedAt: DateTime.now().subtract(const Duration(minutes: 7)),
          ),
          SetEntry(
            id: _uuid.v4(),
            kind: SetKind.working,
            order: 3,
            weight: 185.0,
            reps: null, // Incomplete set
          ),
          SetEntry(
            id: _uuid.v4(),
            kind: SetKind.working,
            order: 4,
            weight: null, // Incomplete set
            reps: null,
          ),
        ],
        isWarmupCollapsed: false,
      ),
      ExerciseBlock(
        id: _uuid.v4(),
        name: 'Incline Dumbbell Press',
        exerciseId: 'incline_dumbbell_press',
        warmups: [],
        sets: [
          SetEntry(
            id: _uuid.v4(),
            kind: SetKind.working,
            order: 1,
            weight: 65.0,
            reps: 10,
            completedAt: DateTime.now().subtract(const Duration(minutes: 5)),
          ),
          SetEntry(
            id: _uuid.v4(),
            kind: SetKind.working,
            order: 2,
            weight: 65.0,
            reps: 9,
            completedAt: DateTime.now().subtract(const Duration(minutes: 3)),
          ),
          SetEntry(
            id: _uuid.v4(),
            kind: SetKind.working,
            order: 3,
            weight: null, // Incomplete set
            reps: null,
          ),
        ],
        isWarmupCollapsed: true,
      ),
      ExerciseBlock(
        id: _uuid.v4(),
        name: 'Dumbbell Shoulder Press',
        exerciseId: 'dumbbell_shoulder_press',
        warmups: [
          SetEntry(
            id: _uuid.v4(),
            kind: SetKind.warmup,
            order: 1,
            weight: 15.0,
            reps: 10,
          ),
        ],
        sets: [
          SetEntry(
            id: _uuid.v4(),
            kind: SetKind.working,
            order: 1,
            weight: null, // Fresh exercise, no sets completed
            reps: null,
          ),
          SetEntry(
            id: _uuid.v4(),
            kind: SetKind.working,
            order: 2,
            weight: null,
            reps: null,
          ),
          SetEntry(
            id: _uuid.v4(),
            kind: SetKind.working,
            order: 3,
            weight: null,
            reps: null,
          ),
        ],
        isWarmupCollapsed: false,
      ),
    ],
    programId: null,
    userProgramId: null,
    notes: 'Great pump today! Feeling strong.',
  );
});

final demoWorkoutSessionWithAllWarmupsCollapsedProvider = Provider<WorkoutSession>((ref) {
  final baseSession = ref.watch(demoWorkoutSessionProvider);
  
  final updatedExercises = baseSession.exercises.map((exercise) {
    return exercise.copyWith(isWarmupCollapsed: true);
  }).toList();
  
  return baseSession.copyWith(
    title: 'Push Day - All Warmups Collapsed',
    exercises: updatedExercises,
  );
});

final demoWorkoutSessionPausedProvider = Provider<WorkoutSession>((ref) {
  final baseSession = ref.watch(demoWorkoutSessionProvider);
  
  return baseSession.copyWith(
    title: 'Paused Workout Session',
    isPaused: true,
    elapsedMs: 45 * 60 * 1000, // 45 minutes
  );
});

final demoWorkoutSessionKgProvider = Provider<WorkoutSession>((ref) {
  final baseSession = ref.watch(demoWorkoutSessionProvider);
  
  // Convert all weights to kg
  final convertedExercises = baseSession.exercises.map((exercise) {
    final convertedWarmups = exercise.warmups.map((set) {
      if (set.weight != null) {
        final kgWeight = UnitConverter.convertWeight(set.weight!, Unit.lb, Unit.kg);
        return set.copyWith(weight: kgWeight);
      }
      return set;
    }).toList();

    final convertedSets = exercise.sets.map((set) {
      if (set.weight != null) {
        final kgWeight = UnitConverter.convertWeight(set.weight!, Unit.lb, Unit.kg);
        return set.copyWith(weight: kgWeight);
      }
      return set;
    }).toList();

    return exercise.copyWith(
      warmups: convertedWarmups,
      sets: convertedSets,
    );
  }).toList();
  
  return baseSession.copyWith(
    title: 'Push Day - Kilograms',
    unit: Unit.kg,
    exercises: convertedExercises,
  );
});