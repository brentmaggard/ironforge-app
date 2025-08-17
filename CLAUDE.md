# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

IronForge Flutter is a cross-platform workout tracking application being ported from the existing Next.js web app (https://github.com/brentmaggard/ironforge). The Flutter version will run on iOS, Android, and web platforms with offline-first capabilities and eventual Supabase synchronization.

## Current Status

**PROJECT STATUS**: ✅ **PHASE 4 IN PROGRESS** - Goals, Exercise Database, Favorites & Program Builder Systems Complete, Navigation Enhanced, Workout Logging Next

**COMPLETED**:
- ✅ Flutter SDK installation and setup
- ✅ Flutter project initialization with clean architecture structure
- ✅ Core dependencies configured (Riverpod, go_router, Drift, fl_chart, uuid)
- ✅ Material 3 theming implementation
- ✅ Navigation structure with bottom navigation bar
- ✅ Basic screen scaffolds for all major features
- ✅ App compiles and runs successfully on web, iOS, Android
- ✅ All screens accessible via bottom navigation
- ✅ Material 3 theme applied consistently
- ✅ Clean architecture folder structure implemented

**DATABASE LAYER (Phase 3) - COMPLETED** ✅:
- ✅ **Enhanced Drift Database**: 14 tables with comprehensive schema and JSON data integration (Schema v5)
- ✅ **Production Exercise Database**: 52 real exercises from original IronForge web app via JSON import
- ✅ **Rich Exercise Metadata**: Detailed instructions, tips, safety ratings, difficulty levels (1-5), starting weights
- ✅ **Exercise Categorization**: 14 exercise categories and 18 equipment types with comprehensive classifications
- ✅ **Database Migration**: Schema v4 with exercise favorites table and enhanced exercise fields
- ✅ **JSON Parser & Seeder**: Robust import system for production-quality exercise data
- ✅ **Exercise Favorites System**: User favorite exercises with persistent storage
- ✅ **Repository Pattern**: Clean architecture with domain entities and data models
- ✅ **Riverpod Integration**: Database providers with dependency injection
- ✅ **Type Safety**: Proper entity conversions between domain/database layers
- ✅ **Sync-Ready Schema**: Timestamps, versioning, and sync status fields
- ✅ **Web Database Compatibility**: Demo mode implementation for web platform

**GOALS SYSTEM (Phase 4.1) - COMPLETED** ✅:
- ✅ **Complete Goals Screen**: Stats overview, goal cards, and empty state handling
- ✅ **Goal Creation Dialog**: Multi-type goals (strength, weight, endurance, flexibility, body composition, habit)
- ✅ **Progress Tracking**: Visual progress bars, percentage completion, and status indicators
- ✅ **Goal Management**: Progress updates, goal completion, and real-time UI refresh
- ✅ **Comprehensive Goal Types**: 6 goal types with proper validation and icons
- ✅ **Target Date Support**: Optional deadlines with overdue detection
- ✅ **Async Provider Pattern**: Riverpod FutureProvider for efficient data loading

**EXERCISE DATABASE SYSTEM (Phase 4.2a) - COMPLETED** ✅:
- ✅ **JSON Data Integration**: Successfully imported 52 production exercises from original IronForge web app
- ✅ **Enhanced Database Schema**: Rich exercise fields with comprehensive metadata and production-quality data
- ✅ **Searchable Exercise Library**: Real-time text search across exercise names, categories, and muscle groups
- ✅ **Advanced Filtering System**: Filter by muscle group (14 categories), equipment type (18 types), and difficulty level
- ✅ **Visual Exercise Display**: Card-based layout with exercise icons, difficulty badges, and comprehensive metadata
- ✅ **Sorting Capabilities**: Sort exercises by name, difficulty level, or muscle group
- ✅ **Filter Management**: Interactive filter chips with clear functionality and visual indicators
- ✅ **Empty State Handling**: Proper UI for no results and clear filter options
- ✅ **Production Data Quality**: Detailed exercise descriptions, setup instructions, execution steps, and safety tips
- ✅ **Legacy Compatibility**: Backward-compatible getters ensure existing UI code continues to work
- ✅ **Material 3 Integration**: Full theme compliance with proper color coding and typography

**EXERCISE DETAIL & FAVORITES SYSTEM (Phase 4.2b) - COMPLETED** ✅:
- ✅ **Comprehensive Exercise Detail Views**: Rich instruction screens with complete exercise metadata
- ✅ **Exercise Images and Visual Guides**: Icon-based exercise representation with gradient backgrounds
- ✅ **Detailed Information Display**: Tips, muscle targeting, difficulty ratings, safety scores, and starting weights
- ✅ **Exercise Favoriting System**: Persistent heart toggle with database storage and real-time state management
- ✅ **Navigation Integration**: Seamless navigation from exercise list to detail view with parameter passing
- ✅ **Favorites Management**: Filter exercises by favorites, visual indicators, and favorites-only view
- ✅ **Database Schema Enhancement**: ExerciseFavorites table with proper migration (Schema v4)
- ✅ **State Management**: Riverpod providers for reactive favorites management across screens
- ✅ **Visual Design**: Material 3 compliance with proper theming and user experience patterns

**PROGRAM BUILDER SYSTEM (Phase 4.3) - COMPLETED** ✅:
1. **Program Database Schema** ✅ **COMPLETED**
   - ✅ Database schema migration to v5 with 3 program tables (Programs, UserPrograms, ProgramSessions)
   - ✅ Program entities and data models with JSON configuration support
   - ✅ Repository pattern implementation with clean architecture
   - ✅ Program template seeding system with production data
   
2. **Starter Program Templates** ✅ **COMPLETED**
   - ✅ Basic Beginner Routine with 3-month linear progression
   - ✅ StrongLifts 5x5 with compound lift focus and progressive overload
   - ✅ Starting Strength with 3x5 barbell program methodology
   - ✅ 5/3/1 for Beginners with percentage-based progression system

3. **Program Builder UI** ✅ **COMPLETED**
   - ✅ Program template library with search and filtering capabilities
   - ✅ Rich program detail screens with workout breakdowns and statistics
   - ✅ User program management (start, pause, resume, progress tracking)
   - ✅ Tab-based navigation between templates and active programs

4. **Progression & Workout Generation** ✅ **COMPLETED**
   - ✅ ProgressionService with linear, percentage, and session-based progression
   - ✅ WorkoutGenerationService for automatic workout creation from programs
   - ✅ Smart weight calculation with deload protocols and AMRAP set support
   - ✅ Service provider architecture for clean integration with UI

**NAVIGATION ENHANCEMENT (Phase 4.4) - COMPLETED** ✅:
1. **Drawer Navigation System** ✅ **COMPLETED**
   - ✅ Hamburger menu drawer with gradient header and branded design
   - ✅ Programs screen accessible via drawer navigation
   - ✅ Secondary navigation for overflow menu items (Settings, About, Plate Calculator)
   - ✅ Mobile-optimized navigation structure with proper theming

**IMMEDIATE NEXT STEPS (Phase 4.5 - Workout Session Integration)**:
1. **Active Workout Session Screen** 🔄 **NEXT PRIORITY**
   - Workout session interface with program-generated workouts
   - Real-time set tracking with reps, weight, and RPE logging
   - Rest timer functionality and workout flow management
   
## How to Access Program Builder Features

**Programs Screen**: 
- Open the app and tap the **hamburger menu (☰)** in the top-left corner
- Select **"Programs"** from the drawer menu
- Browse program templates in the "Templates" tab
- Manage active programs in the "My Programs" tab

**Program Features Available**:
- 4 starter program templates (Basic Beginner, StrongLifts 5x5, Starting Strength, 5/3/1)
- Program filtering by difficulty level
- Detailed program information with workout breakdowns
- Start/pause/resume program functionality
- Progress tracking with completion percentages

2. **Workout Management** 🔲 **PENDING**
   - Program-generated workout completion tracking
   - Exercise reordering and workout customization
   - Workout templates independent of programs
   
3. **Plate Calculator** 🔲 **PENDING**
   - Visual barbell loading interface
   - Weight calculation and optimization
   - Multiple plate and barbell configurations

## Implementation Plan

**IMPORTANT**: See [PLAN.md](./PLAN.md) for the complete implementation roadmap and task breakdown. The plan follows a UI-first approach across 7 phases:

1. **Phase 1**: Project Foundation & Architecture ✅
2. **Phase 2**: UI/UX Foundation ✅
3. **Phase 3**: Local Database & Data Layer ✅
4. **Phase 4**: Core Feature Implementation (CURRENT)
5. **Phase 5**: Advanced Features
6. **Phase 6**: Quality & Testing
7. **Phase 7**: Future-Ready Enhancements

## Architecture

**Clean Architecture Pattern:**
- `lib/presentation/` - UI components, screens, and widgets
- `lib/domain/` - Business logic, entities, and use cases
- `lib/data/` - Repositories, data sources, and models

**Key Technologies:**
- **State Management**: Riverpod
- **Local Database**: Drift (SQLite)
- **Navigation**: go_router
- **UI**: Material 3
- **Charts**: fl_chart
- **Future Backend**: Supabase

## Prerequisites

**IMPORTANT**: Before starting development, ensure Flutter SDK is installed:

```bash
# Install Flutter (macOS)
brew install --cask flutter

# Verify installation
flutter doctor
flutter --version
```

Additional requirements: Xcode, Android Studio, Chrome

## Development Commands

**Current Project Status**: ✅ **Goals, Exercise System, Favorites, Program Builder & Navigation Complete** - Workout Logging Next

```bash
# Development
flutter run                                           # Run on connected device
flutter run -d chrome                               # Run on web
flutter run -d web-server --web-port 8080          # Run on web server
flutter run --hot                                   # Hot reload enabled

# Code Quality
flutter analyze                                     # Static analysis
dart format lib/                                    # Format code
flutter test                                        # Run tests

# Database Code Generation (when adding Drift tables)
dart run build_runner build                        # Generate database code
dart run build_runner watch                        # Watch and generate on changes

# Build
flutter build apk                                   # Android APK
flutter build ios                                   # iOS build
flutter build web                                   # Web build

# Dependencies
flutter pub get                                     # Install dependencies
flutter pub upgrade                                 # Upgrade dependencies
```

## Key Features to Implement

Based on the original web app, implement these core features:

1. **Dashboard** - Overview with stats and quick actions
2. **Goals System** - Goal creation, tracking, and progress visualization
3. **Workout Logging** - Session management, set logging, timers
4. **Program Management** - Program builder with JSON configuration
5. **Progress Charts** - Strength, volume, and measurement tracking
6. **Exercise Database** - Production-quality library with 52 real exercises from original IronForge
7. **Plate Calculator** - Visual barbell loading tool

## Database Schema ✅ **IMPLEMENTED**

**Core Tables Completed**:
- ✅ `users` - User profiles and settings with experience levels
- ✅ `goals` - Enhanced user goals and targets with progress tracking, colors, and exercise associations
- ✅ `exercises` - **Production exercise database** with 52 real exercises from original IronForge web app
- ✅ `programs` - **Program templates and definitions** with JSON configuration and metadata (Schema v5)
- ✅ `user_programs` - **User program instances** with progress tracking and status management (Schema v5)
- ✅ `program_sessions` - **Program workout sessions** with scheduling and completion tracking (Schema v5)
- ✅ `workouts` - Workout sessions with status tracking
- ✅ `workout_sets` - Individual sets with reps/weight/RPE
- ✅ `progress_entries` - Progress tracking data with multiple types
- ✅ `equipment` - Exercise equipment types and categories (18 types)
- ✅ `exercise_categories` - Exercise categorization system (14 categories)
- ✅ `goal_progress` - Goal progress tracking over time
- ✅ `exercise_favorites` - User favorite exercises with persistent storage

**Implemented Schema Features**:
- ✅ **UUID Primary Keys** - All tables use UUID for distributed system readiness
- ✅ **Sync-Ready Fields** - `created_at`, `updated_at`, `version`, `sync_status`, `deleted_at`
- ✅ **Enhanced Exercise Fields** - Rich metadata including difficulty levels (1-5), safety ratings, starting weights
- ✅ **JSON Data Integration** - Production-quality exercise data imported from original IronForge web app
- ✅ **Data Integrity** - Proper constraints, nullable fields, and default values
- ✅ **Exercise Categorization** - Comprehensive metadata with 14 categories and 18 equipment types
- ✅ **JSON Storage** - Secondary muscle groups, available equipment, exercise types, and program configurations
- ✅ **Database Migration** - Schema v5 with program system tables and enhanced program support

**Production Exercise Database Content**:
- ✅ **52 Real Exercises** imported from original IronForge web app via JSON
- ✅ **Comprehensive Exercise Data** - Detailed setup instructions, execution steps, safety tips, and form cues
- ✅ **Rich Metadata** - Difficulty levels (1-5), safety ratings (1-5), starting weights (lbs/kg), warmup suggestions
- ✅ **14 Exercise Categories** - Push, pull, legs, core, cardio, power, flexibility, posterior, glutes, arms, grip, quad, mobility
- ✅ **18 Equipment Types** - Barbell, dumbbell, machine, bodyweight, cable, kettlebell, resistance band, battle ropes, sled, etc.
- ✅ **Exercise Classifications** - Compound vs isolation flags, unilateral exercises, spotter requirements
- ✅ **Muscle Group Targeting** - Primary and secondary muscle group tracking with JSON arrays
- ✅ **Body Part Categories** - Upper body, lower body, core, full body classifications

## Development Priorities

### ✅ Completed (Phases 1-4.2b)
1. **Project Foundation** - Clean architecture, dependencies, folder structure
2. **UI Foundation** - Material 3 theme, navigation, responsive layouts
3. **Core Screens** - Skeleton screens for all major features with functional dashboard
4. **Database Layer & JSON Integration** - Complete Drift database implementation with production data
   - ✅ 11 comprehensive database tables with enhanced schema and JSON data integration (Schema v4)
   - ✅ **Production exercise database** with 52 real exercises from original IronForge web app
   - ✅ **JSON Parser & Seeder** with robust import system for production-quality data
   - ✅ **Database migration** from schema v1 to v4 with exercise favorites and rich metadata
   - ✅ Repository pattern with clean architecture and enhanced domain entities
   - ✅ Riverpod providers and dependency injection
   - ✅ Type-safe entity conversions and data models with backward compatibility
   - ✅ Database initialization, testing, and JSON import verification

5. **Core Feature Implementation** - Functional features with production data **COMPLETED**
   - ✅ **Goals system with creation, tracking, and progress visualization** **COMPLETED**
   - ✅ **Exercise database system with JSON data integration** **COMPLETED**
     - ✅ Production-quality exercise data imported from original IronForge
     - ✅ Advanced search and filtering with 14 categories and 18 equipment types
     - ✅ Rich exercise metadata with instructions, tips, and safety ratings
   - ✅ **Exercise detail views with comprehensive instructions and favoriting** **COMPLETED**
     - ✅ Comprehensive exercise detail screens with rich UI components
     - ✅ Exercise favoriting system with persistent database storage
     - ✅ Favorites management and filtering across the app
     - ✅ Navigation integration and state management with Riverpod

### 🚧 Current Focus (Phase 4.3)
6. **Program Builder System** - Structured workout programming
   - 🔄 **Database schema migration to v5 with program tables** **NEXT**
   - 🔲 Program entities and data models creation
   - 🔲 Starter program templates (Basic Beginner, StrongLifts 5x5, Starting Strength)
   - 🔲 Program builder UI with template library and custom creator
   - 🔲 Progression engine with auto-weight calculation
   - 🔲 Program execution and workout generation

### 🔮 Upcoming
7. **Workout Logging Integration** - Program-driven workout sessions
   - Workout session screen with program context
   - Set logging with progression tracking
   - Rest timers and program-guided flow
   - Exercise selection and program integration

8. **Advanced Features** - Enhanced functionality and integrations
   - Progress analytics with charts and trends  
   - Plate calculator with visual barbell loading
   - Advanced program features (sharing, analytics)
   - Sync preparation for backend integration

9. **Testing & Polish** - Comprehensive testing and optimization

## Code Conventions

- Use `const` constructors wherever possible
- Follow Dart naming conventions (camelCase, PascalCase)
- Implement proper error handling with user-friendly messages
- Use Riverpod providers for state management
- Keep widgets focused and composable
- Write comprehensive tests for business logic

## Architecture Details

**Current Structure**:
```
lib/
├── core/
│   ├── constants/     # App constants
│   ├── errors/        # Failure classes (future)
│   ├── providers/     # Global Riverpod providers (database_providers.dart)
│   └── utils/         # Theme, routing, utilities
├── data/
│   ├── datasources/   # Database, LocalDataSource, exercise_seeder
│   ├── models/        # Entity converters (exercise_model, goal_model)
│   └── repositories/  # Repository implementations
├── domain/
│   ├── entities/      # Business entities (exercise, goal, workout, workout_set)
│   ├── repositories/  # Repository interfaces
│   └── usecases/      # Business logic (future)
└── presentation/
    ├── screens/       # UI screens (dashboard_screen with database integration)
    ├── widgets/       # Reusable UI components (main_navigation)
    └── providers/     # UI state providers (future)
```

**Repository Pattern**:
- `LocalDataSource` (Drift) for offline functionality
- `RemoteDataSource` (Supabase) for future sync capabilities
- Abstract repository interfaces in domain layer
- Concrete implementations in data layer

This allows seamless transition from offline-only to sync-enabled app.

**State Management**:
- Riverpod for dependency injection and state management
- Provider-based architecture with proper separation of concerns
- Error handling with custom Failure classes

## Program Builder System Implementation

### **Design Philosophy**
The Program Builder System follows proven methodologies from successful strength training programs like Starting Strength, StrongLifts 5x5, and 5/3/1. Instead of random workouts, users follow structured programs with built-in progression logic.

### **Key Features**
1. **Program Template Library** - Curated starter programs for different goals
2. **Custom Program Creator** - Visual builder for personalized programs  
3. **Smart Progression** - Auto-calculate weights and track advancement
4. **Program Execution** - Generate workouts from program definitions
5. **Progress Tracking** - Monitor program completion and performance

### **Database Schema (Schema v5)**

```sql
-- Program templates and definitions
CREATE TABLE programs (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  description TEXT,
  author TEXT,
  difficulty TEXT CHECK (difficulty IN ('beginner', 'intermediate', 'advanced')),
  frequency INTEGER, -- days per week
  duration_weeks INTEGER,
  tags JSON, -- ["strength", "powerlifting", "full-body"]
  config JSON, -- Full program definition
  is_template BOOLEAN DEFAULT false,
  created_at DATETIME NOT NULL,
  updated_at DATETIME NOT NULL
);

-- User program instances and progress
CREATE TABLE user_programs (
  id TEXT PRIMARY KEY,
  user_id TEXT NOT NULL,
  program_id TEXT NOT NULL,
  start_date DATE NOT NULL,
  current_week INTEGER DEFAULT 1,
  current_day INTEGER DEFAULT 1,
  status TEXT CHECK (status IN ('active', 'completed', 'paused')) DEFAULT 'active',
  customizations JSON, -- User modifications
  created_at DATETIME NOT NULL,
  updated_at DATETIME NOT NULL,
  FOREIGN KEY (program_id) REFERENCES programs(id)
);

-- Program workout progression tracking
CREATE TABLE program_sessions (
  id TEXT PRIMARY KEY,
  user_program_id TEXT NOT NULL,
  week_number INTEGER NOT NULL,
  day_number INTEGER NOT NULL,
  workout_id TEXT, -- References workouts table when completed
  scheduled_date DATE,
  completed_at DATETIME,
  status TEXT CHECK (status IN ('scheduled', 'completed', 'skipped')) DEFAULT 'scheduled',
  notes TEXT,
  created_at DATETIME NOT NULL,
  updated_at DATETIME NOT NULL,
  FOREIGN KEY (user_program_id) REFERENCES user_programs(id),
  FOREIGN KEY (workout_id) REFERENCES workouts(id)
);
```

### **Program Configuration Model**

Programs are defined using JSON configuration that specifies:
- **Workout Structure**: Exercises, sets, reps, weights
- **Progression Rules**: Linear (+5lbs), percentage-based (% of 1RM)
- **Scheduling**: Weekly patterns, rest days, deload weeks
- **Failure Handling**: Deload protocols, form checks

**Example Basic Beginner Program:**
```json
{
  "name": "Basic Beginner Routine",
  "description": "3-month linear progression program for complete beginners",
  "frequency": 3,
  "duration_weeks": 12,
  "workouts": {
    "A": {
      "name": "Workout A",
      "exercises": [
        {
          "exerciseId": "bent_over_row",
          "sets": [
            {"reps": 5, "weight": 95, "type": "normal"},
            {"reps": 5, "weight": 95, "type": "normal"},
            {"reps": "5+", "weight": 95, "type": "amrap"}
          ],
          "restTime": 180,
          "progression": {
            "type": "linear",
            "increment": 2.5,
            "unit": "lbs"
          }
        }
      ]
    },
    "B": {
      "name": "Workout B", 
      "exercises": [...]
    }
  },
  "schedule": ["A", "B", "A", "rest", "B", "A", "B"],
  "progressionRules": {
    "failureThreshold": 3,
    "deloadPercentage": 10,
    "successCriteria": "complete_all_sets"
  }
}
```

### **Implementation Priority**

**Phase 4.3a: Database & Models**
- Database schema migration to v5
- Program entity and repository creation
- Program template seeding system

**Phase 4.3b: Program Templates** 
- Basic Beginner Routine
- StrongLifts 5x5
- Starting Strength
- 5/3/1 for Beginners

**Phase 4.3c: Program Builder UI**
- Template library browsing
- Custom program creation wizard
- Exercise configuration interface

**Phase 4.3d: Program Execution**
- Workout generation engine
- Progression calculation logic
- Program dashboard and tracking

### **Integration with Existing Systems**
- **Exercise Database**: Programs reference existing exercise entities
- **Workout Logging**: Generated workouts use existing workout session system
- **Progress Tracking**: Program progress feeds into existing analytics
- **Goal System**: Programs can be linked to strength/fitness goals