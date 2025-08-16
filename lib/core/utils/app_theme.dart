import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

/// Material 3 theme configuration for IronForge app
class AppTheme {
  // Primary seed color for Material 3 dynamic color scheme
  static const Color _seedColor = Color(0xFF6750A4); // Material 3 default purple
  
  /// Light theme configuration
  static ThemeData get lightTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: _seedColor,
      brightness: Brightness.light,
    );
    
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surfaceContainer,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 3,
      ),
      cardTheme: const CardThemeData(
        elevation: AppConstants.cardElevation,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
        ),
        filled: true,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: colorScheme.surfaceContainer,
        indicatorColor: colorScheme.secondaryContainer,
      ),
    );
  }
  
  /// Dark theme configuration
  static ThemeData get darkTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: _seedColor,
      brightness: Brightness.dark,
    );
    
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surfaceContainer,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 3,
      ),
      cardTheme: const CardThemeData(
        elevation: AppConstants.cardElevation,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
        ),
        filled: true,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: colorScheme.surfaceContainer,
        indicatorColor: colorScheme.secondaryContainer,
      ),
    );
  }
}