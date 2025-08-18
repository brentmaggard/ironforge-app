import 'package:flutter/material.dart';

class TopActionBar extends StatelessWidget {
  final String title;
  final String elapsedFormatted;
  final bool isPaused;
  final VoidCallback onClose;
  final VoidCallback onPauseToggle;
  final VoidCallback onSettings;
  final VoidCallback onComplete;

  const TopActionBar({
    super.key,
    required this.title,
    required this.elapsedFormatted,
    required this.isPaused,
    required this.onClose,
    required this.onPauseToggle,
    required this.onSettings,
    required this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Leading close button
          IconButton(
            onPressed: onClose,
            icon: const Icon(Icons.close),
            iconSize: 24,
            tooltip: 'Discard and exit',
          ),
          
          const SizedBox(width: 8),
          
          // Title area
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  elapsedFormatted,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w600,
                    fontFeatures: [const FontFeature.tabularFigures()],
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(width: 8),
          
          // Action cluster
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Pause/Resume button
              IconButton(
                onPressed: onPauseToggle,
                icon: Icon(isPaused ? Icons.play_arrow : Icons.pause),
                iconSize: 24,
                tooltip: isPaused ? 'Resume timer' : 'Pause timer',
                style: IconButton.styleFrom(
                  backgroundColor: isPaused 
                      ? Theme.of(context).colorScheme.primaryContainer
                      : null,
                ),
              ),
              
              // Settings button
              IconButton(
                onPressed: onSettings,
                icon: const Icon(Icons.settings),
                iconSize: 24,
                tooltip: 'Settings',
              ),
              
              // Complete button
              IconButton(
                onPressed: onComplete,
                icon: const Icon(Icons.check),
                iconSize: 24,
                tooltip: 'Finish workout',
                style: IconButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                  foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}