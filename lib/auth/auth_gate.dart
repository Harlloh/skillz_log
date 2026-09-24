import 'package:flutter/material.dart';
import 'package:skillz_log/auth/auth_controller.dart';
import 'package:skillz_log/pages/auth_screen.dart';
import 'package:skillz_log/pages/home_screen.dart';
import 'package:skillz_log/pages/splash_screen.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  void initState() {
    super.initState();
    authController.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AuthStatus>( //this rebuilds the entire ui based off the users status.
      valueListenable: authController,
      builder: (context, status, _) {
        switch (status) {
          case AuthStatus.checking:
            return const SplashScreen();

          case AuthStatus.authenticated:
            return const HomeScreen();

          case AuthStatus.unauthenticated:
            return const AuthScreen();
        }
      },
    );
  }
}