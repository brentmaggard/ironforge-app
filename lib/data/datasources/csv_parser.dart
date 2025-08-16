import 'package:flutter/services.dart';
import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import 'database.dart';

/// CSV Parser utility for importing seed data from CSV files
class CsvParser {
  static const _uuid = Uuid();

  /// Parse exercises from CSV file
  static Future<List<ExercisesCompanion>> parseExercises(String csvPath) async {
    final csvContent = await rootBundle.loadString(csvPath);
    final lines = csvContent.split('\n');
    
    if (lines.isEmpty) return [];
    
    // Skip header row
    final dataLines = lines.skip(1).where((line) => line.trim().isNotEmpty);
    
    final exercises = <ExercisesCompanion>[];
    
    for (final line in dataLines) {
      try {
        final exercise = _parseExerciseLine(line);
        if (exercise != null) {
          exercises.add(exercise);
        }
      } catch (e) {
        print('Error parsing exercise line: $line');
        print('Error: $e');
        continue;
      }
    }
    
    return exercises;
  }

  /// Parse goals from CSV file
  static Future<List<GoalsCompanion>> parseGoals(String csvPath) async {
    final csvContent = await rootBundle.loadString(csvPath);
    final lines = csvContent.split('\n');
    
    if (lines.isEmpty) return [];
    
    // Skip header row
    final dataLines = lines.skip(1).where((line) => line.trim().isNotEmpty);
    
    final goals = <GoalsCompanion>[];
    
    for (final line in dataLines) {
      try {
        final goal = _parseGoalLine(line);
        if (goal != null) {
          goals.add(goal);
        }
      } catch (e) {
        print('Error parsing goal line: $line');
        print('Error: $e');
        continue;
      }
    }
    
    return goals;
  }

  /// Parse exercise categories from CSV file
  static Future<List<ExerciseCategoriesCompanion>> parseExerciseCategories(String csvPath) async {
    final csvContent = await rootBundle.loadString(csvPath);
    final lines = csvContent.split('\n');
    
    if (lines.isEmpty) return [];
    
    // Skip header row
    final dataLines = lines.skip(1).where((line) => line.trim().isNotEmpty);
    
    final categories = <ExerciseCategoriesCompanion>[];
    
    for (final line in dataLines) {
      try {
        final category = _parseCategoryLine(line);
        if (category != null) {
          categories.add(category);
        }
      } catch (e) {
        print('Error parsing category line: $line');
        print('Error: $e');
        continue;
      }
    }
    
    return categories;
  }

  /// Parse equipment from CSV file
  static Future<List<EquipmentCompanion>> parseEquipment(String csvPath) async {
    final csvContent = await rootBundle.loadString(csvPath);
    final lines = csvContent.split('\n');
    
    if (lines.isEmpty) return [];
    
    // Skip header row
    final dataLines = lines.skip(1).where((line) => line.trim().isNotEmpty);
    
    final equipment = <EquipmentCompanion>[];
    
    for (final line in dataLines) {
      try {
        final equipmentItem = _parseEquipmentLine(line);
        if (equipmentItem != null) {
          equipment.add(equipmentItem);
        }
      } catch (e) {
        print('Error parsing equipment line: $line');
        print('Error: $e');
        continue;
      }
    }
    
    return equipment;
  }

  /// Parse goal progress from CSV file
  static Future<List<GoalProgressCompanion>> parseGoalProgress(String csvPath) async {
    final csvContent = await rootBundle.loadString(csvPath);
    final lines = csvContent.split('\n');
    
    if (lines.isEmpty) return [];
    
    // Skip header row
    final dataLines = lines.skip(1).where((line) => line.trim().isNotEmpty);
    
    final progressEntries = <GoalProgressCompanion>[];
    
    for (final line in dataLines) {
      try {
        final progress = _parseGoalProgressLine(line);
        if (progress != null) {
          progressEntries.add(progress);
        }
      } catch (e) {
        print('Error parsing goal progress line: $line');
        print('Error: $e');
        continue;
      }
    }
    
    return progressEntries;
  }

