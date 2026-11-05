import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:skillz_log/data/app_theme.dart';
import 'package:skillz_log/data/constants.dart';
import 'package:skillz_log/pages/skills_list.dart';
import 'package:skillz_log/utils/appNavigator.dart';
import 'package:skillz_log/utils/utils.dart';
import 'package:skillz_log/widgets/header_widget.dart';
import 'package:skillz_log/widgets/skill_list.dart';
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

    final List<SkillCardType> skills = [
      SkillCardType(
        skill: 'Video Editing',
        topic: 'Timeline Editing Fundamentals',
        status: 'Not Started',
        description:
            'Practice selecting takes and trimming clips.Practice selecting takes and trimming clips.Practice selecting takes and trimming clips',
        session: 1,
        totalSessions: 3,
        minutes: 25,
        tryText: 'Build a 30-second sequence from five clips',
      ),

      SkillCardType(
        skill: 'Flutter',
        topic: 'State Management',
        status: 'In Progress',
        description: 'Learn how to manage application state.',
        session: 2,
        totalSessions: 5,
        minutes: 30,
        tryText: 'Build a counter using Riverpod',
      ),
    ];

    final List<SkillListType> skillsList = [
      SkillListType(
        title: 'Video Editing',
        skillLevel: 'Beginner',
        category: 'Media',
        status: 'In progress',
        session: 1,
        totalSessions: 10,
      ),
      SkillListType(
        title: 'Flutter',
        skillLevel: 'Expert',
        category: 'Mobile Development',
        status: 'In progress',
        session: 2,
        totalSessions: 14,
      ),
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

                // SKILLS UP NEXT SECTION
                SizedBox(
                  height: 300,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: skills.length,
                    itemBuilder: (context, index) {
                      final skill = skills[index];

                      return Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: SkillsCard(
                            skill: skill.skill,
                            topic: skill.topic,
                            status: skill.status,
                            description: skill.description,
                            session: skill.session,
                            totalSessions: skill.totalSessions,
                            minutes: skill.minutes,
                            tryText: skill.tryText,
                            onStart: () {},
                            onViewPlan: () {},
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    children: [
                      // Expanded(child: Row())
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Your skills',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          if (skillsList.length > 5)
                            TextButton(
                              onPressed: () =>
                                  AppNavigator.push(context, SkillsList()),
                              child: const Text('See all'),
                            ),
                        ],
                      ),
                      SizedBox(height: 20),
                      ...skillsList.take(5).map((skill) {
                        return SkillListItem(skill: skill);
                      }).toList(),
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
