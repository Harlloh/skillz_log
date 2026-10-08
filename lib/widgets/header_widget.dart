import 'package:flutter/material.dart';
import 'package:skillz_log/data/constants.dart';
import 'package:skillz_log/data/theme_controller.dart';
import 'package:skillz_log/pages/auth_screen.dart';
import 'package:skillz_log/pages/profile_screen.dart';
import 'package:skillz_log/utils/appNavigator.dart';

class HeaderWidget extends StatelessWidget {
  final Widget? leading;
  final bool? topRight;
  final String title;
  final String? subtitle;
  final Widget? action;
  final double height;
  final AccType? acctType;

  const HeaderWidget({
    super.key,
    this.leading,
    this.topRight = true,
    required this.title,
    this.subtitle,
    this.action,
    this.height = 420,
    this.acctType,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final isDarkMode = theme.brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      color: colors.primary,

      // decoration: BoxDecoration(
      //   gradient: LinearGradient(
      //     begin: Alignment.topRight,
      //     end: Alignment.bottomLeft,
      //     colors: [
      //       Color.lerp(colors.primary, Colors.black, 0.14)!,
      //       colors.primary,
      //     ],
      //   ),
      // ),

      // padding: const EdgeInsets.fromLTRB(32, 100, 32, 60),
      child: Stack(
        children: [
          Positioned(
            top: 32,
            right: 24,
            child: Transform.rotate(
              angle: 0.18,
              child: Container(
                width: 130,
                height: 52,
                color: colors.onPrimary.withValues(alpha: 0.07),
              ),
            ),
          ),
          Positioned(
            bottom: 12,
            right: 32,
            child: Transform.rotate(
              angle: -0.12,
              child: Container(
                width: 100,
                height: 72,
                color: colors.onPrimary.withValues(alpha: 0.07),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 36,
            child: Transform.rotate(
              angle: 0.12,
              child: Container(
                width: 56,
                height: 100,
                color: colors.onPrimary.withValues(alpha: 0.07),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 56, 15, 62),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (acctType != null) ...[
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: colors.onPrimary.withValues(alpha: 0.12),
                          border: Border.all(
                            color: colors.onPrimary.withValues(alpha: 0.3),
                          ),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              acctType!.icon,
                              color: colors.onPrimary,
                              size: 22,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              acctType!.displayText,
                              maxLines: 1,
                              softWrap: false,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: colors.onPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (topRight ?? true) ...[
                        const Spacer(),
                        IconButton(
                          tooltip: isDarkMode
                              ? 'Use light theme'
                              : 'Use dark theme',
                          onPressed: () {
                            AppThemeController.setDarkMode(!isDarkMode);
                          },
                          icon: Icon(
                            isDarkMode
                                ? Icons.light_mode_outlined
                                : Icons.dark_mode_outlined,
                            color: colors.onPrimary,
                          ),
                        ),
                        const SizedBox(width: 4),
                        if (acctType == AccType.notGuest)
                          IconButton(
                            tooltip: 'Open profile',
                            onPressed: () {
                              AppNavigator.push(context, const ProfileScreen());
                            },
                            style: IconButton.styleFrom(
                              backgroundColor: colors.onPrimary.withValues(
                                alpha: 0.12,
                              ),
                              minimumSize: const Size(48, 48),
                            ),
                            icon: Icon(
                              Icons.person_outline_rounded,
                              color: colors.onPrimary,
                            ),
                          ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 52),
                ],
                leading ?? const SizedBox.shrink(),
                const SizedBox(height: 6),
                Text(
                  title,
                  style: theme.textTheme.headlineMedium?.copyWith(
                    color: colors.onPrimary,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Text(
                //   "moving forward",
                //   style: theme.textTheme.headlineMedium?.copyWith(
                //     color: colors.onPrimary,
                //     fontSize: 30,
                //   ),
                // ),
                subtitle == null
                    ? const SizedBox.shrink()
                    : Text(
                        subtitle!,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colors.onPrimary.withValues(alpha: 0.72),
                          fontSize: 12,
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
