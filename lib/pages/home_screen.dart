import 'package:flutter/material.dart';
import 'package:skillz_log/data/constants.dart';
import 'package:skillz_log/widgets/header_widget.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.accountType});
  final AccType accountType;

  @override
  Widget build(BuildContext context) {
    final date = DateFormat('EEEE, MMMM d').format(DateTime.now());
    final theme = Theme.of(context);
    // final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      // appBar: AppBar(
      //   // actions: [
      //   //   IconButton(
      //   //     onPressed: () {
      //   //       AppThemeController.setDarkMode(!isDarkMode);
      //   //     },
      //   //     icon: Icon(Icons.swipe),
      //   //   ),
      //   // ],
      // ),
      // bottomNavigationBar: BottomNavigationBar(items: [

      // ]),
      body: Column(
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
        ],
      ),
    );
  }
}
