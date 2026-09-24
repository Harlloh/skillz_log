import 'package:flutter/material.dart';
import 'package:skillz_log/auth/auth_controller.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: authController.markAsAuthenticated,
          child: const Text('Sign in'),
        ),
      ),
    );
  }
}