  /// Parse a single exercise CSV line
  static ExercisesCompanion? _parseExerciseLine(String line) {
    final fields = _parseCsvLine(line);
    
    if (fields.length < 27) {
      print('Exercise line has insufficient fields: ${fields.length}');
      return null;
    }

    try {
      return ExercisesCompanion.insert(
        id: _uuid.v4(),
        exerciseId: fields[1].trim(),
        name: fields[2].trim(),
        defaultEquipment: fields[3].trim(),
        availableEquipment: Value(fields[4].trim().isEmpty ? null : fields[4].trim()),
        exerciseTypes: Value(fields[5].trim().isEmpty ? null : fields[5].trim()),
        primaryMuscles: Value(fields[6].trim().isEmpty ? null : fields[6].trim()),
        secondaryMuscles: Value(fields[7].trim().isEmpty ? null : fields[7].trim()),
        bodyParts: Value(fields[8].trim().isEmpty ? null : fields[8].trim()),
        startingWeightLbs: Value(_parseDouble(fields[9])),
        startingWeightKg: Value(_parseDouble(fields[10])),
        defaultWarmupWeight: Value(_parseDouble(fields[11])),
        description: Value(fields[12].trim().isEmpty ? null : fields[12].trim()),
        instructions: Value(fields[13].trim().isEmpty ? null : fields[13].trim()),
        tips: Value(fields[14].trim().isEmpty ? null : fields[14].trim()),
        videoUrl: Value(fields[15].trim().isEmpty ? null : fields[15].trim()),
        imageUrlSmall: Value(fields[16].trim().isEmpty ? null : fields[16].trim()),
        imageUrlLarge: Value(fields[17].trim().isEmpty ? null : fields[17].trim()),
        hasCustomImage: Value(_parseBool(fields[18])),
        difficultyLevel: Value(_parseInt(fields[19]) ?? 3),
        safetyRating: Value(_parseInt(fields[20]) ?? 3),
        isCompound: Value(_parseBool(fields[21])),
        isUnilateral: Value(_parseBool(fields[22])),
        requiresSpotter: Value(_parseBool(fields[23])),
        isActive: Value(_parseBool(fields[24])),
        createdAt: Value(_parseDateTime(fields[25]) ?? DateTime.now()),
        updatedAt: Value(_parseDateTime(fields[26]) ?? DateTime.now()),
      );
    } catch (e) {
      print('Error creating exercise companion: $e');
      return null;
    }
  }

  /// Parse a single goal CSV line
  static GoalsCompanion? _parseGoalLine(String line) {
    final fields = _parseCsvLine(line);
    
    if (fields.length < 17) {
      print('Goal line has insufficient fields: ${fields.length}');
      return null;
    }

    try {
      return GoalsCompanion.insert(
        id: fields[0].trim(),
        userId: fields[1].trim(),
        name: fields[2].trim(),
        description: Value(fields[3].trim().isEmpty ? null : fields[3].trim()),
        color: Value(fields[4].trim().isEmpty ? null : fields[4].trim()),
        goalType: fields[5].trim(),
        exerciseId: Value(fields[6].trim().isEmpty ? null : fields[6].trim()),
        exerciseName: Value(fields[7].trim().isEmpty ? null : fields[7].trim()),
        targetValue: _parseDouble(fields[8]) ?? 0.0,
        currentValue: Value(_parseDouble(fields[9]) ?? 0.0),
        unit: fields[10].trim(),
        startDate: Value(_parseDateTime(fields[11])),
        targetDate: Value(_parseDateTime(fields[12])),
        isArchived: Value(_parseBool(fields[13])),
        displayOrder: Value(_parseInt(fields[14]) ?? 0),
        createdAt: Value(_parseDateTime(fields[15]) ?? DateTime.now()),
        updatedAt: Value(_parseDateTime(fields[16]) ?? DateTime.now()),
      );
    } catch (e) {
      print('Error creating goal companion: $e');
      return null;
    }
  }

