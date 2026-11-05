import 'package:flutter/material.dart';
import 'package:skillz_log/data/app_theme.dart';
import 'package:skillz_log/data/constants.dart';
import 'package:skillz_log/pages/skill_details.dart';
import 'package:skillz_log/utils/appNavigator.dart';

class SkillListItem extends StatelessWidget {
  const SkillListItem({super.key, required this.skill});
  final SkillListType skill;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final progress = skill.totalSessions > 0
        ? (skill.session / skill.totalSessions).clamp(0.0, 1.0)
        : 0.0;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(bottom: 25),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      skill.title,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 11,
                        color: colors.onSurface,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      '${skill.category} . ${skill.skillLevel}',
                      style: TextStyle(
                        fontSize: 10,
                        color: AppColors.mutedText(theme.brightness),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 7,
                    backgroundColor: AppColors.progressTrack(theme.brightness),
                    valueColor: AlwaysStoppedAnimation<Color>(colors.primary),
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              AppNavigator.push(context, SkillDetail());
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Row(
                children: [
                  Column(
                    children: [
                      Text(
                        '${skill.session}/${skill.totalSessions}',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: colors.onSurface,
                        ),
                      ),
                      Text(
                        skill.status,
                        style: TextStyle(
                          fontSize: 10,
                          color: AppColors.mutedText(theme.brightness),
                        ),
                      ),
                    ],
                  ),
                  Icon(Icons.chevron_right, color: colors.onSurfaceVariant),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
