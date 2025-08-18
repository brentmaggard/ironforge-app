import 'package:flutter/material.dart';
import '../../../../domain/entities/workout_session.dart';
import 'numeric_keypad.dart';

class WeightRepsBottomSheet extends StatefulWidget {
  final String field; // 'weight' or 'reps'
  final String value;
  final Unit unit;
  final Function(String) onValueChanged;
  final VoidCallback onUnitToggle;
  final VoidCallback onDone;
  final VoidCallback onClose;

  const WeightRepsBottomSheet({
    super.key,
    required this.field,
    required this.value,
    required this.unit,
    required this.onValueChanged,
    required this.onUnitToggle,
    required this.onDone,
    required this.onClose,
  });

  @override
  State<WeightRepsBottomSheet> createState() => _WeightRepsBottomSheetState();
}

class _WeightRepsBottomSheetState extends State<WeightRepsBottomSheet> {
  late String _localValue;
  bool _showPlateHelper = false;

  @override
  void initState() {
    super.initState();
    _localValue = widget.value;
  }

  void _onKeypadInput(String input) {
    setState(() {
      if (input == 'backspace') {
        if (_localValue.isNotEmpty) {
          _localValue = _localValue.substring(0, _localValue.length - 1);
        }
      } else if (input == '.') {
        // Only allow decimal for weight field and if not already present
        if (widget.field == 'weight' && !_localValue.contains('.')) {
          _localValue += input;
        }
      } else {
        // Regular number input
        _localValue += input;
      }
    });
    widget.onValueChanged(_localValue);
  }

  void _togglePlateHelper() {
    setState(() {
      _showPlateHelper = !_showPlateHelper;
    });
  }

  String get _fieldLabel {
    switch (widget.field) {
      case 'weight':
        return 'Weight';
      case 'reps':
        return 'Reps';
      default:
        return 'Value';
    }
  }

  String get _unitDisplay {
    return widget.unit == Unit.lb ? 'lb' : 'kg';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        children: [
          // Drag handle
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          
          // Accessory bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                // Plate helper toggle (only for weight)
                if (widget.field == 'weight')
                  IconButton(
                    onPressed: _togglePlateHelper,
                    icon: Icon(
                      Icons.fitness_center,
                      color: _showPlateHelper 
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    tooltip: 'Plate helper',
                    style: IconButton.styleFrom(
                      backgroundColor: _showPlateHelper 
                          ? Theme.of(context).colorScheme.primaryContainer
                          : null,
                    ),
                  ),
                
                const Spacer(),
                
                // Unit switcher (only for weight)
                if (widget.field == 'weight')
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _UnitButton(
                          label: 'lb',
                          isSelected: widget.unit == Unit.lb,
                          onTap: () {
                            if (widget.unit == Unit.kg) {
                              widget.onUnitToggle();
                            }
                          },
                        ),
                        _UnitButton(
                          label: 'kg',
                          isSelected: widget.unit == Unit.kg,
                          onTap: () {
                            if (widget.unit == Unit.lb) {
                              widget.onUnitToggle();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                
                const Spacer(),
                
                // Done button
                TextButton(
                  onPressed: widget.onDone,
                  child: Text(
                    'Done',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          const Divider(height: 1),
          
          // Display area
          Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Text(
                  _fieldLabel,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _localValue.isEmpty 
                      ? '0'
                      : _localValue + (widget.field == 'weight' ? ' $_unitDisplay' : ''),
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: _localValue.isEmpty 
                        ? Theme.of(context).colorScheme.onSurfaceVariant
                        : Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
          
          // Plate helper (if enabled)
          if (_showPlateHelper && widget.field == 'weight')
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Plate Calculator',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Plate calculator coming soon',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          
          const Spacer(),
          
          // Numeric keypad
          NumericKeypad(
            onInput: _onKeypadInput,
            allowDecimal: widget.field == 'weight',
          ),
          
          // Bottom safe area
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }
}

class _UnitButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _UnitButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected 
              ? Theme.of(context).colorScheme.primary
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: isSelected 
                ? Theme.of(context).colorScheme.onPrimary
                : Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}