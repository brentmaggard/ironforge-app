import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/common/main_navigation.dart';
import '../../core/providers/database_providers.dart';
import '../../test_json_loading.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final databaseInit = ref.watch(databaseInitializationProvider);
    final exerciseRepository = ref.watch(exerciseRepositoryProvider);

    return MainNavigation(
      currentIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dashboard'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Database status
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Database Status',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      databaseInit.when(
                        data: (_) => const Row(
                          children: [
                            Icon(Icons.check_circle, color: Colors.green),
                            SizedBox(width: 8),
                            Text('Database initialized successfully'),
                          ],
                        ),
                        loading: () => const Row(
                          children: [
                            SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                            SizedBox(width: 8),
                            Text('Initializing database...'),
                          ],
                        ),
                        error: (error, stack) => Row(
                          children: [
                            const Icon(Icons.error, color: Colors.red),
                            const SizedBox(width: 8),
                            Text('Error: $error'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Exercise count
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Exercise Database',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      FutureBuilder(
                        future: databaseInit.hasValue ? exerciseRepository.getAllExercises() : null,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Text('Loading exercises...');
                          } else if (snapshot.hasError) {
                            return Text('Error loading exercises: ${snapshot.error}');
                          } else if (snapshot.hasData) {
                            final exercises = snapshot.data!;
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Total exercises: ${exercises.length}'),
                                const SizedBox(height: 8),
                                if (exercises.isNotEmpty) ...[
                                  Text('Sample exercises:'),
                                  ...exercises.take(3).map((exercise) => Padding(
                                    padding: const EdgeInsets.only(left: 16, top: 4),
                                    child: Text('• ${exercise.name} (${exercise.category})'),
                                  )),
                                ],
                              ],
                            );
                          } else {
                            return const Text('No data available');
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Quick actions
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Quick Actions',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          FilledButton.icon(
                            onPressed: () {
                              // TODO: Navigate to start workout
                            },
                            icon: const Icon(Icons.fitness_center),
                            label: const Text('Start Workout'),
                          ),
                          FilledButton.icon(
                            onPressed: () {
                              // TODO: Navigate to browse exercises
                            },
                            icon: const Icon(Icons.search),
                            label: const Text('Browse Exercises'),
                          ),
                          FilledButton.icon(
                            onPressed: () {
                              // TODO: Navigate to create goal
                            },
                            icon: const Icon(Icons.flag),
                            label: const Text('Set Goal'),
                          ),
                          FilledButton.icon(
                            onPressed: () async {
                              // Test JSON loading
                              await testJsonLoading();
                            },
                            icon: const Icon(Icons.bug_report),
                            label: const Text('Test JSON'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}