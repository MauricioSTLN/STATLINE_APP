import 'package:flutter/material.dart';
import 'screens/home.dart';

void main() {
  runApp(const StatLineApp());
}

class StatLineApp extends StatelessWidget {
  const StatLineApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StatLine',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF30B274),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const HomeScreen(),
    );
  }
}
