import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/goal.dart';
import '../../../core/providers/database_providers.dart';
import '../../widgets/common/main_navigation.dart';
import 'widgets/goal_card.dart';
import 'widgets/create_goal_dialog.dart';

class GoalsScreen extends ConsumerWidget {
  const GoalsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // For now, using a dummy user ID. In a real app, this would come from auth
    const userId = 'user_123';
    
    final goalsAsync = ref.watch(userGoalsProvider(userId));

    return MainNavigation(
      currentIndex: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Goals'),
          actions: [
            IconButton(
              onPressed: () => _showCreateGoalDialog(context),
              icon: const Icon(Icons.add),
              tooltip: 'Create Goal',
            ),
          ],
        ),
        body: Column(
          children: [
            // Stats header
            Container(
              padding: const EdgeInsets.all(16),
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              child: goalsAsync.when(
                data: (goals) {
                  final activeGoals = goals.where((g) => !g.isCompleted).length;
                  final completedGoals = goals.where((g) => g.isCompleted).length;
                  
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _StatCard(
                        title: 'Active Goals',
                        value: activeGoals.toString(),
                        icon: Icons.flag,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      _StatCard(
                        title: 'Completed',
                        value: completedGoals.toString(),
                        icon: Icons.check_circle,
                        color: Colors.green,
                      ),
                      _StatCard(
                        title: 'Total',
                        value: goals.length.toString(),
                        icon: Icons.analytics,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ],
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(
                  child: Text('Error loading stats: $error'),
                ),
              ),
            ),
            
            // Goals list
            Expanded(
              child: goalsAsync.when(
                data: (goals) {
                  if (goals.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.flag_outlined,
                            size: 64,
                            color: Theme.of(context).colorScheme.outline,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No goals yet',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Set your first fitness goal to get started!',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 16),
                          FilledButton.icon(
                            onPressed: () => _showCreateGoalDialog(context),
                            icon: const Icon(Icons.add),
                            label: const Text('Create Goal'),
                          ),
                        ],
                      ),
                    );
                  }
                  
                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: goals.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: GoalCard(
                          goal: goals[index],
                          onTap: () => _showGoalDetails(context, goals[index]),
                          onProgressUpdate: (newProgress) => _updateGoalProgress(
                            ref, goals[index].id, newProgress),
                          onComplete: () => _completeGoal(ref, goals[index].id),
                        ),
                      );
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 64,
                        color: Theme.of(context).colorScheme.error,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Error loading goals',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text('$error'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCreateGoalDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const CreateGoalDialog(),
    );
  }

  void _showGoalDetails(BuildContext context, Goal goal) {
    // TODO: Navigate to goal details screen
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Goal details for: ${goal.title}')),
    );
  }

  void _updateGoalProgress(WidgetRef ref, String goalId, double newProgress) async {
    final goalRepository = ref.read(goalRepositoryProvider);
    await goalRepository.updateGoalProgress(goalId, newProgress);
    // Invalidate the provider to refresh the UI
    ref.invalidate(userGoalsProvider);
  }

  void _completeGoal(WidgetRef ref, String goalId) async {
    final goalRepository = ref.read(goalRepositoryProvider);
    await goalRepository.completeGoal(goalId);
    // Invalidate the provider to refresh the UI
    ref.invalidate(userGoalsProvider);
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String title;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}