import 'package:flutter/material.dart';
import 'package:skillz_log/data/constants.dart';
import 'package:skillz_log/pages/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {
@override
void initState() {
  super.initState();
  _continueToApp();
}

Future<void> _continueToApp ()async{
  await Future<void>.delayed(Duration(microseconds: App.standard));

  if(!mounted)return;

  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
    return const HomeScreen();
  },));
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: AppColors.primaryBg,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/image/logo.png'),
            Text("Skillz Log", style: KTextStyle.headerTextStyle,),
            Text("Small steps, visible progress", style: KTextStyle.descTextStyle,)
          ],
        ),
      ),
    );
  }
}
