import 'package:flutter/material.dart';

/// Colors currently used by the app. Add a token only when the interface
/// introduces a new semantic color role.
abstract final class AppColors {
  static const primary = Color(0xFF133924);
  static const darkPrimary = Color(0xFF1D4A30);
  static const lightTextPrimary = primary;
  static const darkTextPrimary = Colors.white;
  static const secondary = Color(0xFFEA7451);
  static const darkSecondary = Color(0xFFFF9A75);
  static const onPrimary = Color(0xFFFAFAF6);
  static const darkOnPrimary = Color(0xFFDCE9DF);
  static const onSecondary = Color.fromARGB(255, 7, 7, 7);

  static const lightBackground = Color(0xFFF8F7F1);
  static const lightForeground = Color(0xFF133924);

  static const darkBackground = Color(0xFF0B1D14);
  static const darkForeground = Color(0xFFF6F5EE);
  static const lightStatsBackground = Color(0xFFFDF0D5);
  static const darkStatsBackground = Color(0xFF173124);

  static Color textPrimary(Brightness brightness) =>
      brightness == Brightness.light ? lightTextPrimary : darkTextPrimary;

  static Color statsBackground(Brightness brightness) =>
      brightness == Brightness.light
      ? lightStatsBackground
      : darkStatsBackground;
}

abstract final class AppTheme {
  static ThemeData get light => _build(
    brightness: Brightness.light,
    background: AppColors.lightBackground,
    foreground: AppColors.lightForeground,
  );

  static ThemeData get dark => _build(
    brightness: Brightness.dark,
    background: AppColors.darkBackground,
    foreground: AppColors.darkForeground,
  );

  static ThemeData _build({
    required Brightness brightness,
    required Color background,
    required Color foreground,
  }) {
    final colorScheme =
        ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: brightness,
        ).copyWith(
          primary: brightness == Brightness.light
              ? AppColors.primary
              : AppColors.darkPrimary,
          secondary: brightness == Brightness.light
              ? AppColors.secondary
              : AppColors.darkSecondary,
          onPrimary: brightness == Brightness.light
              ? AppColors.onPrimary
              : AppColors.darkOnPrimary,
          surface: background,
          onSurface: foreground,
        );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: background,
      textTheme: ThemeData(brightness: brightness).textTheme.copyWith(
        headlineMedium: TextStyle(
          color: foreground,
          fontSize: 30,
          fontWeight: FontWeight.w600,
        ),
        bodyMedium: TextStyle(color: foreground, fontSize: 14),
      ),
    );
  }
}
