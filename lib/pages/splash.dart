import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz_app/pages/home.dart';

class START extends StatelessWidget {
  const START({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

 
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => Qhome(),
            ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
           gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.purple[200]!, 
              Colors.purple[100]!, 
              Colors.purple[50]!,  
            ],
          ),
        ),
       child: Center(
  child: Column(
    mainAxisSize: MainAxisSize.min, 
    children: [
      SizedBox(
        width: 100,
        height: 100,
        child: Image.asset(
          'lib/assets/images/quiz.png',
          fit: BoxFit.contain,
        ),
      ),
      const SizedBox(height: 20), 
      Text(
        'Quizly',
        style: GoogleFonts.poppins(
          fontSize: 40,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    ],
  ),
),

      ),
    );
  }
}