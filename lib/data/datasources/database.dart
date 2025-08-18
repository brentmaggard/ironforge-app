import 'package:drift/drift.dart';
import 'database_connection.dart';
import 'csv_seeder.dart';

// Import tables
part 'database.g.dart';

/// Users table for user profiles and settings
class Users extends Table {
  TextColumn get id => text().withLength(min: 1, max: 36)();
  TextColumn get email => text().withLength(min: 1, max: 255)();
  TextColumn get firstName => text().withLength(min: 1, max: 100)();
  TextColumn get lastName => text().withLength(min: 1, max: 100)();
  DateTimeColumn get dateOfBirth => dateTime().nullable()();
  TextColumn get gender => text().withLength(min: 1, max: 20).nullable()();
  RealColumn get height => real().nullable()();
  RealColumn get weight => real().nullable()();
  TextColumn get experienceLevel => text().withLength(min: 1, max: 20).withDefault(const Constant('beginner'))();
  TextColumn get preferences => text().nullable()(); // JSON string for app preferences
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  IntColumn get version => integer().withDefault(const Constant(1))();
  TextColumn get syncStatus => text().withLength(min: 1, max: 20).withDefault(const Constant('local'))();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Goals table for user goals and progress tracking
class Goals extends Table {
  TextColumn get id => text().withLength(min: 1, max: 36)();
  TextColumn get userId => text().withLength(min: 1, max: 36)();
  TextColumn get name => text().withLength(min: 1, max: 200)(); // Goal name
  TextColumn get description => text().nullable()(); // Goal description
  TextColumn get color => text().withLength(min: 1, max: 10).nullable()(); // Hex color code
  TextColumn get goalType => text().withLength(min: 1, max: 50)(); // strength, weight, endurance, etc.
  TextColumn get exerciseId => text().withLength(min: 1, max: 36).nullable()(); // Associated exercise
  TextColumn get exerciseName => text().withLength(min: 1, max: 200).nullable()(); // Exercise name for display
  RealColumn get targetValue => real()();
  RealColumn get currentValue => real().withDefault(const Constant(0.0))();
  TextColumn get unit => text().withLength(min: 1, max: 20)(); // lbs, kg, reps, minutes
  DateTimeColumn get startDate => dateTime().nullable()(); // Goal start date
  DateTimeColumn get targetDate => dateTime().nullable()(); // Goal target date
  BoolColumn get isArchived => boolean().withDefault(const Constant(false))(); // Archived goals
  IntColumn get displayOrder => integer().withDefault(const Constant(0))(); // Sort order
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get completedAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  IntColumn get version => integer().withDefault(const Constant(1))();
  TextColumn get syncStatus => text().withLength(min: 1, max: 20).withDefault(const Constant('local'))();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Exercises table for exercise database (~180 exercises)
class Exercises extends Table {
  TextColumn get id => text().withLength(min: 1, max: 36)();
  TextColumn get exerciseId => text().withLength(min: 1, max: 100)(); // Original exercise identifier
  TextColumn get name => text().withLength(min: 1, max: 200)();
  TextColumn get defaultEquipment => text().withLength(min: 1, max: 100)(); // Primary equipment
  TextColumn get availableEquipment => text().nullable()(); // JSON array of available equipment
  TextColumn get exerciseTypes => text().nullable()(); // JSON array (push, pull, upper, lower, etc.)
  TextColumn get primaryMuscles => text().nullable()(); // JSON array of primary muscles
  TextColumn get secondaryMuscles => text().nullable()(); // JSON array of secondary muscles
  TextColumn get bodyParts => text().nullable()(); // JSON array (upper_body, lower_body, core, full_body)
  TextColumn get targetMuscleGroups => text().nullable()(); // JSON array for muscle map - target muscles
  TextColumn get synergistMuscleGroups => text().nullable()(); // JSON array for muscle map - synergist muscles
  RealColumn get startingWeightLbs => real().nullable()(); // Suggested starting weight in lbs
  RealColumn get startingWeightKg => real().nullable()(); // Suggested starting weight in kg
  RealColumn get defaultWarmupWeight => real().nullable()(); // Warmup weight suggestion
  TextColumn get description => text().nullable()(); // Detailed description with setup/execution
  TextColumn get instructions => text().nullable()(); // Step-by-step instructions
  TextColumn get tips => text().nullable()(); // Additional tips and form cues
  TextColumn get videoUrl => text().nullable()(); // Video demonstration URL
  TextColumn get imageUrlSmall => text().nullable()(); // Small image URL
  TextColumn get imageUrlLarge => text().nullable()(); // Large image URL
  BoolColumn get hasCustomImage => boolean().withDefault(const Constant(false))(); // Custom image flag
  IntColumn get difficultyLevel => integer().withDefault(const Constant(3))(); // 1-5 difficulty scale
  IntColumn get safetyRating => integer().withDefault(const Constant(3))(); // 1-5 safety rating
  BoolColumn get isCompound => boolean().withDefault(const Constant(false))(); // Compound vs isolation
  BoolColumn get isUnilateral => boolean().withDefault(const Constant(false))(); // Single limb exercise
  BoolColumn get requiresSpotter => boolean().withDefault(const Constant(false))(); // Spotter needed
  BoolColumn get isActive => boolean().withDefault(const Constant(true))(); // Active in database
  BoolColumn get isCustom => boolean().withDefault(const Constant(false))(); // User-created exercise
  TextColumn get createdBy => text().withLength(min: 1, max: 36).nullable()(); // User ID for custom exercises
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  IntColumn get version => integer().withDefault(const Constant(1))();
  TextColumn get syncStatus => text().withLength(min: 1, max: 20).withDefault(const Constant('local'))();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Programs table for workout programs and templates
class Programs extends Table {
  TextColumn get id => text().withLength(min: 1, max: 36)();
  TextColumn get name => text().withLength(min: 1, max: 200)();
  TextColumn get description => text().nullable()();
  TextColumn get author => text().nullable()(); // Program author
  TextColumn get difficulty => text().withLength(min: 1, max: 20).withDefault(const Constant('intermediate'))(); // beginner, intermediate, advanced
  IntColumn get frequency => integer().nullable()(); // days per week
  IntColumn get durationWeeks => integer().nullable()(); // program duration
  TextColumn get tags => text().nullable()(); // JSON array of tags ["strength", "powerlifting"]
  TextColumn get config => text()(); // JSON program configuration
  BoolColumn get isTemplate => boolean().withDefault(const Constant(false))(); // template vs user program
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  IntColumn get version => integer().withDefault(const Constant(1))();
  TextColumn get syncStatus => text().withLength(min: 1, max: 20).withDefault(const Constant('local'))();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// UserPrograms table for user program instances and progress
class UserPrograms extends Table {
  TextColumn get id => text().withLength(min: 1, max: 36)();
  TextColumn get userId => text().withLength(min: 1, max: 36)();
  TextColumn get programId => text().withLength(min: 1, max: 36)();
  DateTimeColumn get startDate => dateTime()(); // When user started the program
  IntColumn get currentWeek => integer().withDefault(const Constant(1))(); // Current week in program
  IntColumn get currentDay => integer().withDefault(const Constant(1))(); // Current day in week
  TextColumn get status => text().withLength(min: 1, max: 20).withDefault(const Constant('active'))(); // active, completed, paused
  TextColumn get customizations => text().nullable()(); // JSON user modifications to program
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  IntColumn get version => integer().withDefault(const Constant(1))();
  TextColumn get syncStatus => text().withLength(min: 1, max: 20).withDefault(const Constant('local'))();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// ProgramSessions table for tracking program workout sessions
class ProgramSessions extends Table {
  TextColumn get id => text().withLength(min: 1, max: 36)();
  TextColumn get userProgramId => text().withLength(min: 1, max: 36)();
  IntColumn get weekNumber => integer()(); // Week in program
  IntColumn get dayNumber => integer()(); // Day in week
  TextColumn get workoutId => text().withLength(min: 1, max: 36).nullable()(); // References workouts table when completed
  DateTimeColumn get scheduledDate => dateTime().nullable()(); // Scheduled workout date
  DateTimeColumn get completedAt => dateTime().nullable()(); // When workout was completed
  TextColumn get status => text().withLength(min: 1, max: 20).withDefault(const Constant('scheduled'))(); // scheduled, completed, skipped
  TextColumn get notes => text().nullable()(); // Session notes
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  IntColumn get version => integer().withDefault(const Constant(1))();
  TextColumn get syncStatus => text().withLength(min: 1, max: 20).withDefault(const Constant('local'))();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Workouts table for workout sessions
class Workouts extends Table {
  TextColumn get id => text().withLength(min: 1, max: 36)();
  TextColumn get userId => text().withLength(min: 1, max: 36)();
  TextColumn get programId => text().withLength(min: 1, max: 36).nullable()();
  TextColumn get name => text().withLength(min: 1, max: 200)();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get startedAt => dateTime().nullable()();
  DateTimeColumn get completedAt => dateTime().nullable()();
  IntColumn get totalSets => integer().withDefault(const Constant(0))();
  IntColumn get totalReps => integer().withDefault(const Constant(0))();
  RealColumn get totalVolume => real().withDefault(const Constant(0.0))(); // total weight * reps
  IntColumn get durationMinutes => integer().nullable()();
  TextColumn get status => text().withLength(min: 1, max: 20).withDefault(const Constant('planned'))(); // planned, in_progress, completed
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  IntColumn get version => integer().withDefault(const Constant(1))();
  TextColumn get syncStatus => text().withLength(min: 1, max: 20).withDefault(const Constant('local'))();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// WorkoutSets table for individual sets with reps/weight/RPE
class WorkoutSets extends Table {
  TextColumn get id => text().withLength(min: 1, max: 36)();
  TextColumn get workoutId => text().withLength(min: 1, max: 36)();
  TextColumn get exerciseId => text().withLength(min: 1, max: 36)();
  IntColumn get setNumber => integer()();
  IntColumn get reps => integer()();
  RealColumn get weight => real()();
  RealColumn get rpe => real().nullable()(); // Rate of Perceived Exertion (1-10)
  IntColumn get restSeconds => integer().nullable()();
  TextColumn get notes => text().nullable()();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get completedAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  IntColumn get version => integer().withDefault(const Constant(1))();
  TextColumn get syncStatus => text().withLength(min: 1, max: 20).withDefault(const Constant('local'))();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// ProgressEntries table for progress tracking data
class ProgressEntries extends Table {
  TextColumn get id => text().withLength(min: 1, max: 36)();
  TextColumn get userId => text().withLength(min: 1, max: 36)();
  TextColumn get type => text().withLength(min: 1, max: 50)(); // weight, measurement, photo, exercise_pr
  TextColumn get exerciseId => text().withLength(min: 1, max: 36).nullable()(); // for exercise PRs
  RealColumn get value => real()();
  TextColumn get unit => text().withLength(min: 1, max: 20)();
  TextColumn get bodyPart => text().withLength(min: 1, max: 50).nullable()(); // for measurements
  TextColumn get notes => text().nullable()();
  TextColumn get photoUrl => text().nullable()();
  DateTimeColumn get recordedAt => dateTime()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  IntColumn get version => integer().withDefault(const Constant(1))();
  TextColumn get syncStatus => text().withLength(min: 1, max: 20).withDefault(const Constant('local'))();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Equipment table for exercise equipment types
class Equipment extends Table {
  TextColumn get id => text().withLength(min: 1, max: 36)();
  TextColumn get equipmentId => text().withLength(min: 1, max: 100)(); // Original equipment identifier
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get description => text().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

/// ExerciseCategories table for exercise categorization
class ExerciseCategories extends Table {
  TextColumn get id => text().withLength(min: 1, max: 36)();
  TextColumn get categoryId => text().withLength(min: 1, max: 100)(); // Original category identifier
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get description => text().nullable()();
  TextColumn get color => text().withLength(min: 1, max: 10).nullable()(); // Hex color code
  TextColumn get icon => text().nullable()(); // Icon identifier
  IntColumn get sortOrder => integer().withDefault(const Constant(0))(); // Display order
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

/// GoalProgress table for tracking goal progress over time
class GoalProgress extends Table {
  TextColumn get id => text().withLength(min: 1, max: 36)();
  TextColumn get goalId => text().withLength(min: 1, max: 36)();
  RealColumn get value => real()(); // Progress value
  TextColumn get notes => text().nullable()(); // Progress notes
  DateTimeColumn get recordedAt => dateTime()(); // When progress was recorded
  TextColumn get userId => text().withLength(min: 1, max: 36)(); // User who recorded progress
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

/// ExerciseFavorites table for user favorite exercises
class ExerciseFavorites extends Table {
  TextColumn get id => text().withLength(min: 1, max: 36)();
  TextColumn get userId => text().withLength(min: 1, max: 36)();
  TextColumn get exerciseId => text().withLength(min: 1, max: 36)();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

/// Main database class
@DriftDatabase(tables: [
  Users,
  Goals,
  Exercises,
  Programs,
  UserPrograms,
  ProgramSessions,
  Workouts,
  WorkoutSets,
  ProgressEntries,
  Equipment,
  ExerciseCategories,
  GoalProgress,
  ExerciseFavorites,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(AppDatabaseConnection.getConnection());
  AppDatabase.forTesting(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 6;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
    },
    onUpgrade: (Migrator m, int from, int to) async {
      if (from <= 5 && to >= 6) {
        print('Running database migration from version $from to $to');
        
        // Add muscle map columns to exercises table
        await m.addColumn(exercises, exercises.targetMuscleGroups);
        await m.addColumn(exercises, exercises.synergistMuscleGroups);
        
        print('Database migration completed - added muscle map columns to exercises table');
      } else if (from <= 4 && to >= 5) {
        print('Running database migration from version $from to $to');
        
        // Add new program-related tables for Program Builder System
        await m.createTable($UserProgramsTable(this));
        await m.createTable($ProgramSessionsTable(this));
        
        // Update Programs table structure - drop and recreate with new schema
        await m.deleteTable('programs');
        await m.createTable($ProgramsTable(this));
        
        print('Database migration completed - added UserPrograms, ProgramSessions tables and updated Programs schema');
      } else if (from <= 3 && to >= 4) {
        print('Running database migration from version $from to $to');
        
        // Add the new ExerciseFavorites table
        await m.createTable(exerciseFavorites);
        
        print('Database migration completed - added ExerciseFavorites table');
      } else if (from <= 2 && to >= 3) {
        print('Running database migration from version $from to $to');
        
        // For schema v3, completely recreate all tables to ensure proper structure
        // This handles cases where columns might be missing due to migration issues
        
        // Drop all tables
        await m.deleteTable('exercises');
        await m.deleteTable('goals');
        await m.deleteTable('equipment');
        await m.deleteTable('exercise_categories');
        await m.deleteTable('goal_progress');
        await m.deleteTable('users');
        await m.deleteTable('programs');
        await m.deleteTable('workouts');
        await m.deleteTable('workout_sets');
        await m.deleteTable('progress_entries');

        // Recreate all tables with current schema
        await m.createAll();

        print('Database migration completed, will seed with fresh data');
        // Re-seed data after migration
        await CsvSeeder.seedAllData(this);
      }
    },
  );
}