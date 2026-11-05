import 'package:flutter/material.dart';
import 'package:skillz_log/data/constants.dart';
import 'package:skillz_log/pages/skill_details.dart';
import 'package:skillz_log/utils/appNavigator.dart';

class SkillListItem extends StatelessWidget {
  const SkillListItem({super.key, required this.skill});
  final SkillListType skill;

  @override
  Widget build(BuildContext context) {
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
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      '${skill.category} . ${skill.skillLevel}',
                      style: TextStyle(fontSize: 10),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 7,
                    backgroundColor: const Color(0xFFE9E9DF),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Color(0xFF123D29),
                    ),
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
                        ),
                      ),
                      Text('${skill.status}', style: TextStyle(fontSize: 10)),
                    ],
                  ),
                  Icon(Icons.chevron_right),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
