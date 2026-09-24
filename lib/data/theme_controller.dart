import 'package:flutter/material.dart';

/// Temporary in-memory theme control for testing light and dark mode.
abstract final class AppThemeController {
  static final mode = ValueNotifier<ThemeMode>(ThemeMode.system);

  static void setDarkMode(bool enabled) {
    mode.value = enabled ? ThemeMode.dark : ThemeMode.light;
  }
}
