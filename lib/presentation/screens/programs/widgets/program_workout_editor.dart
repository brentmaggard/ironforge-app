import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../domain/entities/program.dart';
import '../../../../domain/entities/exercise.dart';
import '../../../../core/providers/database_providers.dart';
import '../../exercises/exercise_selection_screen.dart';

class ProgramWorkoutEditor extends ConsumerStatefulWidget {
  final Program program;
  final ValueChanged<Program> onProgramChanged;

  const ProgramWorkoutEditor({
    super.key,
    required this.program,
    required this.onProgramChanged,
  });

  @override
  ConsumerState<ProgramWorkoutEditor> createState() => _ProgramWorkoutEditorState();
}

class _ProgramWorkoutEditorState extends ConsumerState<ProgramWorkoutEditor> {
  late Map<String, ProgramWorkout> _workouts;

  @override
  void initState() {
    super.initState();
    _workouts = Map.from(widget.program.workouts);
  }

  void _updateProgram() {
    final updatedConfig = Map<String, dynamic>.from(widget.program.config);
    updatedConfig['workouts'] = _workouts.map(
      (key, workout) => MapEntry(key, workout.toMap()),
    );
    
    final updatedProgram = widget.program.copyWith(
      config: updatedConfig,
      updatedAt: DateTime.now(),
    );
    
    widget.onProgramChanged(updatedProgram);
  }

  void _addWorkout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Workout'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Choose a workout name:'),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                hintText: 'e.g., Workout B, Push Day, etc.',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (name) {
                if (name.trim().isNotEmpty && !_workouts.containsKey(name.trim())) {
                  _addNewWorkout(name.trim());
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _addNewWorkout(String name) {
    setState(() {
      _workouts[name] = ProgramWorkout(
        name: name,
        exercises: [],
      );
    });
    _updateProgram();
  }

  void _removeWorkout(String workoutKey) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove Workout'),
        content: Text('Are you sure you want to remove "${_workouts[workoutKey]?.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _workouts.remove(workoutKey);
              });
              _updateProgram();
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Remove'),
          ),
        ],
      ),
    );
  }

  void _editWorkoutName(String workoutKey) {
    final currentWorkout = _workouts[workoutKey]!;
    final controller = TextEditingController(text: currentWorkout.name);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Workout Name'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final newName = controller.text.trim();
              if (newName.isNotEmpty) {
                setState(() {
                  _workouts[workoutKey] = ProgramWorkout(
                    name: newName,
                    exercises: currentWorkout.exercises,
                  );
                });
                _updateProgram();
              }
              Navigator.of(context).pop();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _addExerciseToWorkout(String workoutKey) async {
    final selectedExercise = await Navigator.of(context).push<Exercise>(
      MaterialPageRoute(
        builder: (context) => const ExerciseSelectionScreen(),
      ),
    );

    if (selectedExercise != null) {
      setState(() {
        final currentWorkout = _workouts[workoutKey]!;
        final newExercise = ProgramExercise(
          exerciseId: selectedExercise.exerciseId,
          sets: [
            const ProgramSet(reps: 5, weight: 0, type: 'normal'),
            const ProgramSet(reps: 5, weight: 0, type: 'normal'),
            const ProgramSet(reps: 5, weight: 0, type: 'normal'),
          ],
          restTime: 180,
        );
        
        _workouts[workoutKey] = ProgramWorkout(
          name: currentWorkout.name,
          exercises: [...currentWorkout.exercises, newExercise],
        );
      });
      _updateProgram();
    }
  }

  void _removeExerciseFromWorkout(String workoutKey, int exerciseIndex) {
    setState(() {
      final currentWorkout = _workouts[workoutKey]!;
      final updatedExercises = List<ProgramExercise>.from(currentWorkout.exercises);
      updatedExercises.removeAt(exerciseIndex);
      
      _workouts[workoutKey] = ProgramWorkout(
        name: currentWorkout.name,
        exercises: updatedExercises,
      );
    });
    _updateProgram();
  }

  void _editExercise(String workoutKey, int exerciseIndex) {
    final exercise = _workouts[workoutKey]!.exercises[exerciseIndex];
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) => ExerciseEditSheet(
          exercise: exercise,
          onSave: (updatedExercise) {
            setState(() {
              final currentWorkout = _workouts[workoutKey]!;
              final updatedExercises = List<ProgramExercise>.from(currentWorkout.exercises);
              updatedExercises[exerciseIndex] = updatedExercise;
              
              _workouts[workoutKey] = ProgramWorkout(
                name: currentWorkout.name,
                exercises: updatedExercises,
              );
            });
            _updateProgram();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header with add workout button
        Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              const Text(
                'Workouts',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              ElevatedButton.icon(
                onPressed: _addWorkout,
                icon: const Icon(Icons.add),
                label: const Text('Add Workout'),
              ),
            ],
          ),
        ),
        
        // Workouts list
        Expanded(
          child: _workouts.isEmpty
              ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.fitness_center, size: 64, color: Colors.grey),
                      SizedBox(height: 16),
                      Text(
                        'No workouts yet',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Add your first workout to get started',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: _workouts.length,
                  itemBuilder: (context, index) {
                    final workoutKey = _workouts.keys.elementAt(index);
                    final workout = _workouts[workoutKey]!;
                    
                    return WorkoutCard(
                      workoutKey: workoutKey,
                      workout: workout,
                      onEditName: () => _editWorkoutName(workoutKey),
                      onRemove: () => _removeWorkout(workoutKey),
                      onAddExercise: () => _addExerciseToWorkout(workoutKey),
                      onRemoveExercise: (exerciseIndex) => _removeExerciseFromWorkout(workoutKey, exerciseIndex),
                      onEditExercise: (exerciseIndex) => _editExercise(workoutKey, exerciseIndex),
                    );
                  },
                ),
        ),
      ],
    );
  }
}

class WorkoutCard extends ConsumerWidget {
  final String workoutKey;
  final ProgramWorkout workout;
  final VoidCallback onEditName;
  final VoidCallback onRemove;
  final VoidCallback onAddExercise;
  final ValueChanged<int> onRemoveExercise;
  final ValueChanged<int> onEditExercise;

  const WorkoutCard({
    super.key,
    required this.workoutKey,
    required this.workout,
    required this.onEditName,
    required this.onRemove,
    required this.onAddExercise,
    required this.onRemoveExercise,
    required this.onEditExercise,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ExpansionTile(
        title: Text(
          workout.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('${workout.exercises.length} exercises'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: onEditName,
              icon: const Icon(Icons.edit, size: 20),
            ),
            IconButton(
              onPressed: onRemove,
              icon: const Icon(Icons.delete, size: 20, color: Colors.red),
            ),
            const Icon(Icons.expand_more),
          ],
        ),
        children: [
          if (workout.exercises.isEmpty)
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'No exercises in this workout',
                style: TextStyle(color: Colors.grey),
              ),
            )
          else
            ...workout.exercises.asMap().entries.map((entry) {
              final index = entry.key;
              final exercise = entry.value;
              
              return ExerciseListItem(
                exercise: exercise,
                onEdit: () => onEditExercise(index),
                onRemove: () => onRemoveExercise(index),
              );
            }),
          
          // Add exercise button
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: onAddExercise,
                icon: const Icon(Icons.add),
                label: const Text('Add Exercise'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ExerciseListItem extends ConsumerWidget {
  final ProgramExercise exercise;
  final VoidCallback onEdit;
  final VoidCallback onRemove;

  const ExerciseListItem({
    super.key,
    required this.exercise,
    required this.onEdit,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get exercise details
    final exerciseAsync = ref.watch(exerciseByExerciseIdProvider(exercise.exerciseId));
    
    return exerciseAsync.when(
      data: (exerciseEntity) {
        final exerciseName = exerciseEntity?.name ?? 'Unknown Exercise';
        
        return ListTile(
          leading: const Icon(Icons.fitness_center),
          title: Text(exerciseName),
          subtitle: Text('${exercise.sets.length} sets'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: onEdit,
                icon: const Icon(Icons.edit, size: 20),
              ),
              IconButton(
                onPressed: onRemove,
                icon: const Icon(Icons.delete, size: 20, color: Colors.red),
              ),
            ],
          ),
        );
      },
      loading: () => const ListTile(
        leading: CircularProgressIndicator(),
        title: Text('Loading...'),
      ),
      error: (error, stack) => ListTile(
        leading: const Icon(Icons.error),
        title: Text('Exercise ${exercise.exerciseId}'),
        subtitle: const Text('Error loading exercise'),
      ),
    );
  }
}

// Provider reference from program_detail_screen.dart
final exerciseByExerciseIdProvider = FutureProvider.family<Exercise?, String>((ref, exerciseId) async {
  final exerciseRepository = ref.watch(exerciseRepositoryProvider);
  return await exerciseRepository.getExerciseByExerciseId(exerciseId);
});

class ExerciseEditSheet extends StatefulWidget {
  final ProgramExercise exercise;
  final ValueChanged<ProgramExercise> onSave;

  const ExerciseEditSheet({
    super.key,
    required this.exercise,
    required this.onSave,
  });

  @override
  State<ExerciseEditSheet> createState() => _ExerciseEditSheetState();
}

class _ExerciseEditSheetState extends State<ExerciseEditSheet> {
  late List<ProgramSet> _sets;
  late int _restTime;
  late String _notes;

  @override
  void initState() {
    super.initState();
    _sets = List.from(widget.exercise.sets);
    _restTime = widget.exercise.restTime ?? 180;
    _notes = widget.exercise.notes ?? '';
  }

  void _addSet() {
    setState(() {
      _sets.add(const ProgramSet(reps: 5, weight: 0, type: 'normal'));
    });
  }

  void _removeSet(int index) {
    if (_sets.length > 1) {
      setState(() {
        _sets.removeAt(index);
      });
    }
  }

  void _updateSet(int index, ProgramSet newSet) {
    setState(() {
      _sets[index] = newSet;
    });
  }

  void _save() {
    final updatedExercise = ProgramExercise(
      exerciseId: widget.exercise.exerciseId,
      sets: _sets,
      restTime: _restTime,
      notes: _notes.isEmpty ? null : _notes,
      progression: widget.exercise.progression,
    );
    
    widget.onSave(updatedExercise);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              const Text(
                'Edit Exercise',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: _save,
                child: const Text('Save'),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Rest time
          Row(
            children: [
              const Text('Rest Time: '),
              DropdownButton<int>(
                value: _restTime,
                items: [60, 90, 120, 150, 180, 240, 300]
                    .map((seconds) => DropdownMenuItem(
                          value: seconds,
                          child: Text('${(seconds / 60).toStringAsFixed(1)} min'),
                        ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _restTime = value;
                    });
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Sets
          const Text(
            'Sets',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          
          Expanded(
            child: ListView.builder(
              itemCount: _sets.length,
              itemBuilder: (context, index) {
                final set = _sets[index];
                return SetEditTile(
                  set: set,
                  index: index + 1,
                  onChanged: (newSet) => _updateSet(index, newSet),
                  onRemove: _sets.length > 1 ? () => _removeSet(index) : null,
                );
              },
            ),
          ),
          
          // Add set button
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: _addSet,
              icon: const Icon(Icons.add),
              label: const Text('Add Set'),
            ),
          ),
          
          const SizedBox(height: 16),

          // Notes
          TextField(
            decoration: const InputDecoration(
              labelText: 'Notes',
              hintText: 'Optional exercise notes',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
            onChanged: (value) {
              _notes = value;
            },
          ),
        ],
      ),
    );
  }
}

class SetEditTile extends StatefulWidget {
  final ProgramSet set;
  final int index;
  final ValueChanged<ProgramSet> onChanged;
  final VoidCallback? onRemove;

  const SetEditTile({
    super.key,
    required this.set,
    required this.index,
    required this.onChanged,
    this.onRemove,
  });

  @override
  State<SetEditTile> createState() => _SetEditTileState();
}

class _SetEditTileState extends State<SetEditTile> {
  late TextEditingController _repsController;
  late TextEditingController _weightController;
  late String _setType;

  @override
  void initState() {
    super.initState();
    _repsController = TextEditingController(text: widget.set.reps.toString());
    _weightController = TextEditingController(text: widget.set.weight.toString());
    _setType = widget.set.type;
  }

  @override
  void dispose() {
    _repsController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  void _updateSet() {
    final reps = _setType == 'amrap' 
        ? '${_repsController.text}+'
        : _repsController.text;
    
    final newSet = ProgramSet(
      reps: reps,
      weight: double.tryParse(_weightController.text) ?? 0,
      type: _setType,
    );
    
    widget.onChanged(newSet);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Text('${widget.index}.'),
            const SizedBox(width: 12),
            
            // Reps
            SizedBox(
              width: 60,
              child: TextField(
                controller: _repsController,
                decoration: const InputDecoration(
                  labelText: 'Reps',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                ),
                keyboardType: TextInputType.number,
                onChanged: (_) => _updateSet(),
              ),
            ),
            const SizedBox(width: 8),
            
            // Weight
            SizedBox(
              width: 80,
              child: TextField(
                controller: _weightController,
                decoration: const InputDecoration(
                  labelText: 'Weight',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                ),
                keyboardType: TextInputType.number,
                onChanged: (_) => _updateSet(),
              ),
            ),
            const SizedBox(width: 8),
            
            // Type
            DropdownButton<String>(
              value: _setType,
              items: const [
                DropdownMenuItem(value: 'normal', child: Text('Normal')),
                DropdownMenuItem(value: 'amrap', child: Text('AMRAP')),
                DropdownMenuItem(value: 'warmup', child: Text('Warmup')),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _setType = value;
                  });
                  _updateSet();
                }
              },
            ),
            
            const Spacer(),
            
            // Remove button
            if (widget.onRemove != null)
              IconButton(
                onPressed: widget.onRemove,
                icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}