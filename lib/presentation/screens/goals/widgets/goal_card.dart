import 'package:flutter/material.dart';
import '../../../../domain/entities/goal.dart';

class GoalCard extends StatelessWidget {
  const GoalCard({
    super.key,
    required this.goal,
    this.onTap,
    this.onProgressUpdate,
    this.onComplete,
  });

  final Goal goal;
  final VoidCallback? onTap;
  final Function(double)? onProgressUpdate;
  final VoidCallback? onComplete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final progressPercentage = goal.progressPercentage;
    
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with title and status
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          goal.title,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (goal.description != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            goal.description!,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  _buildStatusChip(context),
                ],
              ),
              
              const SizedBox(height: 16),
              
              // Progress section
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Progress: ${goal.currentValue.toStringAsFixed(1)} / ${goal.targetValue.toStringAsFixed(1)} ${goal.unit}',
                          style: theme.textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 8),
                        LinearProgressIndicator(
                          value: progressPercentage,
                          backgroundColor: theme.colorScheme.surfaceContainerHighest,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            goal.isCompleted
                                ? Colors.green
                                : goal.isOverdue
                                    ? Colors.orange
                                    : theme.colorScheme.primary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${(progressPercentage * 100).toStringAsFixed(1)}% complete',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    '${(progressPercentage * 100).round()}%',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: goal.isCompleted
                          ? Colors.green
                          : goal.isOverdue
                              ? Colors.orange
                              : theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
              
              if (goal.targetDate != null) ...[
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(
                      Icons.schedule,
                      size: 16,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Target: ${_formatDate(goal.targetDate!)}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: goal.isOverdue ? Colors.red : theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    if (goal.isOverdue) ...[
                      const SizedBox(width: 8),
                      Text(
                        'OVERDUE',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
              
              // Action buttons
              if (!goal.isCompleted) ...[
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => _showProgressUpdateDialog(context),
                        icon: const Icon(Icons.trending_up, size: 18),
                        label: const Text('Update Progress'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    if (progressPercentage >= 1.0 || goal.currentValue >= goal.targetValue)
                      FilledButton.icon(
                        onPressed: onComplete,
                        icon: const Icon(Icons.check, size: 18),
                        label: const Text('Complete'),
                      ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip(BuildContext context) {
    final theme = Theme.of(context);
    
    if (goal.isCompleted) {
      return Chip(
        label: const Text('Completed'),
        backgroundColor: Colors.green.withOpacity(0.1),
        labelStyle: TextStyle(color: Colors.green.shade700),
        side: BorderSide(color: Colors.green.shade300),
      );
    }
    
    if (goal.isOverdue) {
      return Chip(
        label: const Text('Overdue'),
        backgroundColor: Colors.orange.withOpacity(0.1),
        labelStyle: TextStyle(color: Colors.orange.shade700),
        side: BorderSide(color: Colors.orange.shade300),
      );
    }
    
    return Chip(
      label: Text(goal.type.toUpperCase()),
      backgroundColor: theme.colorScheme.primaryContainer,
      labelStyle: TextStyle(color: theme.colorScheme.onPrimaryContainer),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _showProgressUpdateDialog(BuildContext context) {
    final controller = TextEditingController(text: goal.currentValue.toString());
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Update Progress'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Current: ${goal.currentValue} ${goal.unit}'),
            Text('Target: ${goal.targetValue} ${goal.unit}'),
            const SizedBox(height: 16),
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'New Value',
                suffixText: goal.unit,
                border: const OutlineInputBorder(),
              ),
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
              final newValue = double.tryParse(controller.text);
              if (newValue != null && onProgressUpdate != null) {
                onProgressUpdate!(newValue);
                Navigator.of(context).pop();
              }
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }
}