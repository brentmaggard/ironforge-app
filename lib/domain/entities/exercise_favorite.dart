import 'package:equatable/equatable.dart';

class ExerciseFavorite extends Equatable {
  const ExerciseFavorite({
    required this.id,
    required this.userId,
    required this.exerciseId,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String userId;
  final String exerciseId;
  final DateTime createdAt;
  final DateTime updatedAt;

  @override
  List<Object?> get props => [
        id,
        userId,
        exerciseId,
        createdAt,
        updatedAt,
      ];

  ExerciseFavorite copyWith({
    String? id,
    String? userId,
    String? exerciseId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ExerciseFavorite(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      exerciseId: exerciseId ?? this.exerciseId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}