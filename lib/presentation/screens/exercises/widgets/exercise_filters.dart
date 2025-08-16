import 'package:flutter/material.dart';

class ExerciseFilters extends StatelessWidget {
  final String selectedCategory;
  final String selectedMuscleGroup;
  final String selectedEquipment;
  final String selectedDifficulty;
  final Function(String) onCategoryChanged;
  final Function(String) onMuscleGroupChanged;
  final Function(String) onEquipmentChanged;
  final Function(String) onDifficultyChanged;

  const ExerciseFilters({
    super.key,
    required this.selectedCategory,
    required this.selectedMuscleGroup,
    required this.selectedEquipment,
    required this.selectedDifficulty,
    required this.onCategoryChanged,
    required this.onMuscleGroupChanged,
    required this.onEquipmentChanged,
    required this.onDifficultyChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildFilterChip(
            'Category',
            selectedCategory,
            _categories,
            onCategoryChanged,
            context,
          ),
          const SizedBox(width: 8),
          _buildFilterChip(
            'Muscle',
            selectedMuscleGroup,
            _muscleGroups,
            onMuscleGroupChanged,
            context,
          ),
          const SizedBox(width: 8),
          _buildFilterChip(
            'Equipment',
            selectedEquipment,
            _equipment,
            onEquipmentChanged,
            context,
          ),
          const SizedBox(width: 8),
          _buildFilterChip(
            'Difficulty',
            selectedDifficulty,
            _difficulties,
            onDifficultyChanged,
            context,
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(
    String label,
    String selectedValue,
    List<String> options,
    Function(String) onChanged,
    BuildContext context,
  ) {
    return ActionChip(
      label: Text(
        selectedValue == 'All' ? label : selectedValue,
        style: TextStyle(
          color: selectedValue == 'All'
              ? Theme.of(context).colorScheme.onSurface
              : Theme.of(context).colorScheme.onPrimary,
          fontWeight: selectedValue == 'All' ? FontWeight.normal : FontWeight.w600,
        ),
      ),
      backgroundColor: selectedValue == 'All'
          ? Theme.of(context).colorScheme.surface
          : Theme.of(context).colorScheme.primary,
      side: BorderSide(
        color: selectedValue == 'All'
            ? Theme.of(context).colorScheme.outline
            : Theme.of(context).colorScheme.primary,
      ),
      onPressed: () => _showFilterDialog(
        context,
        label,
        selectedValue,
        options,
        onChanged,
      ),
    );
  }

  void _showFilterDialog(
    BuildContext context,
    String title,
    String selectedValue,
    List<String> options,
    Function(String) onChanged,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Select $title'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: options.length,
            itemBuilder: (context, index) {
              final option = options[index];
              return ListTile(
                title: Text(option),
                leading: Radio<String>(
                  value: option,
                  groupValue: selectedValue,
                  onChanged: (value) {
                    if (value != null) {
                      onChanged(value);
                      Navigator.of(context).pop();
                    }
                  },
                ),
                onTap: () {
                  onChanged(option);
                  Navigator.of(context).pop();
                },
              );
            },
          ),
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

  static const List<String> _categories = [
    'All',
    'Compound',
    'Isolation',
    'Cardio',
  ];

  static const List<String> _muscleGroups = [
    'All',
    'Chest',
    'Back',
    'Shoulders',
    'Biceps',
    'Triceps',
    'Legs',
    'Glutes',
    'Calves',
    'Core',
    'Forearms',
  ];

  static const List<String> _equipment = [
    'All',
    'Barbell',
    'Dumbbell',
    'Machine',
    'Cable',
    'Bodyweight',
    'Kettlebell',
    'Resistance Band',
  ];

  static const List<String> _difficulties = [
    'All',
    'Beginner',
    'Intermediate',
    'Advanced',
  ];
}