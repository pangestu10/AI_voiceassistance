import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF0E0F1A),

    primaryColor: const Color(0xFF6C63FF),

    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF0E0F1A),
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF6C63FF),
      foregroundColor: Colors.white,
      elevation: 6,
    ),

    textTheme: const TextTheme(
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.white70,
      ),
      bodyMedium: TextStyle(
        fontSize: 15,
        color: Colors.white,
        height: 1.4,
      ),
      bodySmall: TextStyle(
        fontSize: 13,
        color: Colors.white54,
      ),
    ),

    cardTheme: CardThemeData(
      color: const Color(0xFF1A1B2F),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
  );
}
