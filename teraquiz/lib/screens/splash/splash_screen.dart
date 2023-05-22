import 'package:flutter/material.dart';
import 'package:teraquiz/configs/themes/app_colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: mainGradient()
        ),
        child: Center(
          child: Container(
            width: 200,
            height: 200,
            child: Center(child: Image.asset("assets/images/app_splash_logo.png")),
          ),
        ),
      )
    );
  }
}
