import 'package:flutter/material.dart';
import 'package:skillz_log/data/constants.dart';
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
              // Container(
              //   width: double.infinity,
              //   color: colors.primary,
              //   // decoration: BoxDecoration(
              //   //   gradient: LinearGradient(
              //   //     begin: Alignment.topRight,
              //   //     end: Alignment.bottomLeft,
              //   //     colors: [
              //   //       Color.lerp(colors.primary, Colors.black, 0.14)!,
              //   //       colors.primary,
              //   //     ],
              //   //   ),
              //   // ),

              //   // padding: const EdgeInsets.fromLTRB(32, 100, 32, 60),
              //   child: Stack(
              //     children: [
              //       Positioned(
              //         top: 32,
              //         right: 24,
              //         child: Transform.rotate(
              //           angle: 0.18,
              //           child: Container(
              //             width: 130,
              //             height: 52,
              //             color: colors.onPrimary.withValues(alpha: 0.07),
              //           ),
              //         ),
              //       ),
              //       Positioned(
              //         bottom: 12,
              //         right: 32,
              //         child: Transform.rotate(
              //           angle: -0.12,
              //           child: Container(
              //             width: 100,
              //             height: 72,
              //             color: colors.onPrimary.withValues(alpha: 0.07),
              //           ),
              //         ),
              //       ),
              //       Positioned(
              //         bottom: 0,
              //         left: 36,
              //         child: Transform.rotate(
              //           angle: 0.12,
              //           child: Container(
              //             width: 56,
              //             height: 100,
              //             color: colors.onPrimary.withValues(alpha: 0.07),
              //           ),
              //         ),
              //       ),
              //       Padding(
              //         padding: const EdgeInsets.fromLTRB(32, 100, 32, 62),
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Image.asset(
              //               'assets/images/logo.png',
              //               width: 62,
              //               height: 62,
              //             ),
              //             const SizedBox(height: 12),

              //             Text(
              //               "Your learning, ",
              //               style: theme.textTheme.headlineMedium?.copyWith(
              //                 color: colors.onPrimary,
              //                 fontSize: 30,
              //               ),
              //             ),
              //             Text(
              //               "moving forward",
              //               style: theme.textTheme.headlineMedium?.copyWith(
              //                 color: colors.onPrimary,
              //                 fontSize: 30,
              //               ),
              //             ),
              //             Text(
              //               'Plan a skill, then log what you learn each day.',
              //               style: theme.textTheme.bodySmall?.copyWith(
              //                 color: colors.onPrimary.withValues(alpha: 0.72),
              //                 fontSize: 12,
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
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
