import 'dart:convert';
import 'package:drift/drift.dart';
import '../../domain/entities/exercise.dart' as domain;
import '../datasources/database.dart';

extension ExerciseModel on domain.Exercise {
  /// Converts domain entity to database row
  ExercisesCompanion toCompanion() {
    return ExercisesCompanion.insert(
      id: id,
      exerciseId: exerciseId,
      name: name,
      defaultEquipment: defaultEquipment,
      availableEquipment: Value(availableEquipment?.isNotEmpty == true
          ? jsonEncode(availableEquipment)
          : null),
      exerciseTypes: Value(exerciseTypes?.isNotEmpty == true
          ? jsonEncode(exerciseTypes)
          : null),
      primaryMuscles: Value(primaryMuscles?.isNotEmpty == true
          ? jsonEncode(primaryMuscles)
          : null),
      secondaryMuscles: Value(secondaryMuscles?.isNotEmpty == true
          ? jsonEncode(secondaryMuscles)
          : null),
      bodyParts: Value(bodyParts?.isNotEmpty == true
          ? jsonEncode(bodyParts)
          : null),
      startingWeightLbs: Value(startingWeightLbs),
      startingWeightKg: Value(startingWeightKg),
      defaultWarmupWeight: Value(defaultWarmupWeight),
      description: Value(description),
      instructions: Value(instructions),
      tips: Value(tips),
      videoUrl: Value(videoUrl),
      imageUrlSmall: Value(imageUrlSmall),
      imageUrlLarge: Value(imageUrlLarge),
      hasCustomImage: Value(hasCustomImage),
      difficultyLevel: Value(difficultyLevel),
      safetyRating: Value(safetyRating),
      isCompound: Value(isCompound),
      isUnilateral: Value(isUnilateral),
      requiresSpotter: Value(requiresSpotter),
      isActive: Value(isActive),
      isCustom: Value(isCustom),
      createdBy: Value(createdBy),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }
}

extension ExerciseFromDb on Exercise {
  /// Converts database row to domain entity
  domain.Exercise toEntity() {
    List<String> parseJsonList(String? jsonString) {
      if (jsonString == null || jsonString.isEmpty) return [];
      try {
        final decoded = jsonDecode(jsonString) as List;
        return decoded.cast<String>();
      } catch (e) {
        return [];
      }
    }

    return domain.Exercise(
      id: id,
      exerciseId: exerciseId,
      name: name,
      defaultEquipment: defaultEquipment,
      availableEquipment: parseJsonList(availableEquipment),
      exerciseTypes: parseJsonList(exerciseTypes),
      primaryMuscles: parseJsonList(primaryMuscles),
      secondaryMuscles: parseJsonList(secondaryMuscles),
      bodyParts: parseJsonList(bodyParts),
      startingWeightLbs: startingWeightLbs,
      startingWeightKg: startingWeightKg,
      defaultWarmupWeight: defaultWarmupWeight,
      description: description,
      instructions: instructions,
      tips: tips,
      videoUrl: videoUrl,
      imageUrlSmall: imageUrlSmall,
      imageUrlLarge: imageUrlLarge,
      hasCustomImage: hasCustomImage,
      difficultyLevel: difficultyLevel,
      safetyRating: safetyRating,
      isCompound: isCompound,
      isUnilateral: isUnilateral,
      requiresSpotter: requiresSpotter,
      isActive: isActive,
      isCustom: isCustom,
      createdBy: createdBy,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}