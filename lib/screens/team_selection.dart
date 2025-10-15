import 'package:flutter/material.dart';
import '../services/api_service.dart';  // Solo tu servicio
import 'prediccion_page.dart';          // Página de predicción

class TeamSelectionPage extends StatefulWidget {
  const TeamSelectionPage({super.key});

  @override
  State<TeamSelectionPage> createState() => _TeamSelectionPageState();
}

class _TeamSelectionPageState extends State<TeamSelectionPage> {
  String? local;
  String? visitante;

  final List<Map<String, String>> equipos = [
    {"Team": "Detroit", "asset": "assets/49ers.png"},
    {"Team": "Indianapolis", "asset": "assets/colts.png"},
    {"Team": "Buffalo", "asset": "assets/bills.png"},
    {"Team": "Dallas", "asset": "assets/cowboys.png"},
    {"Team": "Seattle", "asset": "assets/seahawks.png"},
    {"Team": "Baltimore", "asset": "assets/ravens.png"},
    {"Team": "Tampa Bay", "asset": "assets/buccaneers.png"},
    {"Team": "Washington", "asset": "assets/commanders.png"},
    {"Team": "Green Bay", "asset": "assets/packers.png"},
    {"Team": "Jacksonville", "asset": "assets/jaguars.png"},
    {"Team": "Chicago", "asset": "assets/bears.png"},
    {"Team": "Kansas City", "asset": "assets/chiefs.png"},
    {"Team": "New England", "asset": "assets/patriots.png"},
    {"Team": "L.A. Rams", "asset": "assets/rams.png"},
    {"Team": "Minnesota", "asset": "assets/vikings.png"},
    {"Team": "Pittsburgh", "asset": "assets/steelers.png"},
    {"Team": "Philadelphia", "asset": "assets/eagles.png"},
    {"Team": "Denver", "asset": "assets/broncos.png"},
    {"Team": "N.Y. Jets", "asset": "assets/jets.png"},
    {"Team": "Houston", "asset": "assets/texans.png"},
    {"Team": "Miami", "asset": "assets/dolphins.png"},
    {"Team": "San Francisco", "asset": "assets/49ers.png"},
    {"Team": "Arizona", "asset": "assets/cardinals.png"},
    {"Team": "Carolina", "asset": "assets/panthers.png"},
    {"Team": "N.Y. Giants", "asset": "assets/giants.png"},
    {"Team": "L.A. Chargers", "asset": "assets/chargers.png"},
    {"Team": "Atlanta", "asset": "assets/falcons.png"},
    {"Team": "New Orleans", "asset": "assets/saints.png"},
    {"Team": "Cincinnati", "asset": "assets/bengals.png"},
    {"Team": "Las Vegas", "asset": "assets/raiders.png"},
    {"Team": "Cleveland", "asset": "assets/browns.png"},
    {"Team": "Tennessee", "asset": "assets/titans.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecciona Equipos'),
        backgroundColor: const Color(0xFF30B274),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.count(
              crossAxisCount: 4,
              children: equipos.map((e) {
                final isSelected = e['Team'] == local || e['Team'] == visitante;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (local == null) {
                        local = e['Team'];
                      } else if (visitante == null && e['Team'] != local) {
                        visitante = e['Team'];
                      } else if (e['Team'] == local) {
                        local = null;
                      } else if (e['Team'] == visitante) {
                        visitante = null;
                      }
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isSelected ? Colors.green : Colors.transparent,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Expanded(child: Image.asset(e['asset']!, fit: BoxFit.contain)),
                        Text(
                          e['Team']!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF30B274),
                minimumSize: const Size.fromHeight(60),
              ),
              onPressed: (local != null && visitante != null)
                  ? () async {
                      final res = await ApiService.predict(
                        local: local!,
                        visitante: visitante!,
                        linea: 45.0,
                      );
                      if (!mounted) return;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PrediccionPage(resultado: res),
                        ),
                      );
                    }
                  : null,
              child: Image.asset('assets/comenzar.png', width: 350, height: 100),
            ),
          ),
        ],
      ),
    );
  }
}
