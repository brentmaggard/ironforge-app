You are tasked with porting the **IronForge workout-tracking web app** (https://github.com/brentmaggard/ironforge) to a **Flutter application** that runs on iOS, Android and eventually the web.  

The current app is a Next.js PWA (see [/README.md](https://github.com/brentmaggard/ironforge/blob/main/README.md)) with features such as:
- Dashboard
- Goals
- Workout logging
- Program management
- Progress charts
- Plate calculator
- Exercise database  

Additional project notes and implementation details are documented in [/CLAUDE.md](https://github.com/brentmaggard/ironforge/blob/main/CLAUDE.md).  

The Flutter version must support all of these features and follow modern Flutter best practices. Initially the app must work entirely offline using a local database; later it should be designed to synchronise with a Supabase backend for a web version.

## Requirements

### 1. Architecture & State Management
- Use a modular layered architecture (presentation, domain, data).
- Employ **Riverpod** for consistent state management.
- Implement dependency injection (via Riverpod or `get_it`).
- Follow a repository pattern with `LocalDataSource` (Drift/SQLite) and `RemoteDataSource` (Supabase).

### 2. Data & Offline-First
- Use **Drift (SQLite)** for storing all user data (goals, exercises, programs, workouts, sets, progress).
- Seed DB with ~180 built-in exercises; users can add/edit their own.
- Design tables for extensibility (e.g., goals, goal_progress, exercises, programs, workouts, workout_sets).
- Add indexes and FTS5 for fast search/filter.
- Plan for Supabase sync later with timestamps and versioning.

### 3. UI/UX
- Use **Flutter Material 3**.
- Responsive/adaptive layouts for mobile, tablet, web.
- Features:
  - **Goals**: dashboard, real-time charts, goal creation/editing.
  - **Workouts**: session creation, set logging, timers.
  - **Programs**: builder with JSON config now, FlexCode scripting later.
  - **Progress**: charts for strength, volume, body measurements.
  - **Exercise database**: searchable, filterable, with details.
  - **Plate calculator**: visual loader and settings.
- Accessibility: semantics, focus order, tap target sizing, i18n with ARB.

### 4. Performance & Code Quality
- Optimize widget rebuilds (use `const` constructors, break down trees).
- Efficient I/O (Drift streams, caching, pagination).
- Centralized error handling with user-friendly feedback.
- Comprehensive testing: unit, widget, integration.
- Use `flutter_lints`, consistent naming and formatting.
- CI/CD: GitHub Actions or equivalent for lint, test, build.

### 5. Future Enhancements
- **FlexCode scripting** and **AI program generation** later.
- Web build with Flutter (ensure chosen packages support web).
- Sync engine: background tasks to push/pull with Supabase when online.

---