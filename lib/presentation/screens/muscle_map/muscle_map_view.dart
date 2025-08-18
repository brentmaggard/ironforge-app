import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:xml/xml.dart';
import '../../../domain/entities/muscle_map.dart';

enum MuscleMapOrientation { front, back }

class MuscleMapView extends StatefulWidget {
  final Map<ScreenMuscle, double> muscleActivation;
  final MuscleMapOrientation orientation;
  final bool showLabels;
  final double width;
  final double height;

  const MuscleMapView({
    super.key,
    required this.muscleActivation,
    this.orientation = MuscleMapOrientation.front,
    this.showLabels = true,
    this.width = 200,
    this.height = 400,
  });

  @override
  State<MuscleMapView> createState() => _MuscleMapViewState();
}

class _MuscleMapViewState extends State<MuscleMapView> {
  String? _modifiedSvg;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAndModifySvg();
  }

  @override
  void didUpdateWidget(MuscleMapView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.muscleActivation != widget.muscleActivation ||
        oldWidget.orientation != widget.orientation ||
        oldWidget.showLabels != widget.showLabels) {
      _loadAndModifySvg();
    }
  }

  Future<void> _loadAndModifySvg() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final svgPath = widget.orientation == MuscleMapOrientation.front
          ? 'assets/muscle_map/body_front.svg'
          : 'assets/muscle_map/body_back.svg';

      final svgString = await rootBundle.loadString(svgPath);
      final modifiedSvg = _injectMuscleColors(svgString);

      setState(() {
        _modifiedSvg = modifiedSvg;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading SVG: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  String _injectMuscleColors(String svgString) {
    try {
      final document = XmlDocument.parse(svgString);

      // Find all elements with data-muscle attributes
      final elements = document.findAllElements('*').where((element) =>
          element.getAttribute('data-muscle') != null);

      for (final element in elements) {
        final muscleType = element.getAttribute('data-muscle');
        if (muscleType != null) {
          final screenMuscle = ScreenMuscle.fromString(muscleType);
          if (screenMuscle != null && widget.muscleActivation.containsKey(screenMuscle)) {
            final activation = widget.muscleActivation[screenMuscle]!;
            
            // Get the base color from the stroke attribute
            final strokeColor = element.getAttribute('stroke');
            if (strokeColor != null && strokeColor.startsWith('rgba(')) {
              // Extract RGB values from stroke color
              final colorMatch = RegExp(r'rgba\((\d+),\s*(\d+),\s*(\d+)').firstMatch(strokeColor);
              if (colorMatch != null) {
                final r = colorMatch.group(1)!;
                final g = colorMatch.group(2)!;
                final b = colorMatch.group(3)!;
                
                // Set fill with activation-based opacity
                element.setAttribute('fill', 'rgba($r, $g, $b, ${activation.toStringAsFixed(2)})');
              }
            }
          }
        }
      }

      // Hide/show labels based on showLabels setting
      if (!widget.showLabels) {
        final textElements = document.findAllElements('text');
        for (final textElement in textElements) {
          textElement.setAttribute('opacity', '0');
        }
      }

      return document.toXmlString();
    } catch (e) {
      print('Error modifying SVG: $e');
      return svgString; // Return original if modification fails
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return SizedBox(
        width: widget.width,
        height: widget.height,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_modifiedSvg == null) {
      return SizedBox(
        width: widget.width,
        height: widget.height,
        child: const Center(
          child: Icon(
            Icons.error_outline,
            size: 48,
            color: Colors.grey,
          ),
        ),
      );
    }

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: SvgPicture.string(
        _modifiedSvg!,
        width: widget.width,
        height: widget.height,
        fit: BoxFit.contain,
      ),
    );
  }
}

/// Helper class to calculate muscle activation points
class PointsCalculator {
  static const double targetPoints = 1.0; // Full activation (0-1 scale)
  static const double synergistPoints = 0.3; // Partial activation (0-1 scale)

  /// Calculate muscle activation map from MuscleActivation data
  static Map<ScreenMuscle, double> calculateActivationMap(MuscleActivation activation) {
    final Map<ScreenMuscle, double> result = {};
    
    // Add target muscles with full activation
    for (final entry in activation.targetMuscles.entries) {
      result[entry.key] = entry.value;
    }
    
    // Add synergist muscles with partial activation (only if not already a target)
    for (final entry in activation.synergistMuscles.entries) {
      if (!result.containsKey(entry.key)) {
        result[entry.key] = entry.value;
      }
    }
    
    return result;
  }

  /// Normalize activation values to 0-1 scale
  static Map<ScreenMuscle, double> normalizeActivation(Map<ScreenMuscle, double> activation) {
    if (activation.isEmpty) return activation;
    
    final maxValue = activation.values.reduce((a, b) => a > b ? a : b);
    if (maxValue <= 1.0) return activation; // Already normalized
    
    return activation.map((muscle, value) => 
        MapEntry(muscle, value / maxValue));
  }
}