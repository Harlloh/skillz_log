import 'package:flutter/material.dart';

abstract final class AppDurations {
  static const splashDisplay = Duration(milliseconds: 12000);
}

class KTextStyle {
  static const TextStyle headerTextStyle = TextStyle(
    color: Colors
        .teal, //i want to also handle for dark and light mode i should be able to specify the color for light and dark mode
    fontSize: 10.0,
  );

  static const TextStyle descTextStyle = TextStyle(
    color: Colors.teal,

    ///same with this too
    fontSize: 4.0,
  );
}

abstract final class AppStrings {
  static const String appName = "Skillz Log";
}
