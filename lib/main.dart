import 'package:flutter/material.dart';
import 'package:rolling_Dice/homescreen.dart';
void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // to remove the debug label
      home: HomeScreen(),
    );
  }
}
