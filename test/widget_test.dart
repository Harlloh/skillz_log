// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:skillz_log/data/app_theme.dart';
import 'package:skillz_log/main.dart';
import 'package:skillz_log/pages/splash_screen.dart';

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

    final splashFades = find.descendant(
      of: find.byType(SplashScreen),
      matching: find.byType(FadeTransition),
    );
    final fades = tester.widgetList<FadeTransition>(splashFades).toList();
    expect(fades, hasLength(3));
    expect(fades[0].opacity.value, 0);
    expect(fades[1].opacity.value, 0);
    expect(fades[2].opacity.value, 0);

    await tester.pump(const Duration(milliseconds: 500));

    expect(fades[0].opacity.value, greaterThan(fades[1].opacity.value));
    expect(fades[1].opacity.value, greaterThan(fades[2].opacity.value));

    await tester.pump(const Duration(milliseconds: 500));

    expect(fades[0].opacity.value, 1);
    expect(fades[1].opacity.value, 1);
    expect(fades[2].opacity.value, 1);

    await tester.pump(const Duration(milliseconds: 200));
    await tester.pumpAndSettle();

    expect(find.text('Sign in'), findsOneWidget);

    await tester.tap(find.text('Sign in'));
    await tester.pumpAndSettle();

    expect(find.text('Light mode'), findsOneWidget);
  });
}
