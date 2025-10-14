import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'prediccion_page.dart';

class TeamSelectionPage extends StatefulWidget {
  const TeamSelectionPage({super.key});

  @override
  State<TeamSelectionPage> createState() => _TeamSelectionPageState();
}

class _TeamSelectionPageState extends State<TeamSelectionPage> {
  String? equipoLocal;
  String? equipoVisitante;

  final Map<String, String> teamImages = {
    "Detroit": "assets/49ers.png",
    "Indianapolis": "assets/colts.png",
    "Buffalo": "assets/bills.png",
    "Dallas": "assets/cowboys.png",
    "Seattle": "assets/seahawks.png",
    "Baltimore": "assets/ravens.png",
    "Tampa Bay": "assets/buccaneers.png",
    "Washington": "assets/commanders.png",
    "Green Bay": "assets/packers.png",
    "Jacksonville": "assets/jaguars.png",
    "Chicago": "assets/bears.png",
    "Kansas City": "assets/chiefs.png",
    "New England": "assets/patriots.png",
    "L.A. Rams": "assets/rams.png",
    "Minnesota": "assets/vikings.png",
    "Pittsburgh": "assets/steelers.png",
    "Philadelphia": "assets/eagles.png",
    "Denver": "assets/broncos.png",
    "N.Y. Jets": "assets/jets.png",
    "Houston": "assets/texans.png",
    "Miami": "assets/dolphins.png",
    "San Francisco": "assets/49ers.png",
    "Arizona": "assets/cardinals.png",
    "Carolina": "assets/panthers.png",
    "N.Y. Giants": "assets/giants.png",
    "L.A. Chargers": "assets/chargers.png",
    "Atlanta": "assets/falcons.png",
    "New Orleans": "assets/saints.png",
    "Cincinnati": "assets/bengals.png",
    "Las Vegas": "assets/raiders.png",
    "Cleveland": "assets/browns.png",
    "Tennessee": "assets/titans.png",
  };

  @override
  Widget build(BuildContext context) {
    final Color primary = const Color(0xFF30B274);

    return Scaffold(
      appBar: AppBar(title: const Text("Seleccionar Equipos"), backgroundColor: primary),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: GridView.count(
                crossAxisCount: 4,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                children: teamImages.keys.map((team) {
                  bool isSelected = equipoLocal == team || equipoVisitante == team;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (equipoLocal == null) {
                          equipoLocal = team;
                        } else if (equipoVisitante == null && equipoLocal != team) {
                          equipoVisitante = team;
                        } else if (equipoLocal == team) {
                          equipoLocal = null;
                        } else if (equipoVisitante == team) {
                          equipoVisitante = null;
                        }
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: isSelected ? primary : Colors.grey, width: 2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Image.asset(teamImages[team]!, fit: BoxFit.contain),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: 350,
              height: 100,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  padding: EdgeInsets.zero,
                  shadowColor: Colors.transparent,
                ),
                onPressed: (equipoLocal != null && equipoVisitante != null)
                    ? () async {
                        double linea = 45.0; // ejemplo, puedes obtener de otro input
                        final res = await ApiService.predict(
                          local: equipoLocal!,
                          visitante: equipoVisitante!,
                          linea: linea,
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
                child: Ink.image(
                  image: const AssetImage("assets/comenzar.png"),
                  fit: BoxFit.cover,
                  child: Container(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
