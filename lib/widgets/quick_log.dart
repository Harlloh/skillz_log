import 'package:flutter/material.dart';

enum LogConfidence { understood, shaky, confused }

class QuickLogResult {
  const QuickLogResult({
    required this.skill,
    required this.topic,
    required this.takeaway,
    required this.minutes,
    required this.confidence,
    required this.countAsSession,
  });

  final String skill;
  final String topic;
  final String takeaway;
  final int minutes;
  final LogConfidence confidence;
  final bool countAsSession;
}

class QuickLogSheet extends StatefulWidget {
  const QuickLogSheet({super.key});

  @override
  State<QuickLogSheet> createState() => _QuickLogSheetState();
}

class _QuickLogSheetState extends State<QuickLogSheet> {
  static const _skills = [
    _SkillOption(
      name: 'Video Editing',
      topic: 'Timeline Editing Fundamentals',
      sessionNumber: 1,
      totalSessions: 3,
    ),
    _SkillOption(
      name: 'Flutter Development',
      topic: 'Building Responsive Layouts',
      sessionNumber: 2,
      totalSessions: 4,
    ),
    _SkillOption(
      name: 'UI/UX Design',
      topic: 'Visual Hierarchy and Spacing',
      sessionNumber: 1,
      totalSessions: 3,
    ),
  ];

  final _formKey = GlobalKey<FormState>();
  final _takeawayController = TextEditingController();

  late _SkillOption _selectedSkill;
  int _selectedMinutes = 25;
  LogConfidence _selectedConfidence = LogConfidence.understood;
  bool _countAsSession = true;

  @override
  void initState() {
    super.initState();
    _selectedSkill = _skills.first;
  }

  @override
  void dispose() {
    _takeawayController.dispose();
    super.dispose();
  }

  void _saveLog() {
    if (!_formKey.currentState!.validate()) return;

    Navigator.pop(
      context,
      QuickLogResult(
        skill: _selectedSkill.name,
        topic: _selectedSkill.topic,
        takeaway: _takeawayController.text.trim(),
        minutes: _selectedMinutes,
        confidence: _selectedConfidence,
        countAsSession: _countAsSession,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final keyboardInset = MediaQuery.viewInsetsOf(context).bottom;

    return AnimatedPadding(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOut,
      padding: EdgeInsets.only(bottom: keyboardInset),
      child: FractionallySizedBox(
        heightFactor: 0.9,
        child: Material(
          color: colors.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: SizedBox(
                  height: 4,
                  child: ColoredBox(color: colors.secondary),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 22, 12, 8),
                    child: Row(
                      children: [
                        Text(
                          'Daily log',
                          style: theme.textTheme.headlineSmall?.copyWith(
                            color: colors.onSurface,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          tooltip: 'Close',
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(24, 0, 24, 28),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 180),
                              child: Text(
                                '${_selectedSkill.name} · ${_selectedSkill.topic}',
                                key: ValueKey(_selectedSkill.name),
                                style: theme.textTheme.titleMedium?.copyWith(
                                  color: colors.onSurfaceVariant,
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            const _SectionLabel('Skill'),
                            const SizedBox(height: 10),
                            DropdownButtonFormField<_SkillOption>(
                              initialValue: _selectedSkill,
                              isExpanded: true,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 16,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: colors.outlineVariant,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: colors.primary,
                                    width: 2,
                                  ),
                                ),
                              ),
                              items: _skills
                                  .map(
                                    (skill) => DropdownMenuItem(
                                      value: skill,
                                      child: Text(skill.name),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (skill) {
                                if (skill == null) return;
                                setState(() => _selectedSkill = skill);
                              },
                            ),
                            const SizedBox(height: 24),
                            const _SectionLabel(
                              "Today's takeaway",
                              required: true,
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              controller: _takeawayController,
                              textCapitalization: TextCapitalization.sentences,
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                hintText: 'e.g. Streams finally make sense',
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 18,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: colors.outlineVariant,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: colors.primary,
                                    width: 2,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: colors.error),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: colors.error,
                                    width: 2,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Add one thing you learned';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 24),
                            const _SectionLabel('Time spent'),
                            const SizedBox(height: 10),
                            Row(
                              children: [15, 25, 45, 60]
                                  .map(
                                    (minutes) => Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          right: minutes == 60 ? 0 : 10,
                                        ),
                                        child: _ChoiceButton(
                                          label: '${minutes}m',
                                          selected: _selectedMinutes == minutes,
                                          onPressed: () => setState(
                                            () => _selectedMinutes = minutes,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                            const SizedBox(height: 24),
                            const _SectionLabel('Confidence'),
                            const SizedBox(height: 10),
                            Row(
                              children: LogConfidence.values
                                  .map(
                                    (confidence) => Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          right:
                                              confidence ==
                                                  LogConfidence.confused
                                              ? 0
                                              : 10,
                                        ),
                                        child: _ChoiceButton(
                                          label: confidence.label,
                                          selected:
                                              _selectedConfidence == confidence,
                                          onPressed: () => setState(
                                            () => _selectedConfidence =
                                                confidence,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Count as session ${_selectedSkill.sessionNumber} of ${_selectedSkill.totalSessions}',
                                    style: theme.textTheme.titleMedium
                                        ?.copyWith(color: colors.onSurface),
                                  ),
                                ),
                                Switch(
                                  value: _countAsSession,
                                  onChanged: (value) {
                                    setState(() => _countAsSession = value);
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: double.infinity,
                              child: FilledButton.icon(
                                onPressed: _saveLog,
                                style: FilledButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                icon: const Icon(Icons.check),
                                label: const Text('Save log'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SkillOption {
  const _SkillOption({
    required this.name,
    required this.topic,
    required this.sessionNumber,
    required this.totalSessions,
  });

  final String name;
  final String topic;
  final int sessionNumber;
  final int totalSessions;
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.label, {this.required = false});

  final String label;
  final bool required;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Text.rich(
      TextSpan(
        text: label,
        children: required
            ? const [
                TextSpan(
                  text: ' *',
                  style: TextStyle(color: Colors.red),
                ),
              ]
            : null,
      ),
      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
    );
  }
}

class _ChoiceButton extends StatelessWidget {
  const _ChoiceButton({
    required this.label,
    required this.selected,
    required this.onPressed,
  });

  final String label;
  final bool selected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: selected ? colors.primary : Colors.transparent,
        foregroundColor: selected ? colors.onPrimary : colors.onSurface,
        side: BorderSide(
          color: selected ? colors.primary : colors.outlineVariant,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(
        label,
        maxLines: 1,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }
}

extension on LogConfidence {
  String get label => switch (this) {
    LogConfidence.understood => 'Understood',
    LogConfidence.shaky => 'Shaky',
    LogConfidence.confused => 'Confused',
  };
}
