import 'package:flutter/material.dart';
import 'package:skillz_log/widgets/auth_widget.dart';
import 'package:skillz_log/widgets/header_widget.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          color: colors.surface,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderWidget(
                title: 'Your Learning, Moving Forward',
                subtitle: 'Plan a skill, then log what you learn each day',
                leading: Image.asset(
                  'assets/images/logo.png',
                  width: 62,
                  height: 62,
                ),
              ),

              const AuthWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
