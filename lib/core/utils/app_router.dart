import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/screens/dashboard/dashboard_screen.dart';
import '../../presentation/screens/goals/goals_screen.dart';
import '../../presentation/screens/workouts/workouts_screen.dart';
import '../../presentation/screens/programs/programs_screen.dart';
import '../../presentation/screens/progress/progress_screen.dart';
import '../../presentation/screens/exercises_screen.dart';
import '../../presentation/screens/exercise_detail_screen.dart';
import '../../presentation/screens/plate_calculator/plate_calculator_screen.dart';
import '../../domain/entities/exercise.dart';

/// App navigation configuration using go_router
class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/dashboard',
    routes: [
      GoRoute(
        path: '/dashboard',
        name: 'dashboard',
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: '/goals',
        name: 'goals',
        builder: (context, state) => const GoalsScreen(),
      ),
      GoRoute(
        path: '/workouts',
        name: 'workouts',
        builder: (context, state) => const WorkoutsScreen(),
      ),
      GoRoute(
        path: '/programs',
        name: 'programs',
        builder: (context, state) => const ProgramsScreen(),
      ),
      GoRoute(
        path: '/progress',
        name: 'progress',
        builder: (context, state) => const ProgressScreen(),
      ),
      GoRoute(
        path: '/exercises',
        name: 'exercises',
        builder: (context, state) => const ExercisesScreen(),
      ),
      GoRoute(
        path: '/exercises/:exerciseId',
        name: 'exercise-detail',
        builder: (context, state) {
          final exerciseId = state.pathParameters['exerciseId']!;
          final Exercise exercise = state.extra as Exercise;
          return ExerciseDetailScreen(exercise: exercise);
        },
      ),
      GoRoute(
        path: '/plate-calculator',
        name: 'plate-calculator',
        builder: (context, state) => const PlateCalculatorScreen(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text('Page Not Found')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64),
            const SizedBox(height: 16),
            Text(
              'Page not found: ${state.uri}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () => context.go('/dashboard'),
              child: const Text('Go to Dashboard'),
            ),
          ],
        ),
      ),
    ),
  );
}