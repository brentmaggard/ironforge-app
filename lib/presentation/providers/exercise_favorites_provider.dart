import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers/database_providers.dart';
import '../../domain/repositories/exercise_favorites_repository.dart';

// Demo user ID for development
const String demoUserId = 'demo-user';

/// Provider for checking if an exercise is favorited
final exerciseIsFavoriteProvider = FutureProvider.family<bool, String>((ref, exerciseId) async {
  final favoritesRepository = ref.watch(exerciseFavoritesRepositoryProvider);
  return await favoritesRepository.isFavorite(demoUserId, exerciseId);
});

/// Provider for getting all favorite exercise IDs
final favoriteExerciseIdsProvider = FutureProvider<List<String>>((ref) async {
  final favoritesRepository = ref.watch(exerciseFavoritesRepositoryProvider);
  return await favoritesRepository.getFavoriteExerciseIds(demoUserId);
});

/// State notifier for managing exercise favorites
class ExerciseFavoritesNotifier extends StateNotifier<AsyncValue<List<String>>> {
  final ExerciseFavoritesRepository _repository;
  
  ExerciseFavoritesNotifier(this._repository) : super(const AsyncValue.loading()) {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    try {
      final favorites = await _repository.getFavoriteExerciseIds(demoUserId);
      state = AsyncValue.data(favorites);
    } catch (error) {
      state = AsyncValue.error(error, StackTrace.current);
    }
  }

  Future<void> toggleFavorite(String exerciseId) async {
    final currentFavorites = state.value ?? [];
    final isFavorite = currentFavorites.contains(exerciseId);
    
    try {
      if (isFavorite) {
        await _repository.removeFavorite(demoUserId, exerciseId);
        state = AsyncValue.data(currentFavorites.where((id) => id != exerciseId).toList());
      } else {
        await _repository.addFavorite(demoUserId, exerciseId);
        state = AsyncValue.data([...currentFavorites, exerciseId]);
      }
    } catch (error) {
      state = AsyncValue.error(error, StackTrace.current);
    }
  }

  bool isFavorite(String exerciseId) {
    return state.value?.contains(exerciseId) ?? false;
  }
}

/// Provider for the exercise favorites notifier
final exerciseFavoritesNotifierProvider = StateNotifierProvider<ExerciseFavoritesNotifier, AsyncValue<List<String>>>((ref) {
  final repository = ref.watch(exerciseFavoritesRepositoryProvider);
  return ExerciseFavoritesNotifier(repository);
});