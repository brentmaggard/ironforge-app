import 'package:equatable/equatable.dart';

class Workout extends Equatable {
  const Workout({
    required this.id,
    required this.userId,
    this.programId,
    required this.name,
    this.notes,
    this.startedAt,
    this.completedAt,
    required this.totalSets,
    required this.totalReps,
    required this.totalVolume,
    this.durationMinutes,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String userId;
  final String? programId;
  final String name;
  final String? notes;
  final DateTime? startedAt;
  final DateTime? completedAt;
  final int totalSets;
  final int totalReps;
  final double totalVolume; // total weight * reps
  final int? durationMinutes;
  final String status; // planned, in_progress, completed
  final DateTime createdAt;
  final DateTime updatedAt;

  @override
  List<Object?> get props => [
        id,
        userId,
        programId,
        name,
        notes,
        startedAt,
        completedAt,
        totalSets,
        totalReps,
        totalVolume,
        durationMinutes,
        status,
        createdAt,
        updatedAt,
      ];

  Workout copyWith({
    String? id,
    String? userId,
    String? programId,
    String? name,
    String? notes,
    DateTime? startedAt,
    DateTime? completedAt,
    int? totalSets,
    int? totalReps,
    double? totalVolume,
    int? durationMinutes,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Workout(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      programId: programId ?? this.programId,
      name: name ?? this.name,
      notes: notes ?? this.notes,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
      totalSets: totalSets ?? this.totalSets,
      totalReps: totalReps ?? this.totalReps,
      totalVolume: totalVolume ?? this.totalVolume,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  bool get isCompleted => status == 'completed';
  bool get isInProgress => status == 'in_progress';
  bool get isPlanned => status == 'planned';

  Duration? get duration {
    if (startedAt != null && completedAt != null) {
      return completedAt!.difference(startedAt!);
    }
    if (startedAt != null && isInProgress) {
      return DateTime.now().difference(startedAt!);
    }
    if (durationMinutes != null) {
      return Duration(minutes: durationMinutes!);
    }
    return null;
  }

  String get statusDisplay {
    switch (status) {
      case 'in_progress':
        return 'In Progress';
      case 'completed':
        return 'Completed';
      case 'planned':
        return 'Planned';
      default:
        return status;
    }
  }
}