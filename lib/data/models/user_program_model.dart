import 'dart:convert';
import 'package:drift/drift.dart';
import '../../domain/entities/user_program.dart' as domain;
import '../datasources/database.dart';

extension UserProgramModelExtension on domain.UserProgram {
  UserProgramsCompanion toCompanion() {
    return UserProgramsCompanion(
      id: Value(id),
      userId: Value(userId),
      programId: Value(programId),
      startDate: Value(startDate),
      currentWeek: Value(currentWeek),
      currentDay: Value(currentDay),
      status: Value(status),
      customizations: Value(customizations != null ? jsonEncode(customizations) : null),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      version: const Value(1),
      syncStatus: const Value('local'),
    );
  }
}

extension UserProgramTableExtension on UserProgram {
  domain.UserProgram toEntity() {
    return domain.UserProgram(
      id: id,
      userId: userId,
      programId: programId,
      startDate: startDate,
      currentWeek: currentWeek,
      currentDay: currentDay,
      status: status,
      customizations: customizations != null 
          ? Map<String, dynamic>.from(jsonDecode(customizations!))
          : null,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}