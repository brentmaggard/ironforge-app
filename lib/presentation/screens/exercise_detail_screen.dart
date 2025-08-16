import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/exercise.dart';
import '../providers/exercise_favorites_provider.dart';

class ExerciseDetailScreen extends ConsumerStatefulWidget {
  final Exercise exercise;
  
  const ExerciseDetailScreen({
    super.key,
    required this.exercise,
  });

  @override
  ConsumerState<ExerciseDetailScreen> createState() => _ExerciseDetailScreenState();
}

class _ExerciseDetailScreenState extends ConsumerState<ExerciseDetailScreen> {

  @override
  Widget build(BuildContext context) {
    final exercise = widget.exercise;
    final favoritesNotifier = ref.watch(exerciseFavoritesNotifierProvider.notifier);
    final favorites = ref.watch(exerciseFavoritesNotifierProvider);
    final isFavorited = favorites.value?.contains(exercise.id) ?? false;
    
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App bar with image background
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                exercise.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      offset: Offset(1, 1),
                      blurRadius: 3,
                      color: Colors.black54,
                    ),
                  ],
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.primaryContainer,
                    ],
                  ),
                ),
                child: Center(
                  child: Icon(
                    _getExerciseIcon(exercise.category),
                    size: 80,
                    color: Colors.white.withOpacity(0.3),
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  isFavorited ? Icons.favorite : Icons.favorite_border,
                  color: isFavorited ? Colors.red : null,
                ),
                onPressed: () {
                  favoritesNotifier.toggleFavorite(exercise.id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        isFavorited 
                          ? 'Removed from favorites' 
                          : 'Added to favorites',
                      ),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
              ),
            ],
          ),
          
          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Quick info cards
                  Row(
                    children: [
                      Expanded(
                        child: _InfoCard(
                          icon: Icons.fitness_center,
                          label: 'Equipment',
                          value: exercise.equipment,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _InfoCard(
                          icon: Icons.speed,
                          label: 'Difficulty',
                          value: exercise.difficulty,
                          color: _getDifficultyColor(exercise.difficulty),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  Row(
                    children: [
                      Expanded(
                        child: _InfoCard(
                          icon: Icons.category,
                          label: 'Type',
                          value: exercise.category,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _InfoCard(
                          icon: Icons.accessibility_new,
                          label: 'Muscle Group',
                          value: exercise.primaryMuscleGroup,
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Starting weights (if available)
                  if (exercise.startingWeightLbs != null || exercise.startingWeightKg != null) ...[
                    _SectionHeader(
                      icon: Icons.monitor_weight,
                      title: 'Suggested Starting Weight',
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          if (exercise.startingWeightLbs != null) ...[
                            Column(
                              children: [
                                Text(
                                  '${exercise.startingWeightLbs!.toInt()}',
                                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                Text(
                                  'lbs',
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          ],
                          if (exercise.startingWeightKg != null) ...[
                            Column(
                              children: [
                                Text(
                                  '${exercise.startingWeightKg!.toInt()}',
                                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                Text(
                                  'kg',
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                  
                  // Description
                  if (exercise.description != null && exercise.description!.isNotEmpty) ...[
                    _SectionHeader(
                      icon: Icons.description,
                      title: 'Description',
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        exercise.description!,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                  
                  // Instructions
                  if (exercise.instructions != null && exercise.instructions!.isNotEmpty) ...[
                    _SectionHeader(
                      icon: Icons.list_alt,
                      title: 'Instructions',
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        exercise.instructions!,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                  
                  // Tips
                  if (exercise.tips != null && exercise.tips!.isNotEmpty) ...[
                    _SectionHeader(
                      icon: Icons.lightbulb,
                      title: 'Tips & Form Cues',
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.tertiaryContainer.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Theme.of(context).colorScheme.tertiary.withOpacity(0.3),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.tips_and_updates,
                                color: Theme.of(context).colorScheme.tertiary,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Pro Tips',
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: Theme.of(context).colorScheme.tertiary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            exercise.tips!,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                  
                  // Exercise metadata
                  _SectionHeader(
                    icon: Icons.info,
                    title: 'Exercise Details',
                  ),
                  const SizedBox(height: 8),
                  
                  // Difficulty and safety
                  if (exercise.difficultyLevel != null || exercise.safetyRating != null) ...[
                    Row(
                      children: [
                        if (exercise.difficultyLevel != null) ...[
                          Expanded(
                            child: _MetricCard(
                              label: 'Difficulty Level',
                              value: exercise.difficultyLevel!,
                              maxValue: 5,
                              color: _getDifficultyColor(exercise.difficulty),
                              icon: Icons.speed,
                            ),
                          ),
                        ],
                        if (exercise.difficultyLevel != null && exercise.safetyRating != null)
                          const SizedBox(width: 12),
                        if (exercise.safetyRating != null) ...[
                          Expanded(
                            child: _MetricCard(
                              label: 'Safety Rating',
                              value: exercise.safetyRating!,
                              maxValue: 5,
                              color: exercise.safetyRating! >= 4 ? Colors.green : 
                                     exercise.safetyRating! >= 3 ? Colors.orange : Colors.red,
                              icon: Icons.security,
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                  
                  // Exercise characteristics
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      if (exercise.isCompound == true)
                        _CharacteristicChip(
                          label: 'Compound Exercise',
                          icon: Icons.fitness_center,
                          color: Colors.blue,
                        ),
                      if (exercise.isUnilateral == true)
                        _CharacteristicChip(
                          label: 'Unilateral',
                          icon: Icons.compare_arrows,
                          color: Colors.purple,
                        ),
                      if (exercise.requiresSpotter == true)
                        _CharacteristicChip(
                          label: 'Requires Spotter',
                          icon: Icons.people,
                          color: Colors.orange,
                        ),
                    ],
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Action buttons
                  Row(
                    children: [
                      Expanded(
                        child: FilledButton.icon(
                          onPressed: () {
                            // TODO: Add to workout
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Added to current workout')),
                            );
                          },
                          icon: const Icon(Icons.add),
                          label: const Text('Add to Workout'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            // TODO: Log sets
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Opening workout logger')),
                            );
                          },
                          icon: const Icon(Icons.edit),
                          label: const Text('Log Sets'),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                ],
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
        return Icons.my_location;
      case 'push':
        return Icons.arrow_upward;
      case 'pull':
        return Icons.arrow_downward;
      case 'legs':
        return Icons.directions_walk;
      case 'core':
        return Icons.center_focus_strong;
      case 'cardio':
        return Icons.favorite;
      default:
        return Icons.fitness_center;
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
        return Colors.blue;
    }
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? color;

  const _InfoCard({
    required this.icon,
    required this.label,
    required this.value,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color?.withOpacity(0.1) ?? Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color?.withOpacity(0.3) ?? Theme.of(context).colorScheme.outline.withOpacity(0.3),
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color ?? Theme.of(context).colorScheme.primary,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: color ?? Theme.of(context).colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final IconData icon;
  final String title;

  const _SectionHeader({
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: Theme.of(context).colorScheme.primary,
          size: 20,
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String label;
  final int value;
  final int maxValue;
  final Color color;
  final IconData icon;

  const _MetricCard({
    required this.label,
    required this.value,
    required this.maxValue,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 16),
              const SizedBox(width: 4),
              Text(
                label,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              maxValue,
              (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 1),
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: index < value ? color : color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '$value/$maxValue',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class _CharacteristicChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;

  const _CharacteristicChip({
    required this.label,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 16),
          const SizedBox(width: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}