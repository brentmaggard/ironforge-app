import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../widgets/common/main_navigation.dart';
import '../../../domain/entities/workout.dart';
import '../../../core/providers/database_providers.dart';
import 'workout_session_screen.dart';

class WorkoutsScreen extends ConsumerStatefulWidget {
  const WorkoutsScreen({super.key});

  @override
  ConsumerState<WorkoutsScreen> createState() => _WorkoutsScreenState();
}

class _WorkoutsScreenState extends ConsumerState<WorkoutsScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return MainNavigation(
      currentIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Workouts'),
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'Active', icon: Icon(Icons.play_arrow)),
              Tab(text: 'History', icon: Icon(Icons.history)),
              Tab(text: 'Templates', icon: Icon(Icons.library_books)),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => _showCreateWorkoutDialog(context),
              tooltip: 'Start new workout',
            ),
          ],
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildActiveWorkoutsTab(),
            _buildHistoryTab(),
            _buildTemplatesTab(),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => _startQuickWorkout(context),
          icon: const Icon(Icons.fitness_center),
          label: const Text('Quick Start'),
        ),
      ),
    );
  }

  Widget _buildActiveWorkoutsTab() {
    return Consumer(
      builder: (context, ref, child) {
        final workoutsAsync = ref.watch(userWorkoutsProvider('demo-user'));
        
        return workoutsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(
            child: Text('Error loading workouts: $error'),
          ),
          data: (workouts) {
            final activeWorkouts = workouts.where((w) => w.isInProgress || w.isPlanned).toList();
            
            if (activeWorkouts.isEmpty) {
              return _buildEmptyState(
                icon: Icons.play_arrow,
                title: 'No Active Workouts',
                subtitle: 'Start a new workout to begin tracking your progress',
                actionText: 'Start Workout',
                onAction: () => _startQuickWorkout(context),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: activeWorkouts.length,
              itemBuilder: (context, index) {
                final workout = activeWorkouts[index];
                return _buildWorkoutCard(workout);
              },
            );
          },
        );
      },
    );
  }

  Widget _buildHistoryTab() {
    return Consumer(
      builder: (context, ref, child) {
        final workoutsAsync = ref.watch(userWorkoutsProvider('demo-user'));
        
        return workoutsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(
            child: Text('Error loading workouts: $error'),
          ),
          data: (workouts) {
            final completedWorkouts = workouts.where((w) => w.isCompleted).toList();
            
            if (completedWorkouts.isEmpty) {
              return _buildEmptyState(
                icon: Icons.history,
                title: 'No Workout History',
                subtitle: 'Complete your first workout to see it here',
                actionText: 'Start Workout',
                onAction: () => _startQuickWorkout(context),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: completedWorkouts.length,
              itemBuilder: (context, index) {
                final workout = completedWorkouts[index];
                return _buildWorkoutCard(workout);
              },
            );
          },
        );
      },
    );
  }

  Widget _buildTemplatesTab() {
    return _buildEmptyState(
      icon: Icons.library_books,
      title: 'No Workout Templates',
      subtitle: 'Create reusable workout templates for consistent training',
      actionText: 'Create Template',
      onAction: () => _showCreateTemplateDialog(context),
    );
  }

  Widget _buildEmptyState({
    required IconData icon,
    required String title,
    required String subtitle,
    required String actionText,
    required VoidCallback onAction,
  }) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 80,
              color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.6),
            ),
            const SizedBox(height: 24),
            Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            FilledButton.icon(
              onPressed: onAction,
              icon: const Icon(Icons.add),
              label: Text(actionText),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkoutCard(Workout workout) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    workout.name,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                _buildStatusChip(workout.status),
              ],
            ),
            if (workout.notes?.isNotEmpty == true) ...[
              const SizedBox(height: 8),
              Text(
                workout.notes!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
            const SizedBox(height: 16),
            
            // Workout stats
            Row(
              children: [
                Expanded(
                  child: _buildStatItem(
                    icon: Icons.fitness_center,
                    label: 'Sets',
                    value: workout.totalSets.toString(),
                  ),
                ),
                Expanded(
                  child: _buildStatItem(
                    icon: Icons.repeat,
                    label: 'Reps',
                    value: workout.totalReps.toString(),
                  ),
                ),
                Expanded(
                  child: _buildStatItem(
                    icon: Icons.monitor_weight,
                    label: 'Volume',
                    value: '${workout.totalVolume.toInt()} lbs',
                  ),
                ),
                if (workout.duration != null)
                  Expanded(
                    child: _buildStatItem(
                      icon: Icons.timer,
                      label: 'Duration',
                      value: _formatDuration(workout.duration!),
                    ),
                  ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Action buttons
            Row(
              children: [
                if (workout.isInProgress) ...[
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: () => _continueWorkout(workout),
                      icon: const Icon(Icons.play_arrow),
                      label: const Text('Continue'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _finishWorkout(workout),
                      icon: const Icon(Icons.stop),
                      label: const Text('Finish'),
                    ),
                  ),
                ] else if (workout.isPlanned) ...[
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: () => _startWorkout(workout),
                      icon: const Icon(Icons.play_arrow),
                      label: const Text('Start'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _editWorkout(workout),
                      icon: const Icon(Icons.edit),
                      label: const Text('Edit'),
                    ),
                  ),
                ] else if (workout.isCompleted) ...[
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _viewWorkout(workout),
                      icon: const Icon(Icons.visibility),
                      label: const Text('View Details'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _repeatWorkout(workout),
                      icon: const Icon(Icons.repeat),
                      label: const Text('Repeat'),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color color;
    IconData icon;
    
    switch (status) {
      case 'in_progress':
        color = Colors.orange;
        icon = Icons.play_arrow;
        break;
      case 'completed':
        color = Colors.green;
        icon = Icons.check_circle;
        break;
      case 'planned':
        color = Colors.blue;
        icon = Icons.schedule;
        break;
      default:
        color = Colors.grey;
        icon = Icons.help_outline;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 4),
          Text(
            status.split('_').map((word) => word[0].toUpperCase() + word.substring(1)).join(' '),
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        Icon(
          icon,
          size: 20,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }

  void _showCreateWorkoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create New Workout'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Workout Name',
                hintText: 'e.g., Push Day, Pull Day, Legs',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Notes (optional)',
                hintText: 'Any notes about this workout...',
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(context).pop();
              _startQuickWorkout(context);
            },
            child: const Text('Create & Start'),
          ),
        ],
      ),
    );
  }

  void _showCreateTemplateDialog(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Workout templates feature coming soon!'),
      ),
    );
  }

  void _startQuickWorkout(BuildContext context) {
    final newWorkout = Workout(
      id: 'workout_${DateTime.now().millisecondsSinceEpoch}',
      userId: 'demo-user',
      name: 'Quick Workout',
      status: 'in_progress',
      totalSets: 0,
      totalReps: 0,
      totalVolume: 0.0,
      startedAt: DateTime.now(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => WorkoutSessionScreen(
          workout: newWorkout,
          isQuickStart: true,
        ),
      ),
    );
  }

  void _continueWorkout(Workout workout) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => WorkoutSessionScreen(workout: workout),
      ),
    );
  }

  void _startWorkout(Workout workout) {
    final startedWorkout = workout.copyWith(
      status: 'in_progress',
      startedAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => WorkoutSessionScreen(workout: startedWorkout),
      ),
    );
  }

  void _finishWorkout(Workout workout) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Finishing ${workout.name}...'),
      ),
    );
  }

  void _editWorkout(Workout workout) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Editing ${workout.name}...'),
      ),
    );
  }

  void _viewWorkout(Workout workout) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Viewing ${workout.name}...'),
      ),
    );
  }

  void _repeatWorkout(Workout workout) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Creating new workout based on ${workout.name}...'),
      ),
    );
  }
}