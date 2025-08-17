import 'package:equatable/equatable.dart';

class Program extends Equatable {
  const Program({
    required this.id,
    required this.name,
    this.description,
    this.author,
    required this.difficulty,
    this.frequency,
    this.durationWeeks,
    this.tags,
    required this.config,
    required this.isTemplate,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String name;
  final String? description;
  final String? author;
  final String difficulty; // beginner, intermediate, advanced
  final int? frequency; // days per week
  final int? durationWeeks;
  final List<String>? tags; // ["strength", "powerlifting", "full-body"]
  final Map<String, dynamic> config; // JSON program configuration
  final bool isTemplate;
  final DateTime createdAt;
  final DateTime updatedAt;

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        author,
        difficulty,
        frequency,
        durationWeeks,
        tags,
        config,
        isTemplate,
        createdAt,
        updatedAt,
      ];

  Program copyWith({
    String? id,
    String? name,
    String? description,
    String? author,
    String? difficulty,
    int? frequency,
    int? durationWeeks,
    List<String>? tags,
    Map<String, dynamic>? config,
    bool? isTemplate,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Program(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      author: author ?? this.author,
      difficulty: difficulty ?? this.difficulty,
      frequency: frequency ?? this.frequency,
      durationWeeks: durationWeeks ?? this.durationWeeks,
      tags: tags ?? this.tags,
      config: config ?? this.config,
      isTemplate: isTemplate ?? this.isTemplate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  /// Get workouts from program configuration
  Map<String, ProgramWorkout> get workouts {
    final workoutsData = config['workouts'] as Map<String, dynamic>? ?? {};
    return workoutsData.map(
      (key, value) => MapEntry(
        key,
        ProgramWorkout.fromMap(value as Map<String, dynamic>),
      ),
    );
  }

  /// Get program schedule
  List<String> get schedule {
    return List<String>.from(config['schedule'] as List? ?? []);
  }

  /// Get progression rules
  Map<String, dynamic> get progressionRules {
    return config['progressionRules'] as Map<String, dynamic>? ?? {};
  }
}

class ProgramWorkout extends Equatable {
  const ProgramWorkout({
    required this.name,
    required this.exercises,
  });

  final String name;
  final List<ProgramExercise> exercises;

  @override
  List<Object?> get props => [name, exercises];

  static ProgramWorkout fromMap(Map<String, dynamic> map) {
    return ProgramWorkout(
      name: map['name'] as String,
      exercises: (map['exercises'] as List<dynamic>? ?? [])
          .map((e) => ProgramExercise.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'exercises': exercises.map((e) => e.toMap()).toList(),
    };
  }
}

class ProgramExercise extends Equatable {
  const ProgramExercise({
    required this.exerciseId,
    required this.sets,
    this.restTime,
    this.notes,
    this.progression,
  });

  final String exerciseId;
  final List<ProgramSet> sets;
  final int? restTime; // seconds
  final String? notes;
  final ProgressionRule? progression;

  @override
  List<Object?> get props => [exerciseId, sets, restTime, notes, progression];

  static ProgramExercise fromMap(Map<String, dynamic> map) {
    return ProgramExercise(
      exerciseId: map['exerciseId'] as String,
      sets: (map['sets'] as List<dynamic>? ?? [])
          .map((e) => ProgramSet.fromMap(e as Map<String, dynamic>))
          .toList(),
      restTime: map['restTime'] as int?,
      notes: map['notes'] as String?,
      progression: map['progression'] != null
          ? ProgressionRule.fromMap(map['progression'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'exerciseId': exerciseId,
      'sets': sets.map((e) => e.toMap()).toList(),
      if (restTime != null) 'restTime': restTime,
      if (notes != null) 'notes': notes,
      if (progression != null) 'progression': progression!.toMap(),
    };
  }
}

class ProgramSet extends Equatable {
  const ProgramSet({
    required this.reps,
    required this.weight,
    required this.type,
  });

  final dynamic reps; // int or String (for "5+" AMRAP sets)
  final double weight;
  final String type; // normal, amrap, warmup

  @override
  List<Object?> get props => [reps, weight, type];

  bool get isAmrap => type == 'amrap' || reps.toString().contains('+');

  int get targetReps {
    if (reps is int) return reps as int;
    if (reps is String) {
      final repsStr = reps as String;
      if (repsStr.contains('+')) {
        return int.tryParse(repsStr.replaceAll('+', '')) ?? 5;
      }
      return int.tryParse(repsStr) ?? 5;
    }
    return 5;
  }

  static ProgramSet fromMap(Map<String, dynamic> map) {
    return ProgramSet(
      reps: map['reps'], // Can be int or String
      weight: (map['weight'] as num).toDouble(),
      type: map['type'] as String? ?? 'normal',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'reps': reps,
      'weight': weight,
      'type': type,
    };
  }
}

class ProgressionRule extends Equatable {
  const ProgressionRule({
    required this.type,
    required this.increment,
    required this.unit,
    this.frequency,
    this.failureThreshold,
    this.deloadPercentage,
  });

  final String type; // linear, percentage, custom
  final double increment; // +2.5, +5, etc.
  final String unit; // lbs, kg, %
  final String? frequency; // session, weekly, successful_completion
  final int? failureThreshold; // number of failures before deload
  final double? deloadPercentage; // percentage to deload (10% = 0.1)

  @override
  List<Object?> get props => [
        type,
        increment,
        unit,
        frequency,
        failureThreshold,
        deloadPercentage,
      ];

  static ProgressionRule fromMap(Map<String, dynamic> map) {
    return ProgressionRule(
      type: map['type'] as String,
      increment: (map['increment'] as num).toDouble(),
      unit: map['unit'] as String,
      frequency: map['frequency'] as String?,
      failureThreshold: map['failureThreshold'] as int?,
      deloadPercentage: map['deloadPercentage'] != null
          ? (map['deloadPercentage'] as num).toDouble()
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'increment': increment,
      'unit': unit,
      if (frequency != null) 'frequency': frequency,
      if (failureThreshold != null) 'failureThreshold': failureThreshold,
      if (deloadPercentage != null) 'deloadPercentage': deloadPercentage,
    };
  }
}