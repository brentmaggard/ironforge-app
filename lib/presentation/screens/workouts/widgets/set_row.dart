import 'package:flutter/material.dart';
import '../../../../domain/entities/workout_session.dart';

class SetRow extends StatelessWidget {
  final SetEntry set;
  final int setNumber;
  final Unit unit;
  final Function(String setId, String field) onEdit;

  const SetRow({
    super.key,
    required this.set,
    required this.setNumber,
    required this.unit,
    required this.onEdit,
  });

  String get _unitString => unit == Unit.lb ? 'lb' : 'kg';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: set.isCompleted 
            ? Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.3)
            : null,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          // Left icon
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: set.kind == SetKind.warmup
                  ? Theme.of(context).colorScheme.secondaryContainer
                  : Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: set.kind == SetKind.warmup
                  ? Icon(
                      Icons.accessibility_new,
                      size: 16,
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                    )
                  : Text(
                      setNumber.toString(),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ),
            ),
          ),
          
          const SizedBox(width: 12),
          
          // Weight field
          Expanded(
            flex: 2,
            child: _WeightRepsChip(
              value: set.weight?.toStringAsFixed(1) ?? '',
              suffix: _unitString,
              placeholder: '0 $_unitString',
              onTap: () => onEdit(set.id, 'weight'),
            ),
          ),
          
          const SizedBox(width: 8),
          
          // Reps field
          Expanded(
            flex: 2,
            child: _WeightRepsChip(
              value: set.reps?.toString() ?? '',
              suffix: 'reps',
              placeholder: '0 reps',
              onTap: () => onEdit(set.id, 'reps'),
            ),
          ),
          
          const SizedBox(width: 8),
          
          // Row overflow menu
          PopupMenuButton<String>(
            icon: Icon(
              Icons.more_vert,
              size: 20,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            iconSize: 20,
            tooltip: 'Set options',
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'edit',
                child: Row(
                  children: [
                    Icon(Icons.edit, size: 16),
                    SizedBox(width: 8),
                    Text('Edit'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'duplicate',
                child: Row(
                  children: [
                    Icon(Icons.copy, size: 16),
                    SizedBox(width: 8),
                    Text('Duplicate'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(Icons.delete, size: 16),
                    SizedBox(width: 8),
                    Text('Delete'),
                  ],
                ),
              ),
              if (!set.isCompleted)
                const PopupMenuItem(
                  value: 'complete',
                  child: Row(
                    children: [
                      Icon(Icons.check, size: 16),
                      SizedBox(width: 8),
                      Text('Mark complete'),
                    ],
                  ),
                ),
              const PopupMenuItem(
                value: 'note',
                child: Row(
                  children: [
                    Icon(Icons.note, size: 16),
                    SizedBox(width: 8),
                    Text('Add note'),
                  ],
                ),
              ),
            ],
            onSelected: (value) {
              switch (value) {
                case 'edit':
                  // Open both weight and reps for editing
                  // For now, default to weight
                  onEdit(set.id, 'weight');
                  break;
                case 'duplicate':
                  // TODO: Implement duplicate set
                  break;
                case 'delete':
                  // TODO: Implement delete set
                  break;
                case 'complete':
                  // TODO: Implement mark complete
                  break;
                case 'note':
                  // TODO: Implement add note
                  break;
              }
            },
          ),
        ],
      ),
    );
  }
}

class _WeightRepsChip extends StatelessWidget {
  final String value;
  final String suffix;
  final String placeholder;
  final VoidCallback onTap;

  const _WeightRepsChip({
    required this.value,
    required this.suffix,
    required this.placeholder,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final displayValue = value.isEmpty ? placeholder : '$value $suffix';
    final isEmpty = value.isEmpty;
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
          ),
        ),
        child: Text(
          displayValue,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: isEmpty 
                ? Theme.of(context).colorScheme.onSurfaceVariant.withValues(alpha: 0.7)
                : Theme.of(context).colorScheme.onSurface,
            fontWeight: isEmpty ? FontWeight.normal : FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}