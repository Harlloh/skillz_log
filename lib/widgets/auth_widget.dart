import 'package:flutter/material.dart';
import 'package:skillz_log/data/constants.dart';
import 'package:skillz_log/widgets/auth_form_widget.dart';

class AuthWidget extends StatefulWidget {
  const AuthWidget({super.key});

  @override
  State<AuthWidget> createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  AuthMode _selectedMode = AuthMode.signIn;
  Widget _buildTab(String label, AuthMode mode, ThemeData theme) {
    final selected = _selectedMode == mode;
    final colors = theme.colorScheme;

    return Expanded(
      child: InkWell(
        onTap: () => setState(() {
          _selectedMode = mode;
        }),
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: Center(
                child: Text(
                  label,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: selected
                        ? colors.secondary
                        : colors.onSurface.withValues(alpha: 0.65),
                  ),
                ),
              ),
            ),
            Container(
              height: 2,
              color: selected ? colors.secondary : colors.outlineVariant,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              _buildTab('Sign in', AuthMode.signIn, theme),
              _buildTab('Create account', AuthMode.createAccount, theme),
            ],
          ),
          AuthFormWidget(selectedMode: _selectedMode),
        ],
      ),
    );
  }
}
