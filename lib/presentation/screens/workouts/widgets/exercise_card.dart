import 'package:flutter/material.dart';
import '../../../../domain/entities/workout_session.dart';
import 'set_row.dart';

class ExerciseCard extends StatelessWidget {
  final ExerciseBlock exercise;
  final Unit unit;
  final Function(String setId, String field) onEditSet;
  final VoidCallback onToggleWarmup;
  final VoidCallback onAddWarmup;

  const ExerciseCard({
    super.key,
    required this.exercise,
    required this.unit,
    required this.onEditSet,
    required this.onToggleWarmup,
    required this.onAddWarmup,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card header
            Row(
              children: [
                Expanded(
                  child: Text(
                    exercise.name,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // TODO: Show exercise help/instructions
                  },
                  icon: const Icon(Icons.help_outline),
                  iconSize: 20,
                  tooltip: 'Exercise instructions',
                  style: IconButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 12),
            
            // Warmup group (collapsible)
            if (exercise.warmups.isNotEmpty || !exercise.isWarmupCollapsed) ...[
              Card(
                margin: EdgeInsets.zero,
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                child: Column(
                  children: [
                    // Warmup header
                    InkWell(
                      onTap: onToggleWarmup,
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            Icon(
                              exercise.isWarmupCollapsed 
                                  ? Icons.expand_more 
                                  : Icons.expand_less,
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Warm-up',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).colorScheme.onSurfaceVariant,
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: onAddWarmup,
                              icon: const Icon(Icons.add),
                              iconSize: 20,
                              tooltip: 'Add warmup set',
                              style: IconButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: const Size(24, 24),
                                foregroundColor: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    // Warmup sets (if not collapsed)
                    if (!exercise.isWarmupCollapsed) ...[
                      if (exercise.warmups.isNotEmpty) ...[
                        const Divider(height: 1),
                        ...exercise.warmups.asMap().entries.map((entry) {
                          final index = entry.key;
                          final set = entry.value;
                          return SetRow(
                            key: ValueKey(set.id),
                            set: set,
                            setNumber: index + 1,
                            unit: unit,
                            onEdit: onEditSet,
                          );
                        }),
                      ] else ...[
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            'No warmup sets',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ],
                ),
              ),
              
              const SizedBox(height: 12),
            ],
            
            // Working set list
            if (exercise.sets.isNotEmpty) ...[
              ...exercise.sets.asMap().entries.map((entry) {
                final index = entry.key;
                final set = entry.value;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: SetRow(
                    key: ValueKey(set.id),
                    set: set,
                    setNumber: index + 1,
                    unit: unit,
                    onEdit: onEditSet,
                  ),
                );
              }),
            ] else ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
                    style: BorderStyle.solid,
                  ),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.fitness_center,
                      size: 32,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'No working sets',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Add sets to start tracking',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}