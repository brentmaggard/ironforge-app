import 'package:drift/drift.dart';
import '../../domain/entities/program_session.dart' as domain;
import '../datasources/database.dart';

extension ProgramSessionModelExtension on domain.ProgramSession {
  ProgramSessionsCompanion toCompanion() {
    return ProgramSessionsCompanion(
      id: Value(id),
      userProgramId: Value(userProgramId),
      weekNumber: Value(weekNumber),
      dayNumber: Value(dayNumber),
      workoutId: Value(workoutId),
      scheduledDate: Value(scheduledDate),
      completedAt: Value(completedAt),
      status: Value(status),
      notes: Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      version: const Value(1),
      syncStatus: const Value('local'),
    );
  }
}

extension ProgramSessionTableExtension on ProgramSession {
  domain.ProgramSession toEntity() {
    return domain.ProgramSession(
      id: id,
      userProgramId: userProgramId,
      weekNumber: weekNumber,
      dayNumber: dayNumber,
      workoutId: workoutId,
      scheduledDate: scheduledDate,
      completedAt: completedAt,
      status: status,
      notes: notes,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}