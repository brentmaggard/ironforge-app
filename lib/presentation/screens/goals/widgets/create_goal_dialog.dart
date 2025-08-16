import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../../domain/entities/goal.dart';
import '../../../../core/providers/database_providers.dart';

class CreateGoalDialog extends ConsumerStatefulWidget {
  const CreateGoalDialog({super.key});

  @override
  ConsumerState<CreateGoalDialog> createState() => _CreateGoalDialogState();
}

class _CreateGoalDialogState extends ConsumerState<CreateGoalDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _targetValueController = TextEditingController();
  final _currentValueController = TextEditingController(text: '0');
  
  String _selectedType = 'strength';
  String _selectedUnit = 'lbs';
  DateTime? _targetDate;
  bool _isLoading = false;

  final List<Map<String, String>> _goalTypes = [
    {'value': 'strength', 'label': 'Strength', 'icon': '💪'},
    {'value': 'weight', 'label': 'Weight Loss/Gain', 'icon': '⚖️'},
    {'value': 'endurance', 'label': 'Endurance', 'icon': '🏃'},
    {'value': 'flexibility', 'label': 'Flexibility', 'icon': '🤸'},
    {'value': 'body_composition', 'label': 'Body Composition', 'icon': '📊'},
    {'value': 'habit', 'label': 'Habit', 'icon': '✅'},
  ];

  final List<String> _units = [
    'lbs', 'kg', 'reps', 'minutes', 'hours', 'days', 'miles', 'km', '%', 'inches', 'cm'
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _targetValueController.dispose();
    _currentValueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Create New Goal'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Goal Type Selection
              DropdownButtonFormField<String>(
                initialValue: _selectedType,
                decoration: const InputDecoration(
                  labelText: 'Goal Type',
                  border: OutlineInputBorder(),
                ),
                items: _goalTypes.map((type) {
                  return DropdownMenuItem(
                    value: type['value']!,
                    child: Row(
                      children: [
                        Text(type['icon']!, style: const TextStyle(fontSize: 20)),
                        const SizedBox(width: 8),
                        Text(type['label']!),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (value) => setState(() => _selectedType = value!),
              ),
              
              const SizedBox(height: 16),
              
              // Title
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Goal Title',
                  border: OutlineInputBorder(),
                  hintText: 'e.g., Bench Press 200 lbs',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a goal title';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 16),
              
              // Description
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description (Optional)',
                  border: OutlineInputBorder(),
                  hintText: 'Additional details about your goal',
                ),
                maxLines: 2,
              ),
              
              const SizedBox(height: 16),
              
              // Target Value and Unit
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      controller: _targetValueController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Target Value',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Enter target value';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Enter valid number';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      initialValue: _selectedUnit,
                      decoration: const InputDecoration(
                        labelText: 'Unit',
                        border: OutlineInputBorder(),
                      ),
                      items: _units.map((unit) {
                        return DropdownMenuItem(
                          value: unit,
                          child: Text(unit),
                        );
                      }).toList(),
                      onChanged: (value) => setState(() => _selectedUnit = value!),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 16),
              
              // Current Value
              TextFormField(
                controller: _currentValueController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Current Value',
                  border: const OutlineInputBorder(),
                  suffixText: _selectedUnit,
                ),
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    if (double.tryParse(value) == null) {
                      return 'Enter valid number';
                    }
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 16),
              
              // Target Date
              InkWell(
                onTap: _selectTargetDate,
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Target Date (Optional)',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  child: Text(
                    _targetDate != null
                        ? '${_targetDate!.day}/${_targetDate!.month}/${_targetDate!.year}'
                        : 'Select target date',
                    style: TextStyle(
                      color: _targetDate != null
                          ? Theme.of(context).textTheme.bodyMedium?.color
                          : Theme.of(context).hintColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: _isLoading ? null : _createGoal,
          child: _isLoading
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Create Goal'),
        ),
      ],
    );
  }

  Future<void> _selectTargetDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 30)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
    );
    
    if (date != null) {
      setState(() => _targetDate = date);
    }
  }

  Future<void> _createGoal() async {
    if (!_formKey.currentState!.validate()) return;
    
    setState(() => _isLoading = true);
    
    try {
      const uuid = Uuid();
      final now = DateTime.now();
      
      final goal = Goal(
        id: uuid.v4(),
        userId: 'user_123', // In a real app, this would come from auth
        type: _selectedType,
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim().isEmpty 
            ? null 
            : _descriptionController.text.trim(),
        targetValue: double.parse(_targetValueController.text),
        currentValue: double.tryParse(_currentValueController.text) ?? 0.0,
        unit: _selectedUnit,
        targetDate: _targetDate,
        isCompleted: false,
        completedAt: null,
        createdAt: now,
        updatedAt: now,
      );
      
      final goalRepository = ref.read(goalRepositoryProvider);
      await goalRepository.createGoal(goal);
      
      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Goal "${goal.title}" created successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error creating goal: $error'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }
}