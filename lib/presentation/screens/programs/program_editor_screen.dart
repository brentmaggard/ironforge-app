import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../domain/entities/program.dart';
import '../../../domain/entities/exercise.dart';
import '../../../core/providers/database_providers.dart';
import 'program_detail_screen.dart';
import 'widgets/program_basic_info_editor.dart';
import 'widgets/program_workout_editor.dart';
import 'widgets/program_schedule_editor.dart';

class ProgramEditorScreen extends ConsumerStatefulWidget {
  final Program? program; // null for creating new program
  final bool isCreateMode;

  const ProgramEditorScreen({
    super.key,
    this.program,
    this.isCreateMode = false,
  });

  @override
  ConsumerState<ProgramEditorScreen> createState() => _ProgramEditorScreenState();
}

class _ProgramEditorScreenState extends ConsumerState<ProgramEditorScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late Program _editingProgram;
  bool _hasUnsavedChanges = false;
  final _uuid = const Uuid();

  // Form controllers
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _authorController;
  late String _selectedDifficulty;
  late int _frequency;
  late int _durationWeeks;
  late List<String> _tags;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    
    // Initialize editing program
    if (widget.program != null) {
      _editingProgram = widget.program!.copyWith();
    } else {
      // Create new program template
      _editingProgram = _createEmptyProgram();
    }
    
    // Initialize form controllers
    _initializeControllers();
  }

  Program _createEmptyProgram() {
    return Program(
      id: _uuid.v4(),
      name: 'New Program',
      description: 'A custom workout program',
      author: 'Custom',
      difficulty: 'beginner',
      frequency: 3,
      durationWeeks: 12,
      tags: ['custom'],
      config: {
        'workouts': {
          'A': {
            'name': 'Workout A',
            'exercises': [],
          },
        },
        'schedule': ['A', 'rest', 'A', 'rest', 'A', 'rest', 'rest'],
        'progressionRules': {
          'failureThreshold': 3,
          'deloadPercentage': 10,
          'successCriteria': 'complete_all_sets',
        },
      },
      isTemplate: false,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  void _initializeControllers() {
    _nameController = TextEditingController(text: _editingProgram.name);
    _descriptionController = TextEditingController(text: _editingProgram.description ?? '');
    _authorController = TextEditingController(text: _editingProgram.author ?? '');
    _selectedDifficulty = _editingProgram.difficulty;
    _frequency = _editingProgram.frequency ?? 3;
    _durationWeeks = _editingProgram.durationWeeks ?? 12;
    _tags = List<String>.from(_editingProgram.tags ?? []);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _nameController.dispose();
    _descriptionController.dispose();
    _authorController.dispose();
    super.dispose();
  }

  void _markAsChanged() {
    if (!_hasUnsavedChanges) {
      setState(() {
        _hasUnsavedChanges = true;
      });
    }
  }

  void _updateProgram(Program updatedProgram) {
    setState(() {
      _editingProgram = updatedProgram;
      _hasUnsavedChanges = true;
    });
  }

  Future<bool> _saveProgram() async {
    try {
      final updatedProgram = _editingProgram.copyWith(
        name: _nameController.text.trim(),
        description: _descriptionController.text.trim().isEmpty 
            ? null 
            : _descriptionController.text.trim(),
        author: _authorController.text.trim().isEmpty 
            ? null 
            : _authorController.text.trim(),
        difficulty: _selectedDifficulty,
        frequency: _frequency,
        durationWeeks: _durationWeeks,
        tags: _tags,
        updatedAt: DateTime.now(),
      );

      final programRepository = ref.read(programRepositoryProvider);
      
      if (widget.isCreateMode) {
        await programRepository.createProgram(updatedProgram);
      } else {
        await programRepository.updateProgram(updatedProgram);
      }

      setState(() {
        _editingProgram = updatedProgram;
        _hasUnsavedChanges = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(widget.isCreateMode ? 'Program created!' : 'Program saved!'),
            backgroundColor: Colors.green,
          ),
        );
      }

      return true;
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to save program: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
      return false;
    }
  }

  Future<bool> _onWillPop() async {
    if (!_hasUnsavedChanges) return true;

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Unsaved Changes'),
        content: const Text('You have unsaved changes. Do you want to discard them?'),
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

    return result ?? false;
  }

  void _previewProgram() {
    final previewProgram = _editingProgram.copyWith(
      name: _nameController.text.trim(),
      description: _descriptionController.text.trim().isEmpty 
          ? null 
          : _descriptionController.text.trim(),
      author: _authorController.text.trim().isEmpty 
          ? null 
          : _authorController.text.trim(),
      difficulty: _selectedDifficulty,
      frequency: _frequency,
      durationWeeks: _durationWeeks,
      tags: _tags,
    );

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ProgramDetailScreen(program: previewProgram),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !_hasUnsavedChanges,
      onPopInvoked: (didPop) async {
        if (!didPop) {
          final shouldPop = await _onWillPop();
          if (shouldPop && mounted) {
            Navigator.of(context).pop();
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.isCreateMode ? 'Create Program' : 'Edit Program'),
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(icon: Icon(Icons.info), text: 'Info'),
              Tab(icon: Icon(Icons.fitness_center), text: 'Workouts'),
              Tab(icon: Icon(Icons.calendar_view_week), text: 'Schedule'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: _previewProgram,
              child: const Text('Preview'),
            ),
            IconButton(
              onPressed: _hasUnsavedChanges ? _saveProgram : null,
              icon: Icon(
                Icons.save,
                color: _hasUnsavedChanges ? Colors.blue : Colors.grey,
              ),
            ),
          ],
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            // Basic Info Tab
            ProgramBasicInfoEditor(
              nameController: _nameController,
              descriptionController: _descriptionController,
              authorController: _authorController,
              selectedDifficulty: _selectedDifficulty,
              frequency: _frequency,
              durationWeeks: _durationWeeks,
              tags: _tags,
              onChanged: _markAsChanged,
              onDifficultyChanged: (difficulty) {
                setState(() {
                  _selectedDifficulty = difficulty;
                });
                _markAsChanged();
              },
              onFrequencyChanged: (frequency) {
                setState(() {
                  _frequency = frequency;
                });
                _markAsChanged();
              },
              onDurationChanged: (weeks) {
                setState(() {
                  _durationWeeks = weeks;
                });
                _markAsChanged();
              },
              onTagsChanged: (tags) {
                setState(() {
                  _tags = tags;
                });
                _markAsChanged();
              },
            ),
            
            // Workouts Tab
            ProgramWorkoutEditor(
              program: _editingProgram,
              onProgramChanged: _updateProgram,
            ),
            
            // Schedule Tab
            ProgramScheduleEditor(
              program: _editingProgram,
              onProgramChanged: _updateProgram,
            ),
          ],
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () async {
                    final shouldPop = await _onWillPop();
                    if (shouldPop && mounted) {
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('Cancel'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () async {
                    final saved = await _saveProgram();
                    if (saved && mounted) {
                      Navigator.of(context).pop(true); // Return true to indicate success
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _hasUnsavedChanges ? Colors.blue : Colors.grey,
                  ),
                  child: Text(widget.isCreateMode ? 'Create' : 'Save'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}