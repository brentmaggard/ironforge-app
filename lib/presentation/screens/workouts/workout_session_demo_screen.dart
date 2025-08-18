import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'new_workout_session_screen.dart';
import 'providers/workout_session_demo_provider.dart';
import 'providers/workout_session_service_provider.dart';

class WorkoutSessionDemoScreen extends ConsumerStatefulWidget {
  const WorkoutSessionDemoScreen({super.key});

  @override
  ConsumerState<WorkoutSessionDemoScreen> createState() => _WorkoutSessionDemoScreenState();
}

class _WorkoutSessionDemoScreenState extends ConsumerState<WorkoutSessionDemoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout Session Demo'),
        backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Workout Session Screen Demos',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          
          const SizedBox(height: 8),
          
          Text(
            'Test different states of the new workout session interface following the build specification.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Demo 1: Active workout with mixed completion
          _DemoCard(
            title: 'Active Workout Session',
            description: 'Push day workout with some completed sets, warmups visible',
            onTap: () {
              final session = ref.read(demoWorkoutSessionProvider);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => NewWorkoutSessionScreen(
                    initialSession: session,
                  ),
                ),
              );
            },
          ),
          
          const SizedBox(height: 12),
          
          // Demo 2: Paused workout
          _DemoCard(
            title: 'Paused Workout Session',
            description: 'Workout session in paused state with longer elapsed time',
            onTap: () {
              final session = ref.read(demoWorkoutSessionPausedProvider);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => NewWorkoutSessionScreen(
                    initialSession: session,
                  ),
                ),
              );
            },
          ),
          
          const SizedBox(height: 12),
          
          // Demo 3: Collapsed warmups
          _DemoCard(
            title: 'Collapsed Warmups',
            description: 'All warmup sections collapsed to show compact view',
            onTap: () {
              final session = ref.read(demoWorkoutSessionWithAllWarmupsCollapsedProvider);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => NewWorkoutSessionScreen(
                    initialSession: session,
                  ),
                ),
              );
            },
          ),
          
          const SizedBox(height: 12),
          
          // Demo 4: Kilogram units
          _DemoCard(
            title: 'Kilogram Units',
            description: 'Same workout but with weights converted to kilograms',
            onTap: () {
              final session = ref.read(demoWorkoutSessionKgProvider);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => NewWorkoutSessionScreen(
                    initialSession: session,
                  ),
                ),
              );
            },
          ),
          
          const SizedBox(height: 12),
          
          // Demo 5: Database Integration Test
          _DemoCard(
            title: 'Database Integration Test',
            description: 'Test real database save/load with basic workout',
            onTap: () async {
              // Create a simple workout session to test database integration
              final service = ref.read(workoutSessionServiceProvider);
              final navigator = Navigator.of(context);
              final messenger = ScaffoldMessenger.of(context);
              
              try {
                final session = await service.createWorkoutSessionFromExercises(
                  title: 'Database Test Workout',
                  exerciseIds: ['dumbbell_bench_press', 'dumbbell_row'],
                );
                
                if (mounted) {
                  navigator.push(
                    MaterialPageRoute(
                      builder: (context) => NewWorkoutSessionScreen(
                        initialSession: session,
                        workoutId: null, // Will create new workout in database
                      ),
                    ),
                  );
                }
              } catch (e) {
                if (mounted) {
                  messenger.showSnackBar(
                    SnackBar(content: Text('Failed to create workout: $e')),
                  );
                }
              }
            },
          ),
          
          const SizedBox(height: 32),
          
          // Info section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Features to Test',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  '• Timer with pause/resume functionality\n'
                  '• Weight/reps editing with bottom sheet\n'
                  '• Unit conversion (lb ↔ kg)\n'
                  '• Collapsible warmup sections\n'
                  '• Set completion tracking\n'
                  '• Exercise overflow menu actions\n'
                  '• Numeric keypad input\n'
                  '• Workout completion dialog',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DemoCard extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onTap;

  const _DemoCard({
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}