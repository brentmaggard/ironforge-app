/// Application-wide constants
class AppConstants {
  // App Information
  static const String appName = 'IronForge';
  static const String appVersion = '1.0.0';
  
  // Database
  static const String databaseName = 'ironforge.db';
  static const int databaseVersion = 1;
  
  // Navigation
  static const String initialRoute = '/dashboard';
  
  // Exercise Database
  static const int defaultExerciseCount = 180;
  
  // UI Constants
  static const double defaultPadding = 16.0;
  static const double defaultRadius = 8.0;
  static const double cardElevation = 2.0;
  
  // Timing
  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);
  static const Duration restTimerUpdateInterval = Duration(seconds: 1);
}