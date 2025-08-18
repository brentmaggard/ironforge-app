import 'package:equatable/equatable.dart';

enum Unit { lb, kg }

enum SetKind { warmup, working }

class SetEntry extends Equatable {
  const SetEntry({
    required this.id,
    required this.kind,
    required this.order,
    this.weight,
    this.reps,
    this.completedAt,
    this.notes,
  });

  final String id;
  final SetKind kind;
  final int order; // 1-based for working sets
  final double? weight; // stored in session.unit
  final int? reps; // allow 0 to record failed or attempted sets
  final DateTime? completedAt; // when user taps 'complete'
  final String? notes;

  bool get isCompleted => weight != null && reps != null;

  @override
  List<Object?> get props => [
        id,
        kind,
        order,
        weight,
        reps,
        completedAt,
        notes,
      ];

  SetEntry copyWith({
    String? id,
    SetKind? kind,
    int? order,
    double? weight,
    int? reps,
    DateTime? completedAt,
    String? notes,
  }) {
    return SetEntry(
      id: id ?? this.id,
      kind: kind ?? this.kind,
      order: order ?? this.order,
      weight: weight ?? this.weight,
      reps: reps ?? this.reps,
      completedAt: completedAt ?? this.completedAt,
      notes: notes ?? this.notes,
    );
  }
}

class ExerciseBlock extends Equatable {
  const ExerciseBlock({
    required this.id,
    required this.name,
    required this.exerciseId,
    this.helpUrl,
    required this.warmups,
    required this.sets,
    this.isWarmupCollapsed = false,
  });

  final String id;
  final String name; // "Bench Press"
  final String exerciseId; // Reference to exercise in database
  final String? helpUrl;
  final List<SetEntry> warmups; // kind='warmup'
  final List<SetEntry> sets; // kind='working'
  final bool isWarmupCollapsed;

  int get totalSets => warmups.length + sets.length;
  int get completedSets => warmups.where((s) => s.isCompleted).length + 
                           sets.where((s) => s.isCompleted).length;

  @override
  List<Object?> get props => [
        id,
        name,
        exerciseId,
        helpUrl,
        warmups,
        sets,
        isWarmupCollapsed,
      ];

  ExerciseBlock copyWith({
    String? id,
    String? name,
    String? exerciseId,
    String? helpUrl,
    List<SetEntry>? warmups,
    List<SetEntry>? sets,
    bool? isWarmupCollapsed,
  }) {
    return ExerciseBlock(
      id: id ?? this.id,
      name: name ?? this.name,
      exerciseId: exerciseId ?? this.exerciseId,
      helpUrl: helpUrl ?? this.helpUrl,
      warmups: warmups ?? this.warmups,
      sets: sets ?? this.sets,
      isWarmupCollapsed: isWarmupCollapsed ?? this.isWarmupCollapsed,
    );
  }
}

class WorkoutSession extends Equatable {
  const WorkoutSession({
    required this.id,
    required this.title,
    required this.startedAt,
    this.elapsedMs = 0,
    this.isPaused = false,
    this.unit = Unit.lb,
    required this.exercises,
    this.programId,
    this.userProgramId,
    this.notes,
  });

  final String id;
  final String title; // "JN - Push"
  final DateTime startedAt; // ISO
  final int elapsedMs; // timer storage when paused/resumed
  final bool isPaused;
  final Unit unit; // global unit for display/input
  final List<ExerciseBlock> exercises;
  final String? programId; // Reference to program if from program
  final String? userProgramId; // Reference to user program instance
  final String? notes;

  Duration get elapsed => Duration(milliseconds: elapsedMs);
  
  String get elapsedFormatted {
    final duration = elapsed;
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  int get totalSets => exercises.fold(0, (sum, exercise) => sum + exercise.totalSets);
  int get completedSets => exercises.fold(0, (sum, exercise) => sum + exercise.completedSets);
  
  bool get hasIncompleteSets => completedSets < totalSets;

  @override
  List<Object?> get props => [
        id,
        title,
        startedAt,
        elapsedMs,
        isPaused,
        unit,
        exercises,
        programId,
        userProgramId,
        notes,
      ];

  WorkoutSession copyWith({
    String? id,
    String? title,
    DateTime? startedAt,
    int? elapsedMs,
    bool? isPaused,
    Unit? unit,
    List<ExerciseBlock>? exercises,
    String? programId,
    String? userProgramId,
    String? notes,
  }) {
    return WorkoutSession(
      id: id ?? this.id,
      title: title ?? this.title,
      startedAt: startedAt ?? this.startedAt,
      elapsedMs: elapsedMs ?? this.elapsedMs,
      isPaused: isPaused ?? this.isPaused,
      unit: unit ?? this.unit,
      exercises: exercises ?? this.exercises,
      programId: programId ?? this.programId,
      userProgramId: userProgramId ?? this.userProgramId,
      notes: notes ?? this.notes,
    );
  }
}

// Unit conversion utilities
class UnitConverter {
  static const double lbToKgFactor = 2.20462262185;
  
  static double convertWeight(double weight, Unit from, Unit to) {
    if (from == to) return weight;
    
    if (from == Unit.lb && to == Unit.kg) {
      return weight / lbToKgFactor;
    } else if (from == Unit.kg && to == Unit.lb) {
      return weight * lbToKgFactor;
    }
    
    return weight;
  }
  
  static double roundForPlates(double weight, Unit unit) {
    if (unit == Unit.lb) {
      return (weight / 2.5).round() * 2.5; // Round to nearest 2.5 lb
    } else {
      return weight.round().toDouble(); // Round to nearest 1 kg
    }
  }
}