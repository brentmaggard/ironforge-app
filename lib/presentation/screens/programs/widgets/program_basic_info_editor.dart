import 'package:flutter/material.dart';

class ProgramBasicInfoEditor extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final TextEditingController authorController;
  final String selectedDifficulty;
  final int frequency;
  final int durationWeeks;
  final List<String> tags;
  final VoidCallback onChanged;
  final ValueChanged<String> onDifficultyChanged;
  final ValueChanged<int> onFrequencyChanged;
  final ValueChanged<int> onDurationChanged;
  final ValueChanged<List<String>> onTagsChanged;

  const ProgramBasicInfoEditor({
    super.key,
    required this.nameController,
    required this.descriptionController,
    required this.authorController,
    required this.selectedDifficulty,
    required this.frequency,
    required this.durationWeeks,
    required this.tags,
    required this.onChanged,
    required this.onDifficultyChanged,
    required this.onFrequencyChanged,
    required this.onDurationChanged,
    required this.onTagsChanged,
  });

  @override
  State<ProgramBasicInfoEditor> createState() => _ProgramBasicInfoEditorState();
}

class _ProgramBasicInfoEditorState extends State<ProgramBasicInfoEditor> {
  final List<String> _availableTags = [
    'strength',
    'powerlifting',
    'bodybuilding',
    'full-body',
    'upper-lower',
    'push-pull-legs',
    'linear-progression',
    'beginner',
    'intermediate',
    'advanced',
    'custom',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Program Name
          _buildSectionHeader('Program Name'),
          TextField(
            controller: widget.nameController,
            decoration: const InputDecoration(
              hintText: 'Enter program name',
              border: OutlineInputBorder(),
            ),
            onChanged: (_) => widget.onChanged(),
          ),
          const SizedBox(height: 24),

          // Description
          _buildSectionHeader('Description'),
          TextField(
            controller: widget.descriptionController,
            decoration: const InputDecoration(
              hintText: 'Describe your program goals and methodology',
              border: OutlineInputBorder(),
            ),
            maxLines: 4,
            onChanged: (_) => widget.onChanged(),
          ),
          const SizedBox(height: 24),

          // Author
          _buildSectionHeader('Author'),
          TextField(
            controller: widget.authorController,
            decoration: const InputDecoration(
              hintText: 'Program author or source',
              border: OutlineInputBorder(),
            ),
            onChanged: (_) => widget.onChanged(),
          ),
          const SizedBox(height: 24),

          // Difficulty
          _buildSectionHeader('Difficulty Level'),
          Row(
            children: ['beginner', 'intermediate', 'advanced'].map((difficulty) {
              final isSelected = widget.selectedDifficulty == difficulty;
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(difficulty.toUpperCase()),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) {
                        widget.onDifficultyChanged(difficulty);
                      }
                    },
                    selectedColor: _getDifficultyColor(difficulty).withOpacity(0.2),
                    side: BorderSide(color: _getDifficultyColor(difficulty)),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),

          // Frequency and Duration
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionHeader('Frequency (days/week)'),
                    DropdownButtonFormField<int>(
                      value: widget.frequency,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      items: List.generate(7, (index) => index + 1)
                          .map((days) => DropdownMenuItem(
                                value: days,
                                child: Text('$days days'),
                              ))
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          widget.onFrequencyChanged(value);
                        }
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionHeader('Duration (weeks)'),
                    DropdownButtonFormField<int>(
                      value: widget.durationWeeks,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      items: [4, 6, 8, 10, 12, 16, 20, 24, 52]
                          .map((weeks) => DropdownMenuItem(
                                value: weeks,
                                child: Text('$weeks weeks'),
                              ))
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          widget.onDurationChanged(value);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Tags
          _buildSectionHeader('Tags'),
          const Text(
            'Select tags that describe your program',
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _availableTags.map((tag) {
              final isSelected = widget.tags.contains(tag);
              return FilterChip(
                label: Text(tag),
                selected: isSelected,
                onSelected: (selected) {
                  final newTags = List<String>.from(widget.tags);
                  if (selected) {
                    newTags.add(tag);
                  } else {
                    newTags.remove(tag);
                  }
                  widget.onTagsChanged(newTags);
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 16),

          // Custom tag input
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Add custom tag',
                    border: OutlineInputBorder(),
                  ),
                  onSubmitted: (value) {
                    if (value.trim().isNotEmpty && !widget.tags.contains(value.trim())) {
                      final newTags = List<String>.from(widget.tags)..add(value.trim());
                      widget.onTagsChanged(newTags);
                    }
                  },
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: () {
                  // Focus will handle the submission
                },
                icon: const Icon(Icons.add),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'beginner':
        return Colors.green;
      case 'intermediate':
        return Colors.orange;
      case 'advanced':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}