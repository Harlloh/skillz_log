import 'package:flutter/material.dart';
import 'package:skillz_log/auth/auth_controller.dart';
import 'package:skillz_log/data/app_theme.dart';
import 'package:skillz_log/data/constants.dart';

//
class AuthFormWidget extends StatefulWidget {
  const AuthFormWidget({super.key, required this.selectedMode});

  final AuthMode selectedMode;

  @override
  State<AuthFormWidget> createState() => _AuthFormWidgetState();
}

class _AuthFormWidgetState extends State<AuthFormWidget> {
  bool showPassword = false;
  bool isLoading = false;
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
    final textPrimary = AppColors.textPrimary(theme.brightness);

    Future<void> _submitEmailAuth() async {
      setState(() {
        isLoading = true;
      });
      print(widget.selectedMode);
      await Future<void>.delayed(Duration(milliseconds: 1200));
      setState(() {
        isLoading = false;
      });
      if (!_formKey.currentState!.validate()) {
        return;
      }

      final email = _emailController.text.trim();
      final password = _passwordController.text;
      final username = _userNameController.text.trim();

      if (widget.selectedMode == AuthMode.signIn) {
        // normal email sign in process
      } else {
        // normal create account
      }
      authController.markAsAuthenticated();
    }

    Future<void> _submitGoogleAuth() async {
      print(widget.selectedMode);
      if (widget.selectedMode == AuthMode.signIn) {
        // normal email sign in process
      } else {
        // normal create account
      }
      authController.markAsAuthenticated();
    }

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            if (widget.selectedMode == AuthMode.createAccount) ...[
              SizedBox(height: 30),
              TextFormField(
                controller: _userNameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  hintText: "John Doe",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: Icon(Icons.person),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Username is required';
                  }
                  return null;
                },
              ),
            ],
            SizedBox(height: 30),
            TextFormField(
              controller: _emailController,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hint: Text("johndoe@example.com"),
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                prefixIcon: const Icon(
                  Icons.mail_outline,
                  color: Color(0xFF667267),
                  size: 28,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
              // validator: (value) {
              //   return emailValidator(value);
              // },
            ),
            SizedBox(height: 30),
            TextFormField(
              keyboardType: TextInputType.visiblePassword,
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                prefixIcon: Icon(Icons.key),
                hint: Text("********"),
                floatingLabelBehavior: FloatingLabelBehavior.always,

                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                  icon: Icon(
                    showPassword ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
              ),
              obscureText: !showPassword,
              // validator: (value) {
              //   return passwordValidator(
              //     value,
              //     isCreateAccount:
              //         widget.selectedMode == AuthMode.createAccount,
              //   );
              // },
            ),
            SizedBox(height: 50),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isLoading ? null : _submitEmailAuth,

                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.secondary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  widget.selectedMode.label,
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            const SizedBox(height: 24),

            Row(
              children: [
                const Expanded(child: Divider(thickness: 1)),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text('or'),
                ),
                const Expanded(child: Divider(thickness: 1)),
              ],
            ),
            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _submitGoogleAuth,
                icon: const Text(
                  'G',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                label: const Text(
                  'Continue with Google',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: textPrimary,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: TextButton.icon(
                onPressed: () => authController.continueAsGuest(),
                icon: Icon(Icons.person_outline_rounded),
                label: const Text(
                  'Continue as Guest',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                style: TextButton.styleFrom(
                  foregroundColor: textPrimary,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),
            Text(
              'Guest progress stays on this device, with 1 active skill. Sign in later to back it up.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12.0),
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
