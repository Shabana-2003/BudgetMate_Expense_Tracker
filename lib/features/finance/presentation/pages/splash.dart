import 'dart:async';
import 'package:budgetmate/features/finance/presentation/widgets/wrapper.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Wrapper()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:const Color.fromARGB(255, 252, 243, 233),
      body: Center(
        child: Image.asset(
          'assets/images/budgetmate_splash_img.png',
          width: 260,
          height: 260,
        ),
      ),
    );
  }
}
