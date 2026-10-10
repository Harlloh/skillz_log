import 'package:flutter/material.dart';
import 'package:skillz_log/data/app_theme.dart';

class StatCell extends StatelessWidget {
  const StatCell({
    super.key,
    required this.value,
    required this.label,
    this.showDivider = true,
  });
  final String value;
  final String label;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textPrimary = AppColors.textPrimary(theme.brightness);

    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: showDivider
              ? Border(right: BorderSide(color: theme.dividerColor))
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: textPrimary,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                color: theme.colorScheme.onSurfaceVariant,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
