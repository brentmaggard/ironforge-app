import 'dart:convert';
import 'package:drift/drift.dart';
import '../../domain/entities/program.dart' as domain;
import '../datasources/database.dart';

extension ProgramModelExtension on domain.Program {
  ProgramsCompanion toCompanion() {
    return ProgramsCompanion(
      id: Value(id),
      name: Value(name),
      description: Value(description),
      author: Value(author),
      difficulty: Value(difficulty),
      frequency: Value(frequency),
      durationWeeks: Value(durationWeeks),
      tags: Value(tags != null ? jsonEncode(tags) : null),
      config: Value(jsonEncode(config)),
      isTemplate: Value(isTemplate),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      version: const Value(1),
      syncStatus: const Value('local'),
    );
  }
}

extension ProgramTableExtension on Program {
  domain.Program toEntity() {
    return domain.Program(
      id: id,
      name: name,
      description: description,
      author: author,
      difficulty: difficulty,
      frequency: frequency,
      durationWeeks: durationWeeks,
      tags: tags != null ? List<String>.from(jsonDecode(tags!)) : null,
      config: Map<String, dynamic>.from(jsonDecode(config)),
      isTemplate: isTemplate,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}