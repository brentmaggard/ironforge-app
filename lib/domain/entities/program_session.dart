import 'package:equatable/equatable.dart';

class ProgramSession extends Equatable {
  const ProgramSession({
    required this.id,
    required this.userProgramId,
    required this.weekNumber,
    required this.dayNumber,
    this.workoutId,
    this.scheduledDate,
    this.completedAt,
    required this.status,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String userProgramId;
  final int weekNumber;
  final int dayNumber;
  final String? workoutId; // References workouts table when completed
  final DateTime? scheduledDate;
  final DateTime? completedAt;
  final String status; // scheduled, completed, skipped
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  @override
  List<Object?> get props => [
        id,
        userProgramId,
        weekNumber,
        dayNumber,
        workoutId,
        scheduledDate,
        completedAt,
        status,
        notes,
        createdAt,
        updatedAt,
      ];

  ProgramSession copyWith({
    String? id,
    String? userProgramId,
    int? weekNumber,
    int? dayNumber,
    String? workoutId,
    DateTime? scheduledDate,
    DateTime? completedAt,
    String? status,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ProgramSession(
      id: id ?? this.id,
      userProgramId: userProgramId ?? this.userProgramId,
      weekNumber: weekNumber ?? this.weekNumber,
      dayNumber: dayNumber ?? this.dayNumber,
      workoutId: workoutId ?? this.workoutId,
      scheduledDate: scheduledDate ?? this.scheduledDate,
      completedAt: completedAt ?? this.completedAt,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  /// Check if session is scheduled
  bool get isScheduled => status == 'scheduled';

  /// Check if session is completed
  bool get isCompleted => status == 'completed';

  /// Check if session was skipped
  bool get isSkipped => status == 'skipped';

  /// Check if session is overdue (scheduled but not completed and past scheduled date)
  bool get isOverdue {
    if (!isScheduled || scheduledDate == null) return false;
    return DateTime.now().isAfter(scheduledDate!);
  }

  /// Get session display name (e.g., "Week 1, Day 2")
  String get displayName => 'Week $weekNumber, Day $dayNumber';

  /// Get time since completion (if completed)
  Duration? get timeSinceCompletion {
    if (completedAt == null) return null;
    return DateTime.now().difference(completedAt!);
  }
}