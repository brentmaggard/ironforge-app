import 'package:flutter/material.dart';

class NumericKeypad extends StatelessWidget {
  final Function(String) onInput;
  final bool allowDecimal;

  const NumericKeypad({
    super.key,
    required this.onInput,
    this.allowDecimal = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Row 1: 1, 2, 3
          Row(
            children: [
              _buildKey(context, '1'),
              _buildKey(context, '2'),
              _buildKey(context, '3'),
            ],
          ),
          const SizedBox(height: 8),
          
          // Row 2: 4, 5, 6
          Row(
            children: [
              _buildKey(context, '4'),
              _buildKey(context, '5'),
              _buildKey(context, '6'),
            ],
          ),
          const SizedBox(height: 8),
          
          // Row 3: 7, 8, 9
          Row(
            children: [
              _buildKey(context, '7'),
              _buildKey(context, '8'),
              _buildKey(context, '9'),
            ],
          ),
          const SizedBox(height: 8),
          
          // Row 4: decimal, 0, backspace
          Row(
            children: [
              _buildKey(
                context, 
                '.',
                enabled: allowDecimal,
                child: allowDecimal 
                    ? Text(
                        '.',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : null,
              ),
              _buildKey(context, '0'),
              _buildKey(
                context,
                'backspace',
                child: Icon(
                  Icons.backspace_outlined,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildKey(
    BuildContext context, 
    String value, {
    Widget? child,
    bool enabled = true,
  }) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Material(
          color: enabled 
              ? Theme.of(context).colorScheme.surfaceContainerHighest
              : Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            onTap: enabled ? () => onInput(value) : null,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              height: 56,
              alignment: Alignment.center,
              child: child ?? Text(
                value,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: enabled 
                      ? Theme.of(context).colorScheme.onSurface
                      : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.3),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}