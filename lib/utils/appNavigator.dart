import 'package:flutter/material.dart';

class AppNavigator {
  AppNavigator._();

  static Future<T?> push<T>(BuildContext context, Widget screen){
    return Navigator.of(context).push<T>(
      MaterialPageRoute(builder: (_) => screen)
    );
  }
  static Future<T?> replace<T, TO>(BuildContext context, Widget screen){
    return Navigator.of(context).pushReplacement<T, TO>(
      MaterialPageRoute(builder: (_) => screen)
    );
  }
    static Future<T?> pushAndClear<T>(
    BuildContext context,
    Widget screen,
  ) {
    return Navigator.of(context).pushAndRemoveUntil<T>(
      MaterialPageRoute(
        builder: (_) => screen,
      ),
      (_) => false,
    );
  }

  static void pop<T>(
    BuildContext context, [
    T? result,
  ]) {
    Navigator.of(context).pop<T>(result);
  }
}