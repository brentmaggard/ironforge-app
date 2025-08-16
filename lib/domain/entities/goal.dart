import 'package:equatable/equatable.dart';

class Goal extends Equatable {
  const Goal({
    required this.id,
    required this.userId,
    required this.type,
    required this.title,
    this.description,
    required this.targetValue,
    required this.currentValue,
    required this.unit,
    this.targetDate,
    required this.isCompleted,
    this.completedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String userId;
  final String type; // strength, weight, endurance, etc.
  final String title;
  final String? description;
  final double targetValue;
  final double currentValue;
  final String unit; // lbs, kg, reps, minutes
  final DateTime? targetDate;
  final bool isCompleted;
  final DateTime? completedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  @override
  List<Object?> get props => [
        id,
        userId,
        type,
        title,
        description,
        targetValue,
        currentValue,
        unit,
        targetDate,
        isCompleted,
        completedAt,
        createdAt,
        updatedAt,
      ];

  Goal copyWith({
    String? id,
    String? userId,
    String? type,
    String? title,
    String? description,
    double? targetValue,
    double? currentValue,
    String? unit,
    DateTime? targetDate,
    bool? isCompleted,
    DateTime? completedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Goal(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      type: type ?? this.type,
      title: title ?? this.title,
      description: description ?? this.description,
      targetValue: targetValue ?? this.targetValue,
      currentValue: currentValue ?? this.currentValue,
      unit: unit ?? this.unit,
      targetDate: targetDate ?? this.targetDate,
      isCompleted: isCompleted ?? this.isCompleted,
      completedAt: completedAt ?? this.completedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  double get progressPercentage {
    if (targetValue == 0) return 0.0;
    return (currentValue / targetValue).clamp(0.0, 1.0);
  }

  bool get isOverdue {
    if (targetDate == null || isCompleted) return false;
    return DateTime.now().isAfter(targetDate!);
  }
}