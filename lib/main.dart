import 'package:flutter/material.dart';
import 'screens/home.dart';

void main() {
  runApp(const StatLineApp());
}

class StatLineApp extends StatelessWidget {
  const StatLineApp({super.key});

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF30B274);
    const secondary = Color(0xFFACFFD7);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'StatLine',
      theme: ThemeData(
        primaryColor: primary,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: primary,
          secondary: secondary,
        ),
        scaffoldBackgroundColor: secondary,
      ),
      home: const HomePage(),
    );
  }
}
