import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/exercise.dart';
import '../../../core/providers/database_providers.dart';

class ExerciseSelectionScreen extends ConsumerStatefulWidget {
  const ExerciseSelectionScreen({super.key});

  @override
  ConsumerState<ExerciseSelectionScreen> createState() => _ExerciseSelectionScreenState();
}

class _ExerciseSelectionScreenState extends ConsumerState<ExerciseSelectionScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String? _selectedCategory;
  String? _selectedEquipment;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Exercise'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(120),
          child: Column(
            children: [
              // Search bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search exercises...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              setState(() {
                                _searchQuery = '';
                              });
                            },
                          )
                        : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value.toLowerCase();
                    });
                  },
                ),
              ),

              // Filter chips
              SizedBox(
                height: 50,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    _buildFilterChip(
                      label: 'All Categories',
                      isSelected: _selectedCategory == null,
                      onSelected: () => setState(() => _selectedCategory = null),
                    ),
                    _buildFilterChip(
                      label: 'Push',
                      isSelected: _selectedCategory == 'Push',
                      onSelected: () => setState(() => _selectedCategory = 'Push'),
                    ),
                    _buildFilterChip(
                      label: 'Pull',
                      isSelected: _selectedCategory == 'Pull',
                      onSelected: () => setState(() => _selectedCategory = 'Pull'),
                    ),
                    _buildFilterChip(
                      label: 'Legs',
                      isSelected: _selectedCategory == 'Legs',
                      onSelected: () => setState(() => _selectedCategory = 'Legs'),
                    ),
                    _buildFilterChip(
                      label: 'Core',
                      isSelected: _selectedCategory == 'Core',
                      onSelected: () => setState(() => _selectedCategory = 'Core'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final exercisesAsync = ref.watch(allExercisesProvider);
          
          return exercisesAsync.when(
            data: (exercises) {
              final filteredExercises = _filterExercises(exercises);

              if (filteredExercises.isEmpty) {
                return _buildEmptyState();
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: filteredExercises.length,
                itemBuilder: (context, index) {
                  final exercise = filteredExercises[index];
                  return _buildExerciseCard(exercise);
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text('Error loading exercises: $error'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      ref.invalidate(allExercisesProvider);
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFilterChip({
    required String label,
    required bool isSelected,
    required VoidCallback onSelected,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (_) => onSelected(),
        selectedColor: Theme.of(context).colorScheme.primaryContainer,
        checkmarkColor: Theme.of(context).colorScheme.onPrimaryContainer,
      ),
    );
  }

  List<Exercise> _filterExercises(List<Exercise> exercises) {
    return exercises.where((exercise) {
      // Search filter
      if (_searchQuery.isNotEmpty) {
        final nameMatch = exercise.name.toLowerCase().contains(_searchQuery);
        final categoryMatch = exercise.category.toLowerCase().contains(_searchQuery);
        final muscleMatch = exercise.primaryMuscleGroup.toLowerCase().contains(_searchQuery);
        final equipmentMatch = exercise.equipment.toLowerCase().contains(_searchQuery);
        
        if (!nameMatch && !categoryMatch && !muscleMatch && !equipmentMatch) {
          return false;
        }
      }

      // Category filter
      if (_selectedCategory != null) {
        final categoryLower = _selectedCategory!.toLowerCase();
        bool hasCategory = false;
        
        switch (categoryLower) {
          case 'push':
            hasCategory = exercise.exerciseTypes?.any((type) => 
              type.toLowerCase() == 'push') ?? false;
            break;
          case 'pull':
            hasCategory = exercise.exerciseTypes?.any((type) => 
              type.toLowerCase() == 'pull') ?? false;
            break;
          case 'legs':
            hasCategory = (exercise.bodyParts?.any((part) => 
              part.toLowerCase() == 'lower_body') ?? false) ||
              (exercise.exerciseTypes?.any((type) => 
              type.toLowerCase() == 'lower') ?? false);
            break;
          case 'core':
            hasCategory = (exercise.primaryMuscles?.any((muscle) => 
              muscle.toLowerCase().contains('core')) ?? false) ||
              (exercise.secondaryMuscles?.any((muscle) => 
              muscle.toLowerCase().contains('core')) ?? false);
            break;
          default:
            hasCategory = false;
        }
        
        if (!hasCategory) return false;
      }

      // Equipment filter
      if (_selectedEquipment != null && exercise.equipment != _selectedEquipment) {
        return false;
      }

      return true;
    }).toList();
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 80,
              color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.6),
            ),
            const SizedBox(height: 24),
            Text(
              'No Exercises Found',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Try adjusting your search or filters',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            OutlinedButton(
              onPressed: () {
                setState(() {
                  _searchController.clear();
                  _searchQuery = '';
                  _selectedCategory = null;
                  _selectedEquipment = null;
                });
              },
              child: const Text('Clear Filters'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExerciseCard(Exercise exercise) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Theme.of(context).colorScheme.primaryContainer,
                Theme.of(context).colorScheme.secondaryContainer,
              ],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            Icons.fitness_center,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
            size: 24,
          ),
        ),
        title: Text(
          exercise.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text('${exercise.primaryMuscleGroup} • ${exercise.equipment}'),
            const SizedBox(height: 4),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: _getDifficultyColor(exercise.difficultyLevel).withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Level ${exercise.difficultyLevel}',
                    style: TextStyle(
                      fontSize: 12,
                      color: _getDifficultyColor(exercise.difficultyLevel),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                if (exercise.isCompound)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.purple.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'Compound',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.purple,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
        onTap: () {
          Navigator.of(context).pop(exercise);
        },
        trailing: const Icon(Icons.add_circle_outline),
      ),
    );
  }

  Color _getDifficultyColor(int difficulty) {
    switch (difficulty) {
      case 1:
        return Colors.green;
      case 2:
        return Colors.lightGreen;
      case 3:
        return Colors.orange;
      case 4:
        return Colors.deepOrange;
      case 5:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}