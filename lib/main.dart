import 'package:flutter/material.dart';
import 'package:quiz_app/pages/splash.dart';

void main() {
  runApp(const MyApp());
}
 class MyApp extends StatefulWidget {
   const MyApp({super.key});
 
   @override
   State<MyApp> createState() => _MyAppState();
 }
 
 class _MyAppState extends State<MyApp> {
   @override
   Widget build(BuildContext context) {
     return MaterialApp(
      title: 'Quiz App',
      debugShowCheckedModeBanner: false,
      home: SplashScreen()
     );

   }
 }