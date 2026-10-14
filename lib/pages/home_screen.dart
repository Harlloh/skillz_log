import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:skillz_log/data/app_theme.dart';
import 'package:skillz_log/data/constants.dart';
import 'package:skillz_log/widgets/header_widget.dart';
import 'package:skillz_log/widgets/stat_cell.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.accountType});
  final AccType accountType;

  @override
  Widget build(BuildContext context) {
    final date = DateFormat('EEEE, MMMM d').format(DateTime.now());
    final theme = Theme.of(context);
    final topInset = MediaQuery.paddingOf(context).top;

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                HeaderWidget(
                  title: 'Ready for a session?',
                  subtitle: 'Plan a skill, then log what you learn each day',
                  acctType: accountType,
                  leading: Text(
                    date,
                    style: TextStyle(color: theme.colorScheme.onPrimary),
                  ),
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.statsBackground(theme.brightness),
                    border: Border(
                      bottom: BorderSide(color: theme.dividerColor),
                    ),
                  ),
                  child: const Row(
                    children: [
                      StatCell(value: '2', label: 'Active skills'),
                      StatCell(value: '8', label: 'Sessions done'),
                      StatCell(
                        value: '1',
                        label: 'Day streak',
                        showDivider: false,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: IgnorePointer(
              child: ColoredBox(
                color: theme.colorScheme.primary,
                child: SizedBox(height: topInset),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
