import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:skillz_log/data/app_theme.dart';
import 'package:skillz_log/data/constants.dart';
import 'package:skillz_log/utils/utils.dart';
import 'package:skillz_log/widgets/header_widget.dart';
import 'package:skillz_log/widgets/skills_card.dart';
import 'package:skillz_log/widgets/stat_cell.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.accountType});
  final AccType accountType;

  @override
  Widget build(BuildContext context) {
    final date = DateFormat('EEEE, MMMM d').format(DateTime.now());
    final theme = Theme.of(context);
    final topInset = MediaQuery.paddingOf(context).top;

    final List<Map<String, dynamic>> skills = [
      {
        'skill': 'Video Editing',
        'topic': 'Timeline Editing Fundamentals',
        'status': 'Not Started',
        'description': 'Practice selecting takes and trimming clips.',
        'session': 1,
        'totalSessions': 3,
        'minutes': 25,
        'tryText': 'Build a 30-second sequence from five clips',
      },
      {
        'skill': 'Flutter',
        'topic': 'State Management',
        'status': 'In Progress',
        'description': 'Learn how to manage application state.',
        'session': 2,
        'totalSessions': 5,
        'minutes': 30,
        'tryText': 'Build a counter using Riverpod',
      },
    ];

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderWidget(
                  title: 'Ready for a session?',
                  // subtitle: 'Plan a skill, then log what you learn each day',
                  acctType: accountType,
                  leading: Text(
                    date,
                    style: TextStyle(color: theme.colorScheme.onPrimary),
                  ),
                  action: FilledButton.icon(
                    onPressed: () {
                      //open the quick log screen
                      showQuickLogSheet(context);
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: theme.colorScheme.onPrimary,
                      foregroundColor: theme.colorScheme.primary,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    icon: const Icon(CupertinoIcons.bolt),
                    label: const Text(
                      '30-second daily log',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.statsBackground(theme.brightness),
                    border: Border(
                      bottom: BorderSide(
                        color: AppColors.statsDivider(theme.brightness),
                      ),
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
                Padding(
                  padding: const EdgeInsets.all(18),
                  child: Text(
                    'Up next',
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(
                  height: 350,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: skills.length,
                    itemBuilder: (context, index) {
                      final skill = skills[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: SkillsCard(
                          skill: skill['skill'],
                          topic: skill['topic'],
                          status: skill['status'],
                          description: skill['description'],
                          session: skill['session'],
                          totalSessions: skill['totalSessions'],
                          minutes: skill['minutes'],
                          tryText: skill['tryText'],
                          onStart: () {},
                          onViewPlan: () {},
                        ),
                      );
                    },
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
