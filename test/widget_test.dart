// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:skillz_log/data/app_theme.dart';
import 'package:skillz_log/data/constants.dart';
import 'package:skillz_log/main.dart';

void main() {
  testWidgets('uses the app theme and continues after the splash', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    final splashContext = tester.element(find.text('Skillz Log'));
    expect(find.text('Small steps, visible progress'), findsOneWidget);
    expect(
      Theme.of(splashContext).scaffoldBackgroundColor,
      AppColors.lightBackground,
    );

    await tester.pump(AppDurations.splashDisplay);
    await tester.pumpAndSettle();

    expect(find.text('Light mode'), findsOneWidget);

    await tester.tap(find.byType(Switch));
    await tester.pumpAndSettle();

    expect(find.text('Dark mode'), findsWidgets);
    final homeContext = tester.element(find.text('Dark mode').last);
    expect(Theme.of(homeContext).brightness, Brightness.dark);
  });
}
