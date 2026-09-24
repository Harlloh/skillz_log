import 'package:flutter/material.dart';
import 'package:skillz_log/data/app_theme.dart';
import 'package:skillz_log/data/constants.dart';
import 'package:skillz_log/data/theme_controller.dart';
import 'package:skillz_log/pages/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: AppThemeController.mode,
      builder: (context, selectedThemeMode, _) => MaterialApp(
        title: AppStrings.appName,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: selectedThemeMode, //this is also equals to AppThemeController.mode.value
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}
