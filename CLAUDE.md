# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

IronForge Flutter is a cross-platform workout tracking application being ported from the existing Next.js web app (https://github.com/brentmaggard/ironforge). The Flutter version will run on iOS, Android, and web platforms with offline-first capabilities and eventual Supabase synchronization.

## Current Status

**PROJECT STATUS**: ✅ **PHASE 4 IN PROGRESS** - Goals, Exercise Database & Favorites Complete, Workout Logging Next

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
- ✅ **Enhanced Drift Database**: 11 tables with comprehensive schema and JSON data integration (Schema v4)
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

**IMMEDIATE NEXT STEPS (Phase 4.2c - Workout Logging System)**:
1. **Workout Session Screen** 🔄 **NEXT PRIORITY**
   - Active workout session interface with real-time tracking
   - Exercise selection and addition to current workout
   - Set-by-set logging with reps, weight, RPE, and notes
   - Rest timer functionality and workout flow management
   
2. **Workout Management** 🔲 **PENDING**
   - Workout creation, editing, and completion
   - Workout templates and program integration
   - Exercise reordering and workout customization
   
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

**Current Project Status**: ✅ **Goals, Exercise System & Favorites Complete** - Workout Logging Next

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
- ✅ `programs` - Workout programs and templates with JSON configuration
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
- ✅ **Database Migration** - Schema v4 with exercise favorites table and enhanced exercise support

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

### 🚧 Current Focus (Phase 4.2c)
6. **Workout Logging System** - Active workout sessions and set tracking
   - 🔄 Workout session screen with real-time tracking **NEXT**
   - 🔲 Set logging with reps/weight/RPE tracking
   - 🔲 Rest timers and workout flow management
   - 🔲 Exercise selection and workout integration

### 🔮 Upcoming
7. **Advanced Features** - Enhanced functionality and integrations
   - Program management with templates and scheduling
   - Progress analytics with charts and trends
   - Plate calculator with visual barbell loading
   - Sync preparation for backend integration
8. **Testing & Polish** - Comprehensive testing and optimization

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