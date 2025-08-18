import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import '../../../domain/entities/workout_session.dart';
import 'widgets/top_action_bar.dart';
import 'widgets/exercise_card.dart';
import 'widgets/weight_reps_bottom_sheet.dart';
import 'providers/workout_session_service_provider.dart';

class NewWorkoutSessionScreen extends ConsumerStatefulWidget {
  final WorkoutSession initialSession;
  final String? workoutId; // Existing workout ID if loading from database

  const NewWorkoutSessionScreen({
    super.key,
    required this.initialSession,
    this.workoutId,
  });

  @override
  ConsumerState<NewWorkoutSessionScreen> createState() => _NewWorkoutSessionScreenState();
}

class _NewWorkoutSessionScreenState extends ConsumerState<NewWorkoutSessionScreen>
    with WidgetsBindingObserver {
  late WorkoutSession _session;
  String? _workoutId; // Database workout ID
  Timer? _timer;
  DateTime? _lastTick;
  int _pausedDuration = 0; // Track total paused time in milliseconds

  // Bottom sheet state
  bool _showBottomSheet = false;
  String? _editingSetId;
  String _editingField = 'weight'; // 'weight' or 'reps'
  String _bottomSheetValue = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _session = widget.initialSession;
    _workoutId = widget.workoutId;
    _startTimer();
    _initializeWorkout();
  }

  /// Initializes workout in database if new session
  Future<void> _initializeWorkout() async {
    if (_workoutId == null) {
      // New workout session - create in database
      final service = ref.read(workoutSessionServiceProvider);
      try {
        // TODO: Get actual user ID from auth system
        const userId = 'demo-user-id';
        _workoutId = await service.createWorkoutSession(_session, userId);
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to save workout: $e')),
          );
        }
      }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _timer?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
        _saveSession();
        break;
      case AppLifecycleState.resumed:
        if (!_session.isPaused) {
          _startTimer();
        }
        break;
      default:
        break;
    }
  }

  void _startTimer() {
    if (_session.isPaused) return;
    
    _lastTick = DateTime.now();
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!_session.isPaused) {
        final now = DateTime.now();
        final elapsed = now.difference(_session.startedAt).inMilliseconds - _pausedDuration;
        setState(() {
          _session = _session.copyWith(elapsedMs: elapsed);
        });
      }
    });
  }

  void _pauseTimer() {
    _timer?.cancel();
    _lastTick = DateTime.now();
    setState(() {
      _session = _session.copyWith(isPaused: true);
    });
    _saveSession();
  }

  void _resumeTimer() {
    if (_lastTick != null) {
      _pausedDuration += DateTime.now().difference(_lastTick!).inMilliseconds;
    }
    setState(() {
      _session = _session.copyWith(isPaused: false);
    });
    _startTimer();
    _saveSession();
  }

  void _togglePause() {
    if (_session.isPaused) {
      _resumeTimer();
    } else {
      _pauseTimer();
    }
  }

  void _saveSession() async {
    if (_workoutId == null) return;
    
    final service = ref.read(workoutSessionServiceProvider);
    try {
      await service.autoSaveSession(_session, _workoutId!);
    } catch (e) {
      // Silent fail for auto-save, but log error
      debugPrint('Auto-save failed: $e');
    }
  }

  void _closeSession() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Discard Workout?'),
        content: const Text('Are you sure you want to discard this workout? All progress will be lost.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Discard'),
          ),
        ],
      ),
    );

    if (result == true && mounted) {
      Navigator.of(context).pop();
    }
  }

  void _completeSession() async {
    if (_session.hasIncompleteSets) {
      final result = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Finish workout?'),
          content: const Text('Some sets are incomplete. You can finish now or go back to fill them in.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Go back'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Finish'),
            ),
          ],
        ),
      );

      if (result != true) return;
    }

    if (_workoutId == null) {
      if (mounted) {
        Navigator.of(context).pop();
      }
      return;
    }

    _timer?.cancel();
    
    final service = ref.read(workoutSessionServiceProvider);
    try {
      await service.completeWorkoutSession(_session, _workoutId!);
      
      if (mounted) {
        // Show completion message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Workout completed and saved!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.of(context).pop();
        // TODO: Navigate to workout summary screen with workoutId
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to complete workout: $e')),
        );
      }
    }
  }

  void _openSettings() {
    // TODO: Implement settings bottom sheet
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Settings coming soon')),
    );
  }

  void _openBottomSheet(String setId, String field) {
    // Find the set entry to get current value
    SetEntry? setEntry;
    for (final exercise in _session.exercises) {
      for (final set in [...exercise.warmups, ...exercise.sets]) {
        if (set.id == setId) {
          setEntry = set;
          break;
        }
      }
      if (setEntry != null) break;
    }

    if (setEntry == null) return;

    final currentValue = field == 'weight' 
        ? setEntry.weight?.toString() ?? ''
        : setEntry.reps?.toString() ?? '';

    setState(() {
      _showBottomSheet = true;
      _editingSetId = setId;
      _editingField = field;
      _bottomSheetValue = currentValue;
    });
  }

  void _closeBottomSheet() {
    setState(() {
      _showBottomSheet = false;
      _editingSetId = null;
      _bottomSheetValue = '';
    });
  }

  void _updateBottomSheetValue(String value) {
    setState(() {
      _bottomSheetValue = value;
    });
  }

  void _commitBottomSheetValue() {
    if (_editingSetId == null) return;

    final value = _bottomSheetValue.trim();
    if (value.isEmpty) {
      _closeBottomSheet();
      return;
    }

    // Validate and parse value
    final numericValue = _editingField == 'weight' 
        ? double.tryParse(value)
        : int.tryParse(value);

    if (numericValue == null || numericValue < 0) {
      // Show error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid $_editingField value')),
      );
      return;
    }

    // Update the session
    final updatedExercises = _session.exercises.map((exercise) {
      final updatedWarmups = exercise.warmups.map((set) {
        if (set.id == _editingSetId) {
          if (_editingField == 'weight') {
            return set.copyWith(weight: numericValue.toDouble());
          } else {
            return set.copyWith(reps: numericValue.toInt());
          }
        }
        return set;
      }).toList();

      final updatedSets = exercise.sets.map((set) {
        if (set.id == _editingSetId) {
          if (_editingField == 'weight') {
            return set.copyWith(weight: numericValue.toDouble());
          } else {
            return set.copyWith(reps: numericValue.toInt());
          }
        }
        return set;
      }).toList();

      return exercise.copyWith(
        warmups: updatedWarmups,
        sets: updatedSets,
      );
    }).toList();

    setState(() {
      _session = _session.copyWith(exercises: updatedExercises);
    });

    _saveSession();
    _closeBottomSheet();
  }

  void _toggleSessionUnit() {
    final newUnit = _session.unit == Unit.lb ? Unit.kg : Unit.lb;
    
    // Convert all weights in the session
    final convertedExercises = _session.exercises.map((exercise) {
      final convertedWarmups = exercise.warmups.map((set) {
        if (set.weight != null) {
          final convertedWeight = UnitConverter.convertWeight(
            set.weight!, 
            _session.unit, 
            newUnit
          );
          return set.copyWith(weight: convertedWeight);
        }
        return set;
      }).toList();

      final convertedSets = exercise.sets.map((set) {
        if (set.weight != null) {
          final convertedWeight = UnitConverter.convertWeight(
            set.weight!, 
            _session.unit, 
            newUnit
          );
          return set.copyWith(weight: convertedWeight);
        }
        return set;
      }).toList();

      return exercise.copyWith(
        warmups: convertedWarmups,
        sets: convertedSets,
      );
    }).toList();

    setState(() {
      _session = _session.copyWith(
        unit: newUnit,
        exercises: convertedExercises,
      );
    });

    _saveSession();
  }

  void _toggleWarmupCollapsed(String exerciseId) {
    final updatedExercises = _session.exercises.map((exercise) {
      if (exercise.id == exerciseId) {
        return exercise.copyWith(isWarmupCollapsed: !exercise.isWarmupCollapsed);
      }
      return exercise;
    }).toList();

    setState(() {
      _session = _session.copyWith(exercises: updatedExercises);
    });
  }

  void _addWarmupSet(String exerciseId) {
    final exerciseIndex = _session.exercises.indexWhere((e) => e.id == exerciseId);
    if (exerciseIndex == -1) return;

    final exercise = _session.exercises[exerciseIndex];
    final newOrder = exercise.warmups.length + 1;
    
    final newSet = SetEntry(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      kind: SetKind.warmup,
      order: newOrder,
    );

    final updatedWarmups = [...exercise.warmups, newSet];
    final updatedExercise = exercise.copyWith(warmups: updatedWarmups);
    
    final updatedExercises = [..._session.exercises];
    updatedExercises[exerciseIndex] = updatedExercise;

    setState(() {
      _session = _session.copyWith(exercises: updatedExercises);
    });

    _saveSession();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                TopActionBar(
                  title: _session.title,
                  elapsedFormatted: _session.elapsedFormatted,
                  isPaused: _session.isPaused,
                  onClose: _closeSession,
                  onPauseToggle: _togglePause,
                  onSettings: _openSettings,
                  onComplete: _completeSession,
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
                    itemCount: _session.exercises.length,
                    itemBuilder: (context, index) {
                      final exercise = _session.exercises[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: ExerciseCard(
                          exercise: exercise,
                          unit: _session.unit,
                          onEditSet: _openBottomSheet,
                          onToggleWarmup: () => _toggleWarmupCollapsed(exercise.id),
                          onAddWarmup: () => _addWarmupSet(exercise.id),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            if (_showBottomSheet)
              WeightRepsBottomSheet(
                field: _editingField,
                value: _bottomSheetValue,
                unit: _session.unit,
                onValueChanged: _updateBottomSheetValue,
                onUnitToggle: _toggleSessionUnit,
                onDone: _commitBottomSheetValue,
                onClose: _closeBottomSheet,
              ),
          ],
        ),
      ),
    );
  }
}