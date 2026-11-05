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

  static const darkBackground = Color(0xFF141B17);
  static const darkForeground = Color(0xFFF6F5EE);
  // Warm stat-band colors from the home-screen visual direction.
  static const lightStatsBackground = Color(0xFFFFF1CC);
  static const darkStatsBackground = Color(0xFF19231D);
  static const lightStatsDivider = Color(0xFFD8D4C4);
  static const darkStatsDivider = Color(0xFF334038);
  static const lightCardSurface = Color(0xFFFEFEFC);
  static const darkCardSurface = Color(0xFF151D19);
  static const lightCardOutline = Color(0xFFD8D8CF);
  static const darkCardOutline = Color(0xFF39433D);
  static const lightMutedText = Color(0xFF657066);
  static const darkMutedText = Color(0xFFA3ADA6);
  static const lightProgressTrack = Color(0xFFE9E9DF);
  static const darkProgressTrack = Color(0xFF26312B);

  static Color textPrimary(Brightness brightness) =>
      brightness == Brightness.light ? lightTextPrimary : darkTextPrimary;

  static Color statsBackground(Brightness brightness) =>
      brightness == Brightness.light
      ? lightStatsBackground
      : darkStatsBackground;

  static Color statsDivider(Brightness brightness) =>
      brightness == Brightness.light ? lightStatsDivider : darkStatsDivider;

  static Color cardSurface(Brightness brightness) =>
      brightness == Brightness.light ? lightCardSurface : darkCardSurface;

  static Color cardOutline(Brightness brightness) =>
      brightness == Brightness.light ? lightCardOutline : darkCardOutline;

  static Color mutedText(Brightness brightness) =>
      brightness == Brightness.light ? lightMutedText : darkMutedText;

  static Color progressTrack(Brightness brightness) =>
      brightness == Brightness.light ? lightProgressTrack : darkProgressTrack;
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
