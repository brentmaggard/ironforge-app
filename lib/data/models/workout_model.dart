import 'package:drift/drift.dart';
import '../../domain/entities/workout.dart' as domain;
import '../datasources/database.dart';

extension WorkoutModel on domain.Workout {
  /// Converts domain entity to database row
  WorkoutsCompanion toCompanion() {
    return WorkoutsCompanion.insert(
      id: id,
      userId: userId,
      programId: Value(programId),
      name: name,
      notes: Value(notes),
      startedAt: Value(startedAt),
      completedAt: Value(completedAt),
      totalSets: Value(totalSets),
      totalReps: Value(totalReps),
      totalVolume: Value(totalVolume),
      durationMinutes: Value(durationMinutes),
      status: Value(status),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }
}

extension WorkoutFromDb on Workout {
  /// Converts database row to domain entity
  domain.Workout toEntity() {
    return domain.Workout(
      id: id,
      userId: userId,
      programId: programId,
      name: name,
      notes: notes,
      startedAt: startedAt,
      completedAt: completedAt,
      totalSets: totalSets,
      totalReps: totalReps,
      totalVolume: totalVolume,
      durationMinutes: durationMinutes,
      status: status,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}