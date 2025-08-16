import '../../domain/entities/exercise_favorite.dart' as domain;
import '../datasources/database.dart';
import 'package:drift/drift.dart';

extension ExerciseFavoriteModelExtensions on domain.ExerciseFavorite {
  ExerciseFavoritesCompanion toCompanion() {
    return ExerciseFavoritesCompanion.insert(
      id: id,
      userId: userId,
      exerciseId: exerciseId,
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }
}

extension ExerciseFavoriteDbExtensions on ExerciseFavorite {
  domain.ExerciseFavorite toEntity() {
    return domain.ExerciseFavorite(
      id: id,
      userId: userId,
      exerciseId: exerciseId,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}