  /// Parse a single category CSV line
  static ExerciseCategoriesCompanion? _parseCategoryLine(String line) {
    final fields = _parseCsvLine(line);
    
    if (fields.length < 9) {
      print('Category line has insufficient fields: ${fields.length}');
      return null;
    }

    try {
      return ExerciseCategoriesCompanion.insert(
        id: _uuid.v4(),
        categoryId: fields[1].trim(),
        name: fields[2].trim(),
        description: Value(fields[3].trim().isEmpty ? null : fields[3].trim()),
        color: Value(fields[4].trim().isEmpty ? null : fields[4].trim()),
        icon: Value(fields[5].trim().isEmpty ? null : fields[5].trim()),
        sortOrder: Value(_parseInt(fields[6]) ?? 0),
        isActive: Value(_parseBool(fields[7])),
        createdAt: Value(_parseDateTime(fields[8]) ?? DateTime.now()),
      );
    } catch (e) {
      print('Error creating category companion: $e');
      return null;
    }
  }

  /// Parse a single equipment CSV line
  static EquipmentCompanion? _parseEquipmentLine(String line) {
    final fields = _parseCsvLine(line);
    
    if (fields.length < 6) {
      print('Equipment line has insufficient fields: ${fields.length}');
      return null;
    }

    try {
      return EquipmentCompanion.insert(
        id: _uuid.v4(),
        equipmentId: fields[1].trim(),
        name: fields[2].trim(),
        description: Value(fields[3].trim().isEmpty ? null : fields[3].trim()),
        isActive: Value(_parseBool(fields[4])),
        createdAt: Value(_parseDateTime(fields[5]) ?? DateTime.now()),
      );
    } catch (e) {
      print('Error creating equipment companion: $e');
      return null;
    }
  }

  /// Parse a single goal progress CSV line
  static GoalProgressCompanion? _parseGoalProgressLine(String line) {
    final fields = _parseCsvLine(line);
    
    if (fields.length < 6) {
      print('Goal progress line has insufficient fields: ${fields.length}');
      return null;
    }

    try {
      return GoalProgressCompanion.insert(
        id: fields[0].trim(),
        goalId: fields[1].trim(),
        value: _parseDouble(fields[2]) ?? 0.0,
        notes: Value(fields[3].trim().isEmpty ? null : fields[3].trim()),
        recordedAt: _parseDateTime(fields[4]) ?? DateTime.now(),
        userId: fields[5].trim(),
      );
    } catch (e) {
      print('Error creating goal progress companion: $e');
      return null;
    }
  }

  /// Parse CSV line handling quoted fields properly
  static List<String> _parseCsvLine(String line) {
    final fields = <String>[];
    final buffer = StringBuffer();
    bool inQuotes = false;
    bool escapeNext = false;

    for (int i = 0; i < line.length; i++) {
      final char = line[i];
      
      if (escapeNext) {
        buffer.write(char);
        escapeNext = false;
        continue;
      }

      if (char == '\\') {
        escapeNext = true;
        continue;
      }

      if (char == '"') {
        inQuotes = !inQuotes;
        continue;
      }

      if (char == ',' && !inQuotes) {
        fields.add(buffer.toString());
        buffer.clear();
        continue;
      }

      buffer.write(char);
    }

    // Add the last field
    fields.add(buffer.toString());

    return fields;
  }

  /// Parse string to double
  static double? _parseDouble(String value) {
    if (value.trim().isEmpty) return null;
    return double.tryParse(value.trim());
  }

  /// Parse string to int
  static int? _parseInt(String value) {
    if (value.trim().isEmpty) return null;
    return int.tryParse(value.trim());
  }

  /// Parse string to bool
  static bool _parseBool(String value) {
    final trimmed = value.trim().toLowerCase();
    return trimmed == 'true' || trimmed == '1' || trimmed == 'yes';
  }

  /// Parse string to DateTime
  static DateTime? _parseDateTime(String value) {
    if (value.trim().isEmpty) return null;
    try {
      return DateTime.parse(value.trim());
    } catch (e) {
      return null;
    }
  }
}