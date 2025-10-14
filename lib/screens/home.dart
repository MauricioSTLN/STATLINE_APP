import 'package:flutter/material.dart';
import 'team_selection.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Color primary = const Color(0xFF30B274);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo/logo.png', width: 200),
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const TeamSelectionPage()),
                );
              },
              child: Image.asset('assets/botones/iniciar.png', width: 150),
            ),
          ],
        ),
      ),
    );
  }
}
