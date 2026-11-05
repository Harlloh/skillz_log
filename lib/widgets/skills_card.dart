import 'package:flutter/material.dart';

class SkillsCard extends StatelessWidget {
  const SkillsCard({
    super.key,
    required this.skill,
    required this.topic,
    required this.status,
    required this.description,
    required this.session,
    required this.totalSessions,
    required this.minutes,
    required this.tryText,
    required this.onStart,
    required this.onViewPlan,
  });

  final String skill;
  final String topic;
  final String status;
  final String description;
  final int session;
  final int totalSessions;
  final int minutes;
  final String tryText;
  final VoidCallback onStart;
  final VoidCallback onViewPlan;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    return Container(
      width: MediaQuery.sizeOf(context).width * 0.95,
      // height: 900,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: (Colors.white70),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            spreadRadius: 0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(height: 4, width: double.infinity, color: colors.secondary),
          Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '$skill · $topic',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: const Color.fromARGB(255, 38, 37, 37),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(status, style: TextStyle(fontSize: 12)),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    topic,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Text(
                  description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.grey,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Text('Session $session of $totalSessions'),
                    Expanded(child: SizedBox(width: double.infinity)),
                    Text('$minutes min each'),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: List.generate(totalSessions, (index) {
                    return Expanded(
                      child: Container(
                        height: 8,
                        margin: const EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          color: index < session
                              ? colors.primary
                              : colors.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    );
                  }),
                ),
                SizedBox(height: 8),
                Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Try: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: tryText),
                    ],
                  ),
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        onPressed: onStart,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Start session',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    OutlinedButton(
                      onPressed: onViewPlan,
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text('View plan'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
