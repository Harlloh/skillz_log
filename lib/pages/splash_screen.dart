import 'package:flutter/material.dart';
import 'package:skillz_log/data/constants.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      backgroundColor: colors.primary,
      body: Center(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Image.asset('assets/images/logo.png', width: 96, height: 96),
              const SizedBox(height: 20),
              Text(AppStrings.appName, style: theme.textTheme.headlineMedium?.copyWith(
                color: colors.onPrimary
              )),
              const SizedBox(height: 8),
              Text(
                'Small steps, visible progress',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colors.onPrimary.withValues(alpha: 0.75),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
