import 'package:flutter/material.dart';
import 'package:skillz_log/pages/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.green.shade900),
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
