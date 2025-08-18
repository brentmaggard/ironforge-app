import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../widgets/common/main_navigation.dart';
import '../../../core/providers/database_providers.dart';
import '../../../data/datasources/workout_seeder.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MainNavigation(
      currentIndex: 0,
      child: Scaffold(
        appBar: const MainAppBar(title: 'Dashboard'),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.dashboard, size: 64),
              const SizedBox(height: 16),
              const Text(
                'Dashboard',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text('Workout overview and quick stats'),
              const SizedBox(height: 32),
              // Temporary debug button to reseed workouts
              ElevatedButton(
                onPressed: () async {
                  try {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Clearing and reseeding workouts...')),
                    );
                    
                    final database = ref.read(databaseProvider);
                    await WorkoutSeeder.seedSampleWorkouts(database, force: true);
                    
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Workouts reseeded successfully!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error reseeding workouts: $e'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: const Text('🔄 Reseed Sample Workouts'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}