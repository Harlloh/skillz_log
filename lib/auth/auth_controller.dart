import 'package:flutter/material.dart';

enum AuthStatus { checking, authenticated, unauthenticated }

class AuthController extends ValueNotifier<AuthStatus> {
  //AuthController inherits the behavior of ValueNotifier(stores values and notifiers the listner when the value changes)
  AuthController()
    : super(AuthStatus.checking); //create 'checking as the initial value

  Future<void> initialize() async {
    //replace this with the real session check later
    await Future<void>.delayed(Duration(milliseconds: 1200));
    value = AuthStatus.unauthenticated;
  }

  void markAsAuthenticated() {
    value = AuthStatus.authenticated;
  }

  void signOut() {
    value = AuthStatus.unauthenticated;
  }
}

final authController = AuthController();
