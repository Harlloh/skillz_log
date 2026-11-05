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

enum AuthMode {
  signIn(key: 'signIn', label: 'Sign-In'),
  createAccount(key: 'createAccount', label: 'Create Account');

  const AuthMode({required this.key, required this.label});

  final String key;
  final String label;
}

enum AccType {
  guest(
    key: 'guest',
    label: "Guest",
    icon: Icons.phone_android,
    desc: 'On this device',
  ),
  notGuest(
    key: 'cloudAcc',
    label: "Synced",
    icon: Icons.cloud_done_outlined,
    desc: '',
  );

  const AccType({
    required this.key,
    required this.label,
    required this.icon,
    required this.desc,
  });

  final String key;
  final String label;
  final IconData icon;
  final String desc;

  dynamic get displayText => '$label $desc';
}

class SkillCardType {
  final String skill;
  final String topic;
  final String status;
  final String description;
  final int session;
  final int totalSessions;
  final int minutes;
  final String tryText;

  const SkillCardType({
    required this.skill,
    required this.topic,
    required this.description,
    required this.status,
    required this.session,
    required this.totalSessions,
    required this.minutes,
    required this.tryText,
  });
}

class SkillListType {
  final String title;
  final String skillLevel;
  final String category;
  final String status;
  final int session;
  final int totalSessions;

  const SkillListType({
    required this.title,
    required this.skillLevel,
    required this.category,
    required this.status,
    required this.session,
    required this.totalSessions,
  });
}
