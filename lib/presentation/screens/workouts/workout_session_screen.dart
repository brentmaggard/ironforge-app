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
      final sessionData = ref.read(workoutSessionProvider);
      
      // Check if exercise already exists in the workout
      final existingExerciseIndex = sessionData?.exercises.indexWhere(
        (workoutExercise) => workoutExercise.exercise.id == selectedExercise.id
      ) ?? -1;
      
      if (existingExerciseIndex != -1) {
        // Exercise already exists, add a new set to it
        _showAddSetDialog(
          sessionData!.exercises[existingExerciseIndex], 
          existingExerciseIndex
        );
      } else {
        // New exercise, add it to the workout
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
  }

  void _addSpecialSet() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Special Set'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Special set types (drop sets, super sets, etc.) will be available in a future update.'),
          ],
        ),
        actions: [
          FilledButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
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
        leading: IconButton.outlined(
          icon: const Icon(Icons.close, color: Colors.red),
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
          Consumer(
            builder: (context, ref, _) {
              final sessionData = ref.watch(workoutSessionProvider);
              final isPaused = sessionData?.isPaused ?? false;
              return IconButton.filledTonal(
                icon: Icon(isPaused ? Icons.play_arrow : Icons.pause),
                onPressed: _showPauseDialog,
                tooltip: isPaused ? 'Resume workout' : 'Pause workout',
              );
            },
          ),
          IconButton.filledTonal(
            icon: const Icon(Icons.settings),
            onPressed: _showWorkoutSettings,
            tooltip: 'Workout settings',
          ),
          IconButton.outlined(
            icon: const Icon(Icons.check, color: Colors.green),
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
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: _addExercise,
                icon: const Icon(Icons.add),
                label: const Text('Exercise'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: _addSpecialSet,
                icon: const Icon(Icons.add),
                label: const Text('Special Set'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ],
        ),
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
      key: ValueKey('exercise_$exerciseIndex'),
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
                  child: Text(
                    workoutExercise.exercise.name,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
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
              // Warm-up sets section
              if (workoutExercise.completedSets.any((set) => set.isWarmUp)) ...[
                Row(
                  children: [
                    const Text(
                      'Warm-up Sets',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => _showAddWarmUpSetDialog(workoutExercise, exerciseIndex),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Theme.of(context).colorScheme.outline),
                              ),
                              child: Icon(
                                Icons.add,
                                size: 12,
                                color: Theme.of(context).colorScheme.outline,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Warm-up',
                              style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(context).colorScheme.outline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                
                // Warm-up sets
                ...workoutExercise.completedSets.asMap().entries.where((entry) => entry.value.isWarmUp).map((entry) {
                  int setIndex = entry.key;
                  WorkoutSet set = entry.value;
                  int warmUpNumber = workoutExercise.completedSets.where((s) => s.isWarmUp).toList().indexOf(set) + 1;
                  return _buildSetRow(set, warmUpNumber, workoutExercise, exerciseIndex, setIndex, true, isWarmUp: true);
                }),
                
                const SizedBox(height: 16),
              ] else ...[
                // Add warm-up sets button when no warm-up sets exist
                GestureDetector(
                  onTap: () => _showAddWarmUpSetDialog(workoutExercise, exerciseIndex),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Theme.of(context).colorScheme.outline),
                          ),
                          child: Icon(
                            Icons.add,
                            size: 12,
                            color: Theme.of(context).colorScheme.outline,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Add Warm-up Sets',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.outline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
              ],
              
              // Working sets header
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
              
              // Working sets
              ...workoutExercise.completedSets.asMap().entries.where((entry) => !entry.value.isWarmUp).map((entry) {
                int setIndex = entry.key;
                WorkoutSet set = entry.value;
                int workingSetNumber = workoutExercise.completedSets.where((s) => !s.isWarmUp).toList().indexOf(set) + 1;
                return _buildSetRow(set, workingSetNumber, workoutExercise, exerciseIndex, setIndex, true);
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
    bool isCompleted, {
    bool isWarmUp = false,
  }) {
    final isEditing = _editingSetId == set.id;
    
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4),
      margin: const EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        color: set.isCompleted 
            ? Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.3)
            : null,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          // Set number with completion state
          SizedBox(
            width: 32,
            child: GestureDetector(
              onTap: () => _toggleSetCompletion(exerciseIndex, setIndex),
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: set.isCompleted 
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.outline,
                    width: 2,
                  ),
                  color: set.isCompleted 
                      ? Theme.of(context).colorScheme.primary
                      : Colors.transparent,
                ),
                child: Center(
                  child: set.isCompleted
                      ? Icon(
                          Icons.check,
                          size: 18,
                          color: Theme.of(context).colorScheme.onPrimary,
                        )
                      : Text(
                          isWarmUp ? 'W$setNumber' : setNumber.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: isWarmUp ? 12 : 14,
                            color: isWarmUp 
                                ? Theme.of(context).colorScheme.secondary
                                : Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 6),
          
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
              'reps',
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
            width: 36,
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
        height: 28,
        child: TextField(
          controller: _editController,
          autofocus: true,
          keyboardType: field == 'rpe' ? const TextInputType.numberWithOptions(decimal: true) : TextInputType.number,
          style: const TextStyle(fontSize: 14),
          decoration: const InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            border: OutlineInputBorder(),
          ),
          onSubmitted: (_) => _saveEdit(),
        ),
      );
    }
    
    return GestureDetector(
      onTap: () => _startEditingField(setId, exerciseIndex, field, value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.transparent),
          borderRadius: BorderRadius.circular(4),
        ),
        child: value.isEmpty 
            ? Text(
                '-',
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              )
            : suffix.isNotEmpty
                ? RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: [
                        TextSpan(
                          text: value,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        TextSpan(
                          text: ' $suffix',
                          style: TextStyle(
                            fontSize: 11,
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  )
                : Text(
                    value,
                    style: const TextStyle(fontSize: 14),
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

  void _showAddWarmUpSetDialog(WorkoutExercise workoutExercise, int exerciseIndex) {
    final weightController = TextEditingController();
    final repsController = TextEditingController();
    final rpeController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Warm-up Set'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: weightController,
              decoration: const InputDecoration(
                labelText: 'Weight (lbs)',
                border: OutlineInputBorder(),
                hintText: 'Lighter weight for warm-up',
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
                  isWarmUp: true, // Mark as warm-up set
                  isCompleted: false,
                  completedAt: null,
                  createdAt: DateTime.now(),
                  updatedAt: DateTime.now(),
                );

                ref.read(workoutSessionProvider.notifier).addSet(exerciseIndex, newSet);
                Navigator.of(context).pop();
              }
            },
            child: const Text('Add Warm-up Set'),
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
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('No'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog first
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
      
      // Check if widget is still mounted before navigation
      if (!mounted) return;
      
      // Navigate back to workouts screen
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop(); // Return to workouts screen
      }
      
      // Show success message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      }
    } catch (e) {
      // Stop timers even on error
      _workoutTimer?.cancel();
      _restTimer?.cancel();
      ref.read(workoutSessionProvider.notifier).endSession();
      
      // Check if widget is still mounted before navigation
      if (!mounted) return;
      
      // Navigate back on error
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop(); // Return to workouts screen
      }
      
      // Show error message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error ending workout session: $e'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }


  void _showWorkoutSettings() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Workout Settings'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Workout settings will be available in a future update.'),
          ],
        ),
        actions: [
          FilledButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showPauseDialog() {
    final sessionData = ref.read(workoutSessionProvider);
    if (sessionData == null) return;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(sessionData.isPaused ? 'Resume Workout' : 'Pause Workout'),
        content: Text(sessionData.isPaused 
          ? 'Resume your workout?' 
          : 'Pause your workout? You can resume it later.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              if (sessionData.isPaused) {
                ref.read(workoutSessionProvider.notifier).resumeWorkout();
                _startWorkoutTimer();
              } else {
                ref.read(workoutSessionProvider.notifier).pauseWorkout();
                _workoutTimer?.cancel();
              }
              Navigator.of(context).pop();
            },
            child: Text(sessionData.isPaused ? 'Resume' : 'Pause'),
          ),
        ],
      ),
    );
  }

  void _showFinishDialog() {
    final sessionData = ref.read(workoutSessionProvider);
    final exercises = sessionData?.exercises ?? [];
    
    // Check for incomplete sets
    List<WorkoutSet> incompleteSets = [];
    for (var exercise in exercises) {
      for (var set in exercise.completedSets) {
        if (!set.isCompleted) {
          incompleteSets.add(set);
        }
      }
    }
    
    // If there are incomplete sets, show options dialog first
    if (incompleteSets.isNotEmpty) {
      _showIncompleteSetsDialog(incompleteSets);
      return;
    }
    
    // All sets complete, show normal finish dialog
    _showWorkoutSummaryDialog();
  }

  void _showIncompleteSetsDialog(List<WorkoutSet> incompleteSets) {
    final int incompleteCount = incompleteSets.length;
    final int warmupCount = incompleteSets.where((set) => set.isWarmUp).length;
    final int workingCount = incompleteCount - warmupCount;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Incomplete Sets'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'You have $incompleteCount sets not marked as done:',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 12),
            if (warmupCount > 0)
              Text('• $warmupCount warm-up sets'),
            if (workingCount > 0)
              Text('• $workingCount working sets'),
            const SizedBox(height: 16),
            Text(
              'What would you like to do?',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton.tonal(
            onPressed: () {
              Navigator.of(context).pop();
              _markAllSetsComplete(incompleteSets);
              _showWorkoutSummaryDialog();
            },
            child: const Text('Mark as Done'),
          ),
          FilledButton.tonal(
            onPressed: () {
              Navigator.of(context).pop();
              _deleteIncompleteSets(incompleteSets);
              _showWorkoutSummaryDialog();
            },
            child: const Text('Delete Sets'),
          ),
        ],
      ),
    );
  }

  void _showWorkoutSummaryDialog() {
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
              Navigator.of(context).pop(); // Close dialog first
              _completeWorkout();
            },
            child: const Text('Finish & Save'),
          ),
        ],
      ),
    );
  }

  void _markAllSetsComplete(List<WorkoutSet> incompleteSets) {
    final sessionData = ref.read(workoutSessionProvider);
    if (sessionData == null) return;
    
    // Find and update each incomplete set
    for (var incompleteSet in incompleteSets) {
      // Find the exercise and set index for this incomplete set
      for (int exerciseIndex = 0; exerciseIndex < sessionData.exercises.length; exerciseIndex++) {
        final exercise = sessionData.exercises[exerciseIndex];
        for (int setIndex = 0; setIndex < exercise.completedSets.length; setIndex++) {
          final set = exercise.completedSets[setIndex];
          if (set.id == incompleteSet.id) {
            // Mark this set as completed
            final completedSet = set.copyWith(
              isCompleted: true,
              completedAt: DateTime.now(),
            );
            ref.read(workoutSessionProvider.notifier).updateSet(
              exerciseIndex,
              setIndex,
              completedSet,
            );
            break;
          }
        }
      }
    }
  }

  void _deleteIncompleteSets(List<WorkoutSet> incompleteSets) {
    final sessionData = ref.read(workoutSessionProvider);
    if (sessionData == null) return;
    
    // Remove incomplete sets from back to front to avoid index issues
    for (var incompleteSet in incompleteSets) {
      // Find and remove each incomplete set
      for (int exerciseIndex = 0; exerciseIndex < sessionData.exercises.length; exerciseIndex++) {
        final exercise = sessionData.exercises[exerciseIndex];
        for (int setIndex = exercise.completedSets.length - 1; setIndex >= 0; setIndex--) {
          final set = exercise.completedSets[setIndex];
          if (set.id == incompleteSet.id) {
            // Remove this set
            ref.read(workoutSessionProvider.notifier).removeSet(exerciseIndex, setIndex);
            break;
          }
        }
      }
    }
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

  void _completeWorkout() async {
    try {
      _workoutTimer?.cancel();
      _restTimer?.cancel();
      
      // Complete the workout in the provider
      await ref.read(workoutSessionProvider.notifier).completeWorkout();
      
      // Check if widget is still mounted before navigation
      if (!mounted) return;
      
      // Navigate back to workouts screen
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop(); // Return to workouts screen
      }
      
      // Show success message
      if (mounted) {
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
      }
      
      // End the session
      ref.read(workoutSessionProvider.notifier).endSession();
    } catch (e) {
      // Stop timers even on error
      _workoutTimer?.cancel();
      _restTimer?.cancel();
      ref.read(workoutSessionProvider.notifier).endSession();
      
      // Check if widget is still mounted before navigation
      if (!mounted) return;
      
      // Navigate back on error
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop(); // Return to workouts screen
      }
      
      // Show error message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error completing workout: $e'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
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

