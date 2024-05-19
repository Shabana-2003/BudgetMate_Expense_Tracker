import 'dart:async';
import 'package:budgetmate/features/money_management/presentation/widgets/wrapper.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    
    Timer  (Duration(seconds: 3), () {
      
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>const Wrapper()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 252, 243, 233),
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

