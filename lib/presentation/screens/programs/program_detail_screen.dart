import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/program.dart';
import '../../../domain/entities/exercise.dart';
import '../../../core/providers/database_providers.dart';

class ProgramDetailScreen extends ConsumerWidget {
  final Program program;

  const ProgramDetailScreen({
    super.key,
    required this.program,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(program.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // TODO: Implement program sharing
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProgramHeader(),
            _buildProgramInfo(),
            _buildWorkoutList(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Back'),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 2,
              child: ElevatedButton(
                onPressed: () => _startProgram(context, ref),
                child: const Text('START PROGRAM'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgramHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            _getDifficultyColor(program.difficulty),
            _getDifficultyColor(program.difficulty).withOpacity(0.7),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            program.name,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          if (program.author != null)
            Text(
              'by ${program.author}',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildHeaderChip(
                Icons.signal_cellular_alt,
                program.difficulty.toUpperCase(),
              ),
              const SizedBox(width: 12),
              _buildHeaderChip(
                Icons.schedule,
                '${program.frequency ?? 3}x/week',
              ),
              const SizedBox(width: 12),
              _buildHeaderChip(
                Icons.calendar_today,
                '${program.durationWeeks ?? 12} weeks',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.white),
          const SizedBox(width: 4),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgramInfo() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'About This Program',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          if (program.description != null)
            Text(
              program.description!,
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
                color: Colors.grey[700],
              ),
            ),
          const SizedBox(height: 24),
          _buildProgramStats(),
          const SizedBox(height: 24),
          if (program.tags?.isNotEmpty == true) _buildTags(),
        ],
      ),
    );
  }

  Widget _buildProgramStats() {
    final workouts = program.workouts;
    final totalExercises = workouts.values.fold<int>(
      0,
      (sum, workout) => sum + workout.exercises.length,
    );

    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            'Workouts',
            workouts.length.toString(),
            Icons.fitness_center,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildStatCard(
            'Total Exercises',
            totalExercises.toString(),
            Icons.list,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildStatCard(
            'Schedule',
            program.schedule.length.toString() + ' days',
            Icons.calendar_view_week,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        children: [
          Icon(icon, size: 24, color: Colors.grey[600]),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTags() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Tags',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: program.tags!.map((tag) {
            return Chip(
              label: Text(tag),
              backgroundColor: Colors.grey[100],
            );
          }).toList(),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildWorkoutList() {
    final workouts = program.workouts;
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Workouts',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ...workouts.entries.map((entry) {
            return _buildWorkoutCard(entry.key, entry.value);
          }).toList(),
          const SizedBox(height: 100), // Bottom padding for FAB
        ],
      ),
    );
  }

  Widget _buildWorkoutCard(String workoutKey, ProgramWorkout workout) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ExpansionTile(
        title: Text(
          workout.name,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text('${workout.exercises.length} exercises'),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: workout.exercises.asMap().entries.map((entry) {
                final index = entry.key;
                final exercise = entry.value;
                return _buildExerciseItem(exercise, index);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExerciseItem(ProgramExercise programExercise, int index) {
    return Consumer(
      builder: (context, ref, child) {
        final exerciseAsync = ref.watch(exerciseByExerciseIdProvider(programExercise.exerciseId));
        
        return exerciseAsync.when(
          data: (exercise) => _buildExerciseItemContent(exercise, programExercise, index),
          loading: () => const ListTile(
            title: Text('Loading...'),
            leading: CircularProgressIndicator(),
          ),
          error: (error, stack) => ListTile(
            title: Text('Exercise ${programExercise.exerciseId}'),
            subtitle: Text('Error loading exercise'),
            leading: const Icon(Icons.error),
          ),
        );
      },
    );
  }

  Widget _buildExerciseItemContent(Exercise? exercise, ProgramExercise programExercise, int index) {
    final exerciseName = exercise?.name ?? 'Unknown Exercise';
    final sets = programExercise.sets;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    '${index + 1}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  exerciseName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              if (programExercise.restTime != null)
                Text(
                  '${(programExercise.restTime! / 60).round()}min rest',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            _formatSetsDescription(sets),
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
            ),
          ),
          if (programExercise.progression != null) ...[
            const SizedBox(height: 4),
            Text(
              'Progression: +${programExercise.progression!.increment} ${programExercise.progression!.unit}',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _formatSetsDescription(List<ProgramSet> sets) {
    if (sets.isEmpty) return 'No sets defined';
    
    final Map<String, int> setGroups = {};
    for (final set in sets) {
      final key = '${set.reps} @ ${set.weight}lbs';
      setGroups[key] = (setGroups[key] ?? 0) + 1;
    }
    
    return setGroups.entries.map((entry) {
      return '${entry.value} × ${entry.key}';
    }).join(', ');
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

  void _startProgram(BuildContext context, WidgetRef ref) {
    // TODO: Implement program start logic with UserProgram creation
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Starting ${program.name}...')),
    );
    Navigator.pop(context);
  }
}

// Provider to get exercise by ID
final exerciseByIdProvider = FutureProvider.family<Exercise?, String>((ref, exerciseId) async {
  final exerciseRepository = ref.watch(exerciseRepositoryProvider);
  return await exerciseRepository.getExerciseById(exerciseId);
});

// Provider to get exercise by exercise_id (for program templates)
final exerciseByExerciseIdProvider = FutureProvider.family<Exercise?, String>((ref, exerciseId) async {
  final exerciseRepository = ref.watch(exerciseRepositoryProvider);
  return await exerciseRepository.getExerciseByExerciseId(exerciseId);
});