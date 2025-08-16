import 'package:equatable/equatable.dart';

class Exercise extends Equatable {
  const Exercise({
    required this.id,
    required this.exerciseId,
    required this.name,
    required this.defaultEquipment,
    this.availableEquipment,
    this.exerciseTypes,
    this.primaryMuscles,
    this.secondaryMuscles,
    this.bodyParts,
    this.startingWeightLbs,
    this.startingWeightKg,
    this.defaultWarmupWeight,
    this.description,
    this.instructions,
    this.tips,
    this.videoUrl,
    this.imageUrlSmall,
    this.imageUrlLarge,
    this.hasCustomImage = false,
    this.difficultyLevel = 3,
    this.safetyRating = 3,
    this.isCompound = false,
    this.isUnilateral = false,
    this.requiresSpotter = false,
    this.isActive = true,
    this.isCustom = false,
    this.createdBy,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String exerciseId; // Original exercise identifier
  final String name;
  final String defaultEquipment; // Primary equipment
  final List<String>? availableEquipment; // Available equipment options
  final List<String>? exerciseTypes; // push, pull, upper, lower, etc.
  final List<String>? primaryMuscles; // Primary muscles worked
  final List<String>? secondaryMuscles; // Secondary muscles worked
  final List<String>? bodyParts; // upper_body, lower_body, core, full_body
  final double? startingWeightLbs; // Suggested starting weight in lbs
  final double? startingWeightKg; // Suggested starting weight in kg
  final double? defaultWarmupWeight; // Warmup weight suggestion
  final String? description; // Detailed description with setup/execution
  final String? instructions; // Step-by-step instructions
  final String? tips; // Additional tips and form cues
  final String? videoUrl; // Video demonstration URL
  final String? imageUrlSmall; // Small image URL
  final String? imageUrlLarge; // Large image URL
  final bool hasCustomImage; // Custom image flag
  final int difficultyLevel; // 1-5 difficulty scale
  final int safetyRating; // 1-5 safety rating
  final bool isCompound; // Compound vs isolation
  final bool isUnilateral; // Single limb exercise
  final bool requiresSpotter; // Spotter needed
  final bool isActive; // Active in database
  final bool isCustom; // User-created exercise
  final String? createdBy; // User ID for custom exercises
  final DateTime createdAt;
  final DateTime updatedAt;

  // Legacy compatibility getters
  String get category => isCompound ? 'compound' : 'isolation';
  String get primaryMuscleGroup => primaryMuscles?.first ?? 'unknown';
  List<String> get secondaryMuscleGroups => secondaryMuscles ?? [];
  String get equipment => defaultEquipment;
  String get difficulty {
    switch (difficultyLevel) {
      case 1:
      case 2:
        return 'beginner';
      case 3:
        return 'intermediate';
      case 4:
      case 5:
        return 'advanced';
      default:
        return 'intermediate';
    }
  }
  String? get imageUrl => imageUrlLarge ?? imageUrlSmall;

  @override
  List<Object?> get props => [
        id,
        exerciseId,
        name,
        defaultEquipment,
        availableEquipment,
        exerciseTypes,
        primaryMuscles,
        secondaryMuscles,
        bodyParts,
        startingWeightLbs,
        startingWeightKg,
        defaultWarmupWeight,
        description,
        instructions,
        tips,
        videoUrl,
        imageUrlSmall,
        imageUrlLarge,
        hasCustomImage,
        difficultyLevel,
        safetyRating,
        isCompound,
        isUnilateral,
        requiresSpotter,
        isActive,
        isCustom,
        createdBy,
        createdAt,
        updatedAt,
      ];

  Exercise copyWith({
    String? id,
    String? exerciseId,
    String? name,
    String? defaultEquipment,
    List<String>? availableEquipment,
    List<String>? exerciseTypes,
    List<String>? primaryMuscles,
    List<String>? secondaryMuscles,
    List<String>? bodyParts,
    double? startingWeightLbs,
    double? startingWeightKg,
    double? defaultWarmupWeight,
    String? description,
    String? instructions,
    String? tips,
    String? videoUrl,
    String? imageUrlSmall,
    String? imageUrlLarge,
    bool? hasCustomImage,
    int? difficultyLevel,
    int? safetyRating,
    bool? isCompound,
    bool? isUnilateral,
    bool? requiresSpotter,
    bool? isActive,
    bool? isCustom,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Exercise(
      id: id ?? this.id,
      exerciseId: exerciseId ?? this.exerciseId,
      name: name ?? this.name,
      defaultEquipment: defaultEquipment ?? this.defaultEquipment,
      availableEquipment: availableEquipment ?? this.availableEquipment,
      exerciseTypes: exerciseTypes ?? this.exerciseTypes,
      primaryMuscles: primaryMuscles ?? this.primaryMuscles,
      secondaryMuscles: secondaryMuscles ?? this.secondaryMuscles,
      bodyParts: bodyParts ?? this.bodyParts,
      startingWeightLbs: startingWeightLbs ?? this.startingWeightLbs,
      startingWeightKg: startingWeightKg ?? this.startingWeightKg,
      defaultWarmupWeight: defaultWarmupWeight ?? this.defaultWarmupWeight,
      description: description ?? this.description,
      instructions: instructions ?? this.instructions,
      tips: tips ?? this.tips,
      videoUrl: videoUrl ?? this.videoUrl,
      imageUrlSmall: imageUrlSmall ?? this.imageUrlSmall,
      imageUrlLarge: imageUrlLarge ?? this.imageUrlLarge,
      hasCustomImage: hasCustomImage ?? this.hasCustomImage,
      difficultyLevel: difficultyLevel ?? this.difficultyLevel,
      safetyRating: safetyRating ?? this.safetyRating,
      isCompound: isCompound ?? this.isCompound,
      isUnilateral: isUnilateral ?? this.isUnilateral,
      requiresSpotter: requiresSpotter ?? this.requiresSpotter,
      isActive: isActive ?? this.isActive,
      isCustom: isCustom ?? this.isCustom,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}