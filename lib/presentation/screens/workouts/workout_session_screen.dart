import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/workout.dart';
import '../../../domain/entities/workout_set.dart';
import '../../../domain/entities/exercise.dart';
import '../../../core/providers/database_providers.dart';
import '../exercises/exercise_selection_screen.dart';
import 'providers/workout_session_provider.dart';

class WorkoutSessionScreen extends ConsumerStatefulWidget {
  final Workout workout;
  final bool isQuickStart;
  
  const WorkoutSessionScreen({
    super.key,
    required this.workout,
    this.isQuickStart = false,
  });

  @override
  ConsumerState<WorkoutSessionScreen> createState() => _WorkoutSessionScreenState();
}

class _WorkoutSessionScreenState extends ConsumerState<WorkoutSessionScreen> {
  Timer? _workoutTimer;
  Duration _elapsedTime = Duration.zero;
  Timer? _restTimer;
  Duration _restTimeRemaining = Duration.zero;
  bool _isResting = false;
  
  // Timer will be managed by the provider
  
  // Editing state
  String? _editingSetId;
  int? _editingExerciseIndex;
  String? _editingField; // 'weight', 'reps', 'rpe'
  final TextEditingController _editController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _startWorkoutTimer();
    _initializeWorkoutSession();
  }

  @override
  void dispose() {
    _workoutTimer?.cancel();
    _restTimer?.cancel();
    _editController.dispose();
    super.dispose();
  }

  void _initializeWorkoutSession() {
    // Initialize the workout session in the provider
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref.read(workoutSessionProvider.notifier).startWorkout(widget.workout);
    });
  }


  void _startWorkoutTimer() {
    _workoutTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _elapsedTime = Duration(seconds: _elapsedTime.inSeconds + 1);
      });
      // Update provider with elapsed time
      ref.read(workoutSessionProvider.notifier).updateElapsedTime(_elapsedTime);
    });
  }

  void _startRestTimer(Duration restDuration) {
    setState(() {
      _isResting = true;
      _restTimeRemaining = restDuration;
    });

    _restTimer?.cancel();
    _restTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_restTimeRemaining.inSeconds > 0) {
          _restTimeRemaining = Duration(seconds: _restTimeRemaining.inSeconds - 1);
        } else {
          _isResting = false;
          timer.cancel();
        }
      });
    });
  }

  void _addExercise() async {
    final selectedExercise = await Navigator.of(context).push<Exercise>(
      MaterialPageRoute(
        builder: (context) => const ExerciseSelectionScreen(),
      ),
    );
    
    if (selectedExercise != null) {
      final newExercise = WorkoutExercise(
        exercise: selectedExercise,
        plannedSets: 3,
        targetReps: 10,
        targetWeight: selectedExercise.startingWeightLbs ?? 0,
        completedSets: [],
      );
      ref.read(workoutSessionProvider.notifier).addExercise(newExercise);
    }
  }

  void _reorderExercises(int oldIndex, int newIndex) {
    ref.read(workoutSessionProvider.notifier).reorderExercises(oldIndex, newIndex);
  }

  void _toggleSetCompletion(int exerciseIndex, int setIndex) {
    final sessionData = ref.read(workoutSessionProvider);
    if (sessionData != null && 
        exerciseIndex < sessionData.exercises.length &&
        setIndex < sessionData.exercises[exerciseIndex].completedSets.length) {
      
      final set = sessionData.exercises[exerciseIndex].completedSets[setIndex];
      final wasCompleted = set.isCompleted;
      final updatedSet = set.copyWith(
        isCompleted: !set.isCompleted,
        completedAt: !set.isCompleted ? DateTime.now() : null,
      );
      
      ref.read(workoutSessionProvider.notifier).updateSet(exerciseIndex, setIndex, updatedSet);
      
      // Start rest timer when set is marked as completed (not when uncompleted)
      if (!wasCompleted && updatedSet.isCompleted) {
        _startRestTimer(const Duration(minutes: 2));
      }
    }
  }

  void _startEditingField(String setId, int exerciseIndex, String field, String currentValue) {
    setState(() {
      _editingSetId = setId;
      _editingExerciseIndex = exerciseIndex;
      _editingField = field;
      _editController.text = currentValue;
    });
  }

  void _saveEdit() {
    if (_editingSetId != null && _editingExerciseIndex != null && _editingField != null) {
      final exerciseIndex = _editingExerciseIndex!;
      final sessionData = ref.read(workoutSessionProvider);
      
      if (sessionData != null && exerciseIndex < sessionData.exercises.length) {
        final setIndex = sessionData.exercises[exerciseIndex].completedSets
            .indexWhere((set) => set.id == _editingSetId);
        
        if (setIndex != -1) {
          final currentSet = sessionData.exercises[exerciseIndex].completedSets[setIndex];
          WorkoutSet updatedSet;
          
          switch (_editingField!) {
            case 'weight':
              final weight = double.tryParse(_editController.text) ?? currentSet.weight;
              updatedSet = currentSet.copyWith(weight: weight);
              break;
            case 'reps':
              final reps = int.tryParse(_editController.text) ?? currentSet.reps;
              updatedSet = currentSet.copyWith(reps: reps);
              break;
            case 'rpe':
              final rpe = double.tryParse(_editController.text);
              updatedSet = currentSet.copyWith(rpe: rpe);
              break;
            default:
              updatedSet = currentSet;
          }
          
          ref.read(workoutSessionProvider.notifier).updateSet(exerciseIndex, setIndex, updatedSet);
          
          setState(() {
            _editingSetId = null;
            _editingExerciseIndex = null;
            _editingField = null;
          });
        }
      }
    }
  }

  void _cancelEdit() {
    setState(() {
      _editingSetId = null;
      _editingExerciseIndex = null;
      _editingField = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: _showCancelWorkoutDialog,
          tooltip: 'Cancel workout',
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.workout.name,
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              _formatElapsedTime(_elapsedTime),
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.pause),
            onPressed: _showPauseDialog,
            tooltip: 'Pause workout',
          ),
          IconButton(
            icon: const Icon(Icons.stop),
            onPressed: _showFinishDialog,
            tooltip: 'Finish workout',
          ),
        ],
        bottom: _isResting ? PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: _buildRestTimer(),
        ) : null,
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final sessionData = ref.watch(workoutSessionProvider);
          final exercises = sessionData?.exercises ?? [];
          
          return Column(
            children: [
              // Workout stats header
              _buildWorkoutStats(exercises),
              
              // Exercise list with reordering
              Expanded(
                child: exercises.isEmpty
                    ? _buildEmptyState()
                    : ReorderableListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: exercises.length,
                        onReorder: _reorderExercises,
                        itemBuilder: (context, index) {
                          return _buildExerciseCard(exercises[index], index);
                        },
                      ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addExercise,
        icon: const Icon(Icons.add),
        label: const Text('Add Exercise'),
      ),
    );
  }

  Widget _buildRestTimer() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.timer,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
              const SizedBox(width: 8),
              Text(
                'Rest Time: ${_formatDuration(_restTimeRemaining)}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
            ],
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _isResting = false;
                _restTimer?.cancel();
              });
            },
            child: Text(
              'Skip Rest',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkoutStats(List<WorkoutExercise> exercises) {
    int totalSets = exercises.fold(0, (sum, ex) => sum + ex.completedSets.length);
    int totalReps = exercises.fold(0, (sum, ex) => 
        sum + ex.completedSets.fold(0, (setSum, set) => setSum + set.reps));
    double totalVolume = exercises.fold(0.0, (sum, ex) => 
        sum + ex.completedSets.fold(0.0, (setSum, set) => setSum + set.volume));

    return Container(
      padding: const EdgeInsets.all(16),
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatColumn('Sets', totalSets.toString(), Icons.fitness_center),
          _buildStatColumn('Reps', totalReps.toString(), Icons.repeat),
          _buildStatColumn('Volume', '${totalVolume.toInt()} lbs', Icons.monitor_weight),
          _buildStatColumn('Time', _formatElapsedTime(_elapsedTime), Icons.timer),
        ],
      ),
    );
  }

  Widget _buildStatColumn(String label, String value, IconData icon) {
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

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.fitness_center,
              size: 80,
              color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.6),
            ),
            const SizedBox(height: 24),
            Text(
              'No Exercises Added',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Add exercises to start tracking your workout',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            FilledButton.icon(
              onPressed: _addExercise,
              icon: const Icon(Icons.add),
              label: const Text('Add Exercise'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExerciseCard(WorkoutExercise workoutExercise, int exerciseIndex) {
    return Card(
      key: ValueKey(workoutExercise.exercise.id),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Exercise header
            Row(
              children: [
                // Drag handle
                Icon(
                  Icons.drag_handle,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        workoutExercise.exercise.name,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${workoutExercise.exercise.primaryMuscles?.isNotEmpty == true ? workoutExercise.exercise.primaryMuscles!.first : 'Unknown'} • ${workoutExercise.exercise.defaultEquipment}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                PopupMenuButton(
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'remove',
                      child: const Row(
                        children: [
                          Icon(Icons.delete_outline),
                          SizedBox(width: 8),
                          Text('Remove'),
                        ],
                      ),
                    ),
                  ],
                  onSelected: (value) {
                    if (value == 'remove') {
                      ref.read(workoutSessionProvider.notifier).removeExercise(exerciseIndex);
                    }
                  },
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Sets list
            if (workoutExercise.completedSets.isNotEmpty) ...[
              // Header for sets table
              Row(
                children: [
                  const SizedBox(width: 40, child: Text('Set', style: TextStyle(fontWeight: FontWeight.bold))),
                  const SizedBox(width: 8),
                  const Expanded(child: Text('Weight', style: TextStyle(fontWeight: FontWeight.bold))),
                  const Expanded(child: Text('Reps', style: TextStyle(fontWeight: FontWeight.bold))),
                  const Expanded(child: Text('RPE', style: TextStyle(fontWeight: FontWeight.bold))),
                  const SizedBox(width: 40),
                ],
              ),
              const Divider(),
              
              // Completed sets
              ...workoutExercise.completedSets.asMap().entries.map((entry) {
                int setIndex = entry.key;
                WorkoutSet set = entry.value;
                return _buildSetRow(set, setIndex + 1, workoutExercise, exerciseIndex, setIndex, true);
              }),
            ],
            
            // Add set button
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => _showAddSetDialog(workoutExercise, exerciseIndex),
                icon: const Icon(Icons.add),
                label: Text('Add Set ${workoutExercise.completedSets.length + 1}'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSetRow(
    WorkoutSet set,
    int setNumber,
    WorkoutExercise workoutExercise,
    int exerciseIndex,
    int setIndex,
    bool isCompleted,
  ) {
    final isEditing = _editingSetId == set.id;
    
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: set.isCompleted 
            ? Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.3)
            : null,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          // Set number with completion checkbox
          SizedBox(
            width: 40,
            child: GestureDetector(
              onTap: () => _toggleSetCompletion(exerciseIndex, setIndex),
              child: Row(
                children: [
                  Icon(
                    set.isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
                    size: 20,
                    color: set.isCompleted 
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.outline,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    setNumber.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      decoration: set.isCompleted ? TextDecoration.lineThrough : null,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          
          // Weight (editable)
          Expanded(
            child: _buildEditableField(
              set.id,
              exerciseIndex,
              'weight',
              '${set.weight.toInt()}',
              'lbs',
            ),
          ),
          
          // Reps (editable)
          Expanded(
            child: _buildEditableField(
              set.id,
              exerciseIndex,
              'reps',
              set.reps.toString(),
              '',
            ),
          ),
          
          // RPE (editable)
          Expanded(
            child: _buildEditableField(
              set.id,
              exerciseIndex,
              'rpe',
              set.rpe?.toString() ?? '',
              '',
            ),
          ),
          
          // Actions
          SizedBox(
            width: 40,
            child: isEditing
                ? Row(
                    children: [
                      GestureDetector(
                        onTap: _saveEdit,
                        child: Icon(
                          Icons.check,
                          size: 16,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: _cancelEdit,
                        child: Icon(
                          Icons.close,
                          size: 16,
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    ],
                  )
                : IconButton(
                    icon: const Icon(Icons.delete_outline, size: 20),
                    onPressed: () {
                      ref.read(workoutSessionProvider.notifier).removeSet(exerciseIndex, setIndex);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditableField(String setId, int exerciseIndex, String field, String value, String suffix) {
    final isEditing = _editingSetId == setId && _editingField == field;
    
    if (isEditing) {
      return SizedBox(
        height: 32,
        child: TextField(
          controller: _editController,
          autofocus: true,
          keyboardType: field == 'rpe' ? const TextInputType.numberWithOptions(decimal: true) : TextInputType.number,
          style: const TextStyle(fontSize: 14),
          decoration: const InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            border: OutlineInputBorder(),
          ),
          onSubmitted: (_) => _saveEdit(),
        ),
      );
    }
    
    return GestureDetector(
      onTap: () => _startEditingField(setId, exerciseIndex, field, value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.transparent),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          value.isEmpty ? '-' : '$value${suffix.isNotEmpty ? ' $suffix' : ''}',
          style: TextStyle(
            fontSize: 14,
            color: value.isEmpty 
                ? Theme.of(context).colorScheme.onSurfaceVariant
                : null,
          ),
        ),
      ),
    );
  }

  void _showAddSetDialog(WorkoutExercise workoutExercise, int exerciseIndex) {
    final weightController = TextEditingController(
      text: workoutExercise.targetWeight.toInt().toString(),
    );
    final repsController = TextEditingController(
      text: workoutExercise.targetReps.toString(),
    );
    final rpeController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Set'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: weightController,
              decoration: const InputDecoration(
                labelText: 'Weight (lbs)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: repsController,
              decoration: const InputDecoration(
                labelText: 'Reps',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: rpeController,
              decoration: const InputDecoration(
                labelText: 'RPE (1-10)',
                border: OutlineInputBorder(),
                hintText: 'Optional',
              ),
              keyboardType: TextInputType.number,
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
              final weight = double.tryParse(weightController.text) ?? 0;
              final reps = int.tryParse(repsController.text) ?? 0;
              final rpe = double.tryParse(rpeController.text);

              if (weight > 0 && reps > 0) {
                final newSet = WorkoutSet(
                  id: 'set_${DateTime.now().millisecondsSinceEpoch}',
                  workoutId: widget.workout.id,
                  exerciseId: workoutExercise.exercise.id,
                  setNumber: workoutExercise.completedSets.length + 1,
                  reps: reps,
                  weight: weight,
                  rpe: rpe,
                  isCompleted: false, // Start unchecked
                  completedAt: null, // No completion time until checked
                  createdAt: DateTime.now(),
                  updatedAt: DateTime.now(),
                );

                // Use the provider to add the set properly to the database
                ref.read(workoutSessionProvider.notifier).addSet(exerciseIndex, newSet);

                Navigator.of(context).pop();
              }
            },
            child: const Text('Add Set'),
          ),
        ],
      ),
    );
  }

  void _showCancelWorkoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Workout'),
        content: const Text('Are you sure you wish to cancel this workout? No data will be saved.'),
        actions: [
          TextButton(
            onPressed: () {
              _saveWorkout();
            },
            child: const Text('No'),
          ),
          FilledButton(
            onPressed: () {
              _deleteWorkout();
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  void _deleteWorkout() async {
    try {
      final workoutRepository = ref.read(workoutRepositoryProvider);
      
      bool shouldDelete = false;
      String message = 'Session ended - workout data preserved';
      
      if (widget.isQuickStart) {
        // For quick start workouts, always delete unless it was an existing active workout
        shouldDelete = true;
        message = 'Workout cancelled - no data saved';
      } else {
        // This is an existing active workout - never delete
        shouldDelete = false;
        message = 'Session ended - workout data preserved';
      }
      
      if (shouldDelete) {
        await workoutRepository.deleteWorkout(widget.workout.id);
      }
      
      // Stop timers
      _workoutTimer?.cancel();
      _restTimer?.cancel();
      
      // Clear the session
      ref.read(workoutSessionProvider.notifier).endSession();
      
      // Close dialog and return to workouts screen
      Navigator.of(context).pop(); // Close dialog
      Navigator.of(context).pop(); // Return to workouts screen
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } catch (e) {
      // If deletion fails, still close the screen but show error
      Navigator.of(context).pop(); // Close dialog
      Navigator.of(context).pop(); // Return to workouts screen
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error ending workout session: $e'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    }
  }

  void _saveWorkout() async {
    try {
      // Save the current workout with any existing data
      final sessionData = ref.read(workoutSessionProvider);
      if (sessionData != null) {
        // Calculate current stats
        final exercises = sessionData.exercises;
        int totalSets = exercises.fold(0, (sum, ex) => sum + ex.completedSets.length);
        int totalReps = exercises.fold(0, (sum, ex) => 
            sum + ex.completedSets.fold(0, (setSum, set) => setSum + set.reps));
        double totalVolume = exercises.fold(0.0, (sum, ex) => 
            sum + ex.completedSets.fold(0.0, (setSum, set) => setSum + set.volume));

        // Mark workout as completed with current progress
        final savedWorkout = sessionData.workout.copyWith(
          status: 'completed',
          completedAt: DateTime.now(),
          totalSets: totalSets,
          totalReps: totalReps,
          totalVolume: totalVolume,
          durationMinutes: _elapsedTime.inMinutes,
          updatedAt: DateTime.now(),
        );

        // Save to database
        final workoutRepository = ref.read(workoutRepositoryProvider);
        await workoutRepository.updateWorkout(savedWorkout);
      }
      
      // Stop timers
      _workoutTimer?.cancel();
      _restTimer?.cancel();
      
      // Clear the session
      ref.read(workoutSessionProvider.notifier).endSession();
      
      // Close dialog and return to workouts screen
      Navigator.of(context).pop(); // Close dialog
      Navigator.of(context).pop(); // Return to workouts screen
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Workout saved successfully!'),
        ),
      );
    } catch (e) {
      // If save fails, still close the screen but show error
      Navigator.of(context).pop(); // Close dialog
      Navigator.of(context).pop(); // Return to workouts screen
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error saving workout: $e'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    }
  }

  void _showPauseDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pause Workout'),
        content: const Text('Are you sure you want to pause this workout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              _workoutTimer?.cancel();
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: const Text('Pause'),
          ),
        ],
      ),
    );
  }

  void _showFinishDialog() {
    final sessionData = ref.read(workoutSessionProvider);
    final exercises = sessionData?.exercises ?? [];
    
    // Calculate workout stats
    int totalSets = exercises.fold(0, (sum, ex) => sum + ex.completedSets.length);
    int totalReps = exercises.fold(0, (sum, ex) => 
        sum + ex.completedSets.fold(0, (setSum, set) => setSum + set.reps));
    double totalVolume = exercises.fold(0.0, (sum, ex) => 
        sum + ex.completedSets.fold(0.0, (setSum, set) => setSum + set.volume));
    int completedSets = exercises.fold(0, (sum, ex) => 
        sum + ex.completedSets.where((set) => set.isCompleted).length);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Workout Complete!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Great workout! Here\'s your summary:',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            _buildSummaryRow('Duration', _formatElapsedTime(_elapsedTime)),
            _buildSummaryRow('Exercises', exercises.length.toString()),
            _buildSummaryRow('Total Sets', '$completedSets/$totalSets completed'),
            _buildSummaryRow('Total Reps', totalReps.toString()),
            _buildSummaryRow('Total Volume', '${totalVolume.toInt()} lbs'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Continue'),
          ),
          FilledButton(
            onPressed: () {
              _completeWorkout();
            },
            child: const Text('Finish & Save'),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          Text(value),
        ],
      ),
    );
  }

  void _completeWorkout() {
    _workoutTimer?.cancel();
    _restTimer?.cancel();
    
    // Complete the workout in the provider
    ref.read(workoutSessionProvider.notifier).completeWorkout();
    
    // Close dialogs and return to workouts screen
    Navigator.of(context).pop(); // Close dialog
    Navigator.of(context).pop(); // Return to workouts screen
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${widget.workout.name} completed!'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        action: SnackBarAction(
          label: 'View',
          textColor: Theme.of(context).colorScheme.onPrimary,
          onPressed: () {
            // TODO: Navigate to workout detail view
          },
        ),
      ),
    );
    
    // End the session
    ref.read(workoutSessionProvider.notifier).endSession();
  }

  String _formatElapsedTime(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    
    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    } else {
      return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    }
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds.remainder(60);
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}

