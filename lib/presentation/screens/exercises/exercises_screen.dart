import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/database_providers.dart';
import '../../../domain/entities/exercise.dart';
import '../../widgets/common/main_navigation.dart';
import 'widgets/exercise_search_bar.dart';
import 'widgets/exercise_filters.dart';
import 'widgets/exercise_list_item.dart';

class ExercisesScreen extends ConsumerStatefulWidget {
  const ExercisesScreen({super.key});

  @override
  ConsumerState<ExercisesScreen> createState() => _ExercisesScreenState();
}

class _ExercisesScreenState extends ConsumerState<ExercisesScreen> {
  String _searchQuery = '';
  String _selectedCategory = 'All';
  String _selectedMuscleGroup = 'All';
  String _selectedEquipment = 'All';
  String _selectedDifficulty = 'All';

  @override
  Widget build(BuildContext context) {
    return MainNavigation(
      currentIndex: 4,
      child: Scaffold(
        appBar: const MainAppBar(title: 'Exercises'),
        body: Column(
          children: [
            ExerciseSearchBar(
              onSearchChanged: (query) {
                setState(() {
                  _searchQuery = query;
                });
              },
            ),
            ExerciseFilters(
              selectedCategory: _selectedCategory,
              selectedMuscleGroup: _selectedMuscleGroup,
              selectedEquipment: _selectedEquipment,
              selectedDifficulty: _selectedDifficulty,
              onCategoryChanged: (category) {
                setState(() {
                  _selectedCategory = category;
                });
              },
              onMuscleGroupChanged: (muscleGroup) {
                setState(() {
                  _selectedMuscleGroup = muscleGroup;
                });
              },
              onEquipmentChanged: (equipment) {
                setState(() {
                  _selectedEquipment = equipment;
                });
              },
              onDifficultyChanged: (difficulty) {
                setState(() {
                  _selectedDifficulty = difficulty;
                });
              },
            ),
            Expanded(
              child: _buildExerciseList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExerciseList() {
    final exerciseRepository = ref.watch(exerciseRepositoryProvider);
    
    return FutureBuilder<List<Exercise>>(
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
                const Icon(Icons.error_outline, size: 64, color: Colors.grey),
                const SizedBox(height: 16),
                Text(
                  'Error loading exercises',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  snapshot.error.toString(),
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
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
                Text(
                  'No exercises found',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 8),
                Text(
                  'Start by seeding the exercise database',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          );
        }
        
        final exercises = _filterExercises(snapshot.data!);
        
        if (exercises.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.search_off, size: 64, color: Colors.grey),
                SizedBox(height: 16),
                Text(
                  'No exercises match your filters',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 8),
                Text(
                  'Try adjusting your search or filters',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          );
        }
        
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: exercises.length,
          itemBuilder: (context, index) {
            return ExerciseListItem(
              exercise: exercises[index],
              onTap: () => _showExerciseDetail(exercises[index]),
            );
          },
        );
      },
    );
  }
  
  List<Exercise> _filterExercises(List<Exercise> exercises) {
    return exercises.where((exercise) {
      // Search query filter
      if (_searchQuery.isNotEmpty &&
          !exercise.name.toLowerCase().contains(_searchQuery.toLowerCase()) &&
          !exercise.instructions.toLowerCase().contains(_searchQuery.toLowerCase()) &&
          !exercise.primaryMuscleGroup.toLowerCase().contains(_searchQuery.toLowerCase())) {
        return false;
      }
      
      // Category filter
      if (_selectedCategory != 'All' &&
          exercise.category.toLowerCase() != _selectedCategory.toLowerCase()) {
        return false;
      }
      
      // Muscle group filter
      if (_selectedMuscleGroup != 'All' &&
          exercise.primaryMuscleGroup.toLowerCase() != _selectedMuscleGroup.toLowerCase() &&
          !exercise.secondaryMuscleGroups.any((mg) => mg.toLowerCase() == _selectedMuscleGroup.toLowerCase())) {
        return false;
      }
      
      // Equipment filter
      if (_selectedEquipment != 'All' &&
          exercise.equipment.toLowerCase() != _selectedEquipment.toLowerCase()) {
        return false;
      }
      
      // Difficulty filter
      if (_selectedDifficulty != 'All' &&
          exercise.difficulty.toLowerCase() != _selectedDifficulty.toLowerCase()) {
        return false;
      }
      
      return true;
    }).toList();
  }
  
  void _showExerciseDetail(Exercise exercise) {
    Navigator.of(context).pushNamed('/exercise-detail', arguments: exercise);
  }
}