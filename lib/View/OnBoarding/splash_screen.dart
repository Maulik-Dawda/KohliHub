import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virat_kohli/View/OnBoarding/second_intro.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3), () {
      Get.to(() => SecondIntro());
    });

    return Scaffold(
      body: Image(
        image: AssetImage('assets/images/splash.png'),
        height: double.infinity,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}
