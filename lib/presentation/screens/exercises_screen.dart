import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/providers/database_providers.dart';
import '../../domain/entities/exercise.dart';
import '../providers/exercise_favorites_provider.dart';

class ExercisesScreen extends ConsumerStatefulWidget {
  const ExercisesScreen({super.key});

  @override
  ConsumerState<ExercisesScreen> createState() => _ExercisesScreenState();
}

class _ExercisesScreenState extends ConsumerState<ExercisesScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String? _selectedMuscleGroup;
  String? _selectedEquipment;
  String? _selectedDifficulty;
  String _sortBy = 'name'; // name, difficulty, muscle_group
  bool _showFavoritesOnly = false;

  List<String> get _muscleGroups => [
    'chest', 'back', 'shoulders', 'arms', 'legs', 'core', 'cardio', 'full-body'
  ];

  List<String> get _equipmentTypes => [
    'barbell', 'dumbbell', 'machine', 'bodyweight', 'cable', 'kettlebell', 'resistance_band'
  ];

  List<String> get _difficultyLevels => [
    'beginner', 'intermediate', 'advanced'
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Exercise> _filterAndSortExercises(List<Exercise> exercises, Set<String> favoriteIds) {
    var filtered = exercises.where((exercise) {
      // Favorites filter
      if (_showFavoritesOnly && !favoriteIds.contains(exercise.id)) {
        return false;
      }

      // Search filter
      if (_searchQuery.isNotEmpty) {
        final query = _searchQuery.toLowerCase();
        if (!exercise.name.toLowerCase().contains(query) &&
            !exercise.category.toLowerCase().contains(query) &&
            !exercise.primaryMuscleGroup.toLowerCase().contains(query)) {
          return false;
        }
      }

      // Muscle group filter
      if (_selectedMuscleGroup != null) {
        if (exercise.primaryMuscleGroup != _selectedMuscleGroup &&
            !exercise.secondaryMuscleGroups.contains(_selectedMuscleGroup)) {
          return false;
        }
      }

      // Equipment filter
      if (_selectedEquipment != null && exercise.equipment != _selectedEquipment) {
        return false;
      }

      // Difficulty filter
      if (_selectedDifficulty != null && exercise.difficulty != _selectedDifficulty) {
        return false;
      }

      return true;
    }).toList();

    // Sort exercises
    filtered.sort((a, b) {
      switch (_sortBy) {
        case 'name':
          return a.name.compareTo(b.name);
        case 'difficulty':
          final difficultyOrder = {'beginner': 0, 'intermediate': 1, 'advanced': 2};
          return (difficultyOrder[a.difficulty] ?? 1).compareTo(difficultyOrder[b.difficulty] ?? 1);
        case 'muscle_group':
          return a.primaryMuscleGroup.compareTo(b.primaryMuscleGroup);
        default:
          return a.name.compareTo(b.name);
      }
    });

    return filtered;
  }

  void _clearFilters() {
    setState(() {
      _searchController.clear();
      _searchQuery = '';
      _selectedMuscleGroup = null;
      _selectedEquipment = null;
      _selectedDifficulty = null;
      _sortBy = 'name';
      _showFavoritesOnly = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final exerciseRepository = ref.watch(exerciseRepositoryProvider);
    final dbInitialization = ref.watch(databaseInitializationProvider);
    final favorites = ref.watch(exerciseFavoritesNotifierProvider);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Exercises'),
          actions: [
            IconButton(
              icon: const Icon(Icons.clear_all),
              onPressed: _clearFilters,
              tooltip: 'Clear filters',
            ),
          ],
        ),
        body: Column(
          children: [
            // Search and filters section
            Container(
              padding: const EdgeInsets.all(16.0),
              color: Theme.of(context).colorScheme.surface,
              child: Column(
                children: [
                  // Search bar
                  TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: 'Search exercises...',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Filter chips
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        // Muscle group filter
                        PopupMenuButton<String>(
                          initialValue: _selectedMuscleGroup,
                          onSelected: (value) {
                            setState(() {
                              _selectedMuscleGroup = value;
                            });
                          },
                          child: Chip(
                            label: Text(_selectedMuscleGroup ?? 'Muscle Group'),
                            deleteIcon: _selectedMuscleGroup != null ? const Icon(Icons.close, size: 18) : null,
                            onDeleted: _selectedMuscleGroup != null ? () {
                              setState(() {
                                _selectedMuscleGroup = null;
                              });
                            } : null,
                          ),
                          itemBuilder: (context) => [
                            const PopupMenuItem<String>(
                              value: null,
                              child: Text('All Muscle Groups'),
                            ),
                            ..._muscleGroups.map((group) => PopupMenuItem<String>(
                              value: group,
                              child: Text(group[0].toUpperCase() + group.substring(1)),
                            )),
                          ],
                        ),
                        
                        const SizedBox(width: 8),
                        
                        // Equipment filter
                        PopupMenuButton<String>(
                          initialValue: _selectedEquipment,
                          onSelected: (value) {
                            setState(() {
                              _selectedEquipment = value;
                            });
                          },
                          child: Chip(
                            label: Text(_selectedEquipment ?? 'Equipment'),
                            deleteIcon: _selectedEquipment != null ? const Icon(Icons.close, size: 18) : null,
                            onDeleted: _selectedEquipment != null ? () {
                              setState(() {
                                _selectedEquipment = null;
                              });
                            } : null,
                          ),
                          itemBuilder: (context) => [
                            const PopupMenuItem<String>(
                              value: null,
                              child: Text('All Equipment'),
                            ),
                            ..._equipmentTypes.map((equipment) => PopupMenuItem<String>(
                              value: equipment,
                              child: Text(equipment.replaceAll('_', ' ').split(' ').map((word) => 
                                word[0].toUpperCase() + word.substring(1)).join(' ')),
                            )),
                          ],
                        ),
                        
                        const SizedBox(width: 8),
                        
                        // Difficulty filter
                        PopupMenuButton<String>(
                          initialValue: _selectedDifficulty,
                          onSelected: (value) {
                            setState(() {
                              _selectedDifficulty = value;
                            });
                          },
                          child: Chip(
                            label: Text(_selectedDifficulty ?? 'Difficulty'),
                            deleteIcon: _selectedDifficulty != null ? const Icon(Icons.close, size: 18) : null,
                            onDeleted: _selectedDifficulty != null ? () {
                              setState(() {
                                _selectedDifficulty = null;
                              });
                            } : null,
                          ),
                          itemBuilder: (context) => [
                            const PopupMenuItem<String>(
                              value: null,
                              child: Text('All Difficulties'),
                            ),
                            ..._difficultyLevels.map((difficulty) => PopupMenuItem<String>(
                              value: difficulty,
                              child: Text(difficulty[0].toUpperCase() + difficulty.substring(1)),
                            )),
                          ],
                        ),
                        
                        const SizedBox(width: 8),
                        
                        // Favorites toggle
                        FilterChip(
                          label: const Text('Favorites'),
                          avatar: Icon(
                            _showFavoritesOnly ? Icons.favorite : Icons.favorite_border,
                            size: 18,
                            color: _showFavoritesOnly ? Colors.red : null,
                          ),
                          selected: _showFavoritesOnly,
                          onSelected: (bool selected) {
                            setState(() {
                              _showFavoritesOnly = selected;
                            });
                          },
                        ),
                        
                        const SizedBox(width: 8),
                        
                        // Sort dropdown
                        PopupMenuButton<String>(
                          initialValue: _sortBy,
                          onSelected: (value) {
                            if (value != null) {
                              setState(() {
                                _sortBy = value;
                              });
                            }
                          },
                          child: Chip(
                            label: Text('Sort: ${_sortBy.replaceAll('_', ' ')}'),
                            avatar: const Icon(Icons.sort, size: 18),
                          ),
                          itemBuilder: (context) => const [
                            PopupMenuItem<String>(
                              value: 'name',
                              child: Text('Name'),
                            ),
                            PopupMenuItem<String>(
                              value: 'difficulty',
                              child: Text('Difficulty'),
                            ),
                            PopupMenuItem<String>(
                              value: 'muscle_group',
                              child: Text('Muscle Group'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            // Exercise list
            Expanded(
              child: dbInitialization.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stackTrace) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error, size: 64, color: Colors.red),
                      const SizedBox(height: 16),
                      Text('Error initializing database: $error'),
                      const SizedBox(height: 16),
                      FilledButton(
                        onPressed: () => ref.invalidate(databaseInitializationProvider),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
                data: (_) => FutureBuilder<List<Exercise>>(
                  future: exerciseRepository.getAllExercises(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    
                    if (snapshot.hasError) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.error, size: 64, color: Colors.red),
                            const SizedBox(height: 16),
                            Text('Error loading exercises: ${snapshot.error}'),
                            const SizedBox(height: 16),
                            FilledButton(
                              onPressed: () => setState(() {}),
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      );
                    }
                    
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.fitness_center, size: 64, color: Colors.grey),
                            SizedBox(height: 16),
                            Text('No exercises found'),
                            Text('The exercise database is empty'),
                          ],
                        ),
                      );
                    }
                    
                    final favoriteIds = favorites.value?.toSet() ?? <String>{};
                    final filteredExercises = _filterAndSortExercises(snapshot.data!, favoriteIds);
                    
                    if (filteredExercises.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.search_off, size: 64, color: Colors.grey),
                            const SizedBox(height: 16),
                            const Text('No exercises match your filters'),
                          const SizedBox(height: 8),
                          FilledButton(
                            onPressed: _clearFilters,
                            child: const Text('Clear Filters'),
                          ),
                        ],
                      ),
                    );
                  }
                  
                  return ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: filteredExercises.length,
                    itemBuilder: (context, index) {
                      final exercise = filteredExercises[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12.0),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                            child: Icon(
                              _getExerciseIcon(exercise.category),
                              color: Theme.of(context).colorScheme.onPrimaryContainer,
                            ),
                          ),
                          title: Text(
                            exercise.name,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${exercise.primaryMuscleGroup} • ${exercise.equipment}'),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: _getDifficultyColor(exercise.difficulty).withValues(alpha: 0.2),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      exercise.difficulty,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: _getDifficultyColor(exercise.difficulty),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).colorScheme.secondaryContainer,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      exercise.category,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Theme.of(context).colorScheme.onSecondaryContainer,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (favoriteIds.contains(exercise.id))
                                Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                  size: 18,
                                ),
                              const SizedBox(width: 8),
                              const Icon(Icons.chevron_right),
                            ],
                          ),
                          onTap: () {
                            context.pushNamed(
                              'exercise-detail',
                              pathParameters: {'exerciseId': exercise.id},
                              extra: exercise,
                            );
                          },
                        ),
                      );
                    },
                  );
                  },
                ),
              ),
            ),
          ],
        ),
      );
  }

  IconData _getExerciseIcon(String category) {
    switch (category.toLowerCase()) {
      case 'compound':
        return Icons.fitness_center;
      case 'isolation':
        return Icons.adjust;
      case 'cardio':
        return Icons.directions_run;
      default:
        return Icons.sports_gymnastics;
    }
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'beginner':
        return Colors.green;
      case 'intermediate':
        return Colors.orange;
      case 'advanced':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}