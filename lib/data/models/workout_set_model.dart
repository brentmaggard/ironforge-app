import 'package:drift/drift.dart';
import '../../domain/entities/workout_set.dart' as domain;
import '../datasources/database.dart';

extension WorkoutSetModel on domain.WorkoutSet {
  /// Converts domain entity to database row
  WorkoutSetsCompanion toCompanion() {
    return WorkoutSetsCompanion.insert(
      id: id,
      workoutId: workoutId,
      exerciseId: exerciseId,
      setNumber: setNumber,
      reps: reps,
      weight: weight,
      rpe: Value(rpe),
      restSeconds: Value(restSeconds),
      notes: Value(notes),
      isCompleted: Value(isCompleted),
      completedAt: Value(completedAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }
}

extension WorkoutSetFromDb on WorkoutSet {
  /// Converts database row to domain entity
  domain.WorkoutSet toEntity() {
    return domain.WorkoutSet(
      id: id,
      workoutId: workoutId,
      exerciseId: exerciseId,
      setNumber: setNumber,
      reps: reps,
      weight: weight,
      rpe: rpe,
      restSeconds: restSeconds,
      notes: notes,
      isCompleted: isCompleted,
      completedAt: completedAt,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}