import 'package:equatable/equatable.dart';

class WorkoutSet extends Equatable {
  const WorkoutSet({
    required this.id,
    required this.workoutId,
    required this.exerciseId,
    required this.setNumber,
    required this.reps,
    required this.weight,
    this.rpe,
    this.restSeconds,
    this.notes,
    this.isWarmUp = false,
    required this.isCompleted,
    this.completedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String workoutId;
  final String exerciseId;
  final int setNumber;
  final int reps;
  final double weight;
  final double? rpe; // Rate of Perceived Exertion (1-10)
  final int? restSeconds;
  final String? notes;
  final bool isWarmUp;
  final bool isCompleted;
  final DateTime? completedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  @override
  List<Object?> get props => [
        id,
        workoutId,
        exerciseId,
        setNumber,
        reps,
        weight,
        rpe,
        restSeconds,
        notes,
        isWarmUp,
        isCompleted,
        completedAt,
        createdAt,
        updatedAt,
      ];

  WorkoutSet copyWith({
    String? id,
    String? workoutId,
    String? exerciseId,
    int? setNumber,
    int? reps,
    double? weight,
    double? rpe,
    int? restSeconds,
    String? notes,
    bool? isWarmUp,
    bool? isCompleted,
    DateTime? completedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return WorkoutSet(
      id: id ?? this.id,
      workoutId: workoutId ?? this.workoutId,
      exerciseId: exerciseId ?? this.exerciseId,
      setNumber: setNumber ?? this.setNumber,
      reps: reps ?? this.reps,
      weight: weight ?? this.weight,
      rpe: rpe ?? this.rpe,
      restSeconds: restSeconds ?? this.restSeconds,
      notes: notes ?? this.notes,
      isWarmUp: isWarmUp ?? this.isWarmUp,
      isCompleted: isCompleted ?? this.isCompleted,
      completedAt: completedAt ?? this.completedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  double get volume => weight * reps;

  Duration? get restDuration {
    if (restSeconds == null) return null;
    return Duration(seconds: restSeconds!);
  }
}