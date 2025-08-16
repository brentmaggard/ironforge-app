import '../entities/exercise_favorite.dart';

abstract class ExerciseFavoritesRepository {
  Future<List<ExerciseFavorite>> getFavoritesByUserId(String userId);
  Future<bool> isFavorite(String userId, String exerciseId);
  Future<void> addFavorite(String userId, String exerciseId);
  Future<void> removeFavorite(String userId, String exerciseId);
  Future<List<String>> getFavoriteExerciseIds(String userId);
}