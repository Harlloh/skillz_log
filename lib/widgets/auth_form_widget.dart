import 'package:flutter/material.dart';
import 'package:skillz_log/data/constants.dart';

//
class AuthFormWidget extends StatefulWidget {
  const AuthFormWidget({super.key, required this.selectedMode});

  final AuthMode selectedMode;

  @override
  State<AuthFormWidget> createState() => _AuthFormWidgetState();
}

class _AuthFormWidgetState extends State<AuthFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _userNameController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _userNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          if (widget.selectedMode == AuthMode.createAccount) ...[
            SizedBox(height: 30),
            TextFormField(
              controller: _userNameController,
              decoration: InputDecoration(
                labelText: 'Username',
                border: const OutlineInputBorder(),
                focusColor: colors.secondary,
              ),
            ),
          ],
          SizedBox(height: 30),
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            controller: _emailController,
            decoration: InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
              focusedBorder: theme.brightness == Brightness.dark
                  ? OutlineInputBorder(
                      borderSide: BorderSide(color: colors.secondary),
                    )
                  : null,
            ),
          ),
          SizedBox(height: 30),
          TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(),
            ),
            obscureText: true,
          ),
        ],
      ),
    );
  }
}
