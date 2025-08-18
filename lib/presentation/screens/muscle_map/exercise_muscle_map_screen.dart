import 'package:flutter/material.dart';
import '../../../domain/entities/exercise.dart';
import '../../../domain/entities/muscle_map.dart';
import 'muscle_map_view.dart';

class ExerciseMuscleMapScreen extends StatefulWidget {
  final Exercise exercise;

  const ExerciseMuscleMapScreen({
    super.key,
    required this.exercise,
  });

  @override
  State<ExerciseMuscleMapScreen> createState() => _ExerciseMuscleMapScreenState();
}

class _ExerciseMuscleMapScreenState extends State<ExerciseMuscleMapScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final muscleActivation = widget.exercise.muscleActivation;
    final activationMap = PointsCalculator.calculateActivationMap(muscleActivation);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.exercise.name),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Front View', icon: Icon(Icons.person)),
            Tab(text: 'Back View', icon: Icon(Icons.person_outline)),
          ],
          onTap: (index) {
            // Tab switching is handled by TabBarView automatically
          },
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildMuscleMapTab(MuscleMapOrientation.front, activationMap),
          _buildMuscleMapTab(MuscleMapOrientation.back, activationMap),
        ],
      ),
    );
  }

  Widget _buildMuscleMapTab(MuscleMapOrientation orientation, Map<ScreenMuscle, double> activationMap) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Exercise info card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.exercise.name,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Equipment: ${widget.exercise.defaultEquipment}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  if (widget.exercise.difficultyLevel > 0)
                    Text(
                      'Difficulty: ${_getDifficultyText(widget.exercise.difficultyLevel)}/5',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Muscle map
          Center(
            child: Column(
              children: [
                Text(
                  '${orientation == MuscleMapOrientation.front ? 'Front' : 'Back'} View - Muscle Activation',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                MuscleMapView(
                  muscleActivation: activationMap,
                  orientation: orientation,
                  showLabels: true,
                  width: 280,
                  height: 400,
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Legend
          _buildLegend(activationMap),
          
          const SizedBox(height: 20),
          
          // Muscle details
          _buildMuscleDetails(widget.exercise.muscleActivation),
        ],
      ),
    );
  }

  Widget _buildLegend(Map<ScreenMuscle, double> activationMap) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Legend',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: Colors.red.withValues(alpha: 1.0),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 8),
                const Text('Target Muscles (High Activation)'),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: Colors.orange.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 8),
                const Text('Synergist Muscles (Supporting)'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMuscleDetails(MuscleActivation activation) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Muscle Groups Worked',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            
            if (activation.targetMuscles.isNotEmpty) ...[
              Text(
                'Primary (Target) Muscles:',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: activation.targetMuscles.keys.map((muscle) => Chip(
                  label: Text(muscle.displayName),
                  backgroundColor: Colors.red.withValues(alpha: 0.2),
                  side: BorderSide(color: Colors.red.withValues(alpha: 0.5)),
                )).toList(),
              ),
              const SizedBox(height: 12),
            ],
            
            if (activation.synergistMuscles.isNotEmpty) ...[
              Text(
                'Secondary (Synergist) Muscles:',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: activation.synergistMuscles.keys.map((muscle) => Chip(
                  label: Text(muscle.displayName),
                  backgroundColor: Colors.orange.withValues(alpha: 0.2),
                  side: BorderSide(color: Colors.orange.withValues(alpha: 0.5)),
                )).toList(),
              ),
            ],
            
            if (activation.targetMuscles.isEmpty && activation.synergistMuscles.isEmpty)
              Text(
                'No muscle data available for this exercise.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
          ],
        ),
      ),
    );
  }

  String _getDifficultyText(int level) {
    switch (level) {
      case 1:
        return 'Beginner';
      case 2:
        return 'Easy';
      case 3:
        return 'Intermediate';
      case 4:
        return 'Hard';
      case 5:
        return 'Advanced';
      default:
        return 'Unknown';
    }
  }
}