import 'package:drift/drift.dart';
import '../../domain/entities/goal.dart' as domain;
import '../datasources/database.dart';

extension GoalModel on domain.Goal {
  /// Converts domain entity to database row
  GoalsCompanion toCompanion() {
    return GoalsCompanion.insert(
      id: id,
      userId: userId,
      name: title,
      goalType: type,
      description: Value(description),
      targetValue: targetValue,
      currentValue: Value(currentValue),
      unit: unit,
      targetDate: Value(targetDate),
      isCompleted: Value(isCompleted),
      completedAt: Value(completedAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }
}

extension GoalFromDb on Goal {
  /// Converts database row to domain entity
  domain.Goal toEntity() {
    return domain.Goal(
      id: id,
      userId: userId,
      type: goalType,
      title: name,
      description: description,
      targetValue: targetValue,
      currentValue: currentValue,
      unit: unit,
      targetDate: targetDate,
      isCompleted: isCompleted,
      completedAt: completedAt,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}