import 'package:equatable/equatable.dart';

class UserProgram extends Equatable {
  const UserProgram({
    required this.id,
    required this.userId,
    required this.programId,
    required this.startDate,
    required this.currentWeek,
    required this.currentDay,
    required this.status,
    this.customizations,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String userId;
  final String programId;
  final DateTime startDate;
  final int currentWeek;
  final int currentDay;
  final String status; // active, completed, paused
  final Map<String, dynamic>? customizations; // User modifications to program
  final DateTime createdAt;
  final DateTime updatedAt;

  @override
  List<Object?> get props => [
        id,
        userId,
        programId,
        startDate,
        currentWeek,
        currentDay,
        status,
        customizations,
        createdAt,
        updatedAt,
      ];

  UserProgram copyWith({
    String? id,
    String? userId,
    String? programId,
    DateTime? startDate,
    int? currentWeek,
    int? currentDay,
    String? status,
    Map<String, dynamic>? customizations,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserProgram(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      programId: programId ?? this.programId,
      startDate: startDate ?? this.startDate,
      currentWeek: currentWeek ?? this.currentWeek,
      currentDay: currentDay ?? this.currentDay,
      status: status ?? this.status,
      customizations: customizations ?? this.customizations,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  /// Check if program is currently active
  bool get isActive => status == 'active';

  /// Check if program is completed
  bool get isCompleted => status == 'completed';

  /// Check if program is paused
  bool get isPaused => status == 'paused';

  /// Calculate days since program start
  int get daysSinceStart => DateTime.now().difference(startDate).inDays;

  /// Calculate current program progress as percentage
  double progressPercentage(int totalWeeks) {
    if (totalWeeks <= 0) return 0.0;
    return (currentWeek / totalWeeks).clamp(0.0, 1.0);
  }
}