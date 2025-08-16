import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart';
import '../../domain/entities/exercise_favorite.dart' as domain;
import '../../domain/repositories/exercise_favorites_repository.dart';
import '../datasources/database.dart';
import '../models/exercise_favorite_model.dart';

class ExerciseFavoritesRepositoryImpl implements ExerciseFavoritesRepository {
  final AppDatabase _database;
  static const _uuid = Uuid();

  ExerciseFavoritesRepositoryImpl(this._database);

  @override
  Future<List<domain.ExerciseFavorite>> getFavoritesByUserId(String userId) async {
    final favorites = await (_database.select(_database.exerciseFavorites)
        ..where((tbl) => tbl.userId.equals(userId)))
        .get();
    
    return favorites.map((favorite) => favorite.toEntity()).toList();
  }

  @override
  Future<bool> isFavorite(String userId, String exerciseId) async {
    final result = await (_database.select(_database.exerciseFavorites)
        ..where((tbl) => tbl.userId.equals(userId) & tbl.exerciseId.equals(exerciseId)))
        .getSingleOrNull();
    
    return result != null;
  }

  @override
  Future<void> addFavorite(String userId, String exerciseId) async {
    // Check if already exists
    final exists = await isFavorite(userId, exerciseId);
    if (exists) return;

    final favorite = domain.ExerciseFavorite(
      id: _uuid.v4(),
      userId: userId,
      exerciseId: exerciseId,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await _database.into(_database.exerciseFavorites).insert(favorite.toCompanion());
  }

  @override
  Future<void> removeFavorite(String userId, String exerciseId) async {
    await (_database.delete(_database.exerciseFavorites)
        ..where((tbl) => tbl.userId.equals(userId) & tbl.exerciseId.equals(exerciseId)))
        .go();
  }

  @override
  Future<List<String>> getFavoriteExerciseIds(String userId) async {
    final favorites = await (_database.select(_database.exerciseFavorites)
        ..where((tbl) => tbl.userId.equals(userId)))
        .get();
    
    return favorites.map((favorite) => favorite.exerciseId).toList();
  }
}