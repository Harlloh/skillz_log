import 'package:flutter/material.dart';
import 'package:skillz_log/data/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _logoOpacity;
  late final Animation<double> _titleOpacity;
  late final Animation<double> _taglineOpacity;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..forward();

    _logoOpacity = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0, 0.55, curve: Curves.easeOut),
    );
    _titleOpacity = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.2, 0.75, curve: Curves.easeOut),
    );
    _taglineOpacity = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.45, 1, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
              FadeTransition(
                opacity: _logoOpacity,
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 96,
                  height: 96,
                ),
              ),
              const SizedBox(height: 20),
              FadeTransition(
                opacity: _titleOpacity,
                child: Text(
                  AppStrings.appName,
                  style: theme.textTheme.headlineMedium?.copyWith(
                    color: colors.onPrimary,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              FadeTransition(
                opacity: _taglineOpacity,
                child: Text(
                  'Small steps, visible progress',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colors.onPrimary.withValues(alpha: 0.75),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
