import 'package:flutter/material.dart';
import 'team_selection.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo.png', width: 397, height: 128),
            const SizedBox(height: 50),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TeamSelectionPage()),
                );
              },
              child: Image.asset('assets/comenzar.png', width: 350, height: 100),
            ),
          ],
        ),
      ),
    );
  }
}
