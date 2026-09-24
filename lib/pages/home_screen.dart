import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
      ),
      body: Center(
        child: Text(
          isDarkMode ? 'Dark mode' : 'Light mode',
          style: theme.textTheme.headlineMedium,
        ),
      ),
    );
  }
}
