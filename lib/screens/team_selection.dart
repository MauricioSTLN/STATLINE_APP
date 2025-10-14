import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'prediccion_page.dart';

class TeamSelectionPage extends StatefulWidget {
  const TeamSelectionPage({super.key});

  @override
  _TeamSelectionPageState createState() => _TeamSelectionPageState();
}

class _TeamSelectionPageState extends State<TeamSelectionPage> {
  String? equipoLocal;
  String? equipoVisitante;
  final TextEditingController lineaController = TextEditingController();

  // 🔥 Mapa entre los nombres de escudos (archivos) y los nombres del Excel
  final Map<String, String> teamMap = {
    "49ers": "San Francisco",
    "bears": "Chicago",
    "bengals": "Cincinnati",
    "bills": "Buffalo",
    "broncos": "Denver",
    "browns": "Cleveland",
    "buccaneers": "Tampa Bay",
    "cardinals": "Arizona",
    "chargers": "L.A. Chargers",
    "chiefs": "Kansas City",
    "colts": "Indianapolis",
    "commanders": "Washington",
    "cowboys": "Dallas",
    "dolphins": "Miami",
    "eagles": "Philadelphia",
    "falcons": "Atlanta",
    "giants": "N.Y. Giants",
    "jaguars": "Jacksonville",
    "jets": "N.Y. Jets",
    "lions": "Detroit",
    "packers": "Green Bay",
    "panthers": "Carolina",
    "patriots": "New England",
    "raiders": "Las Vegas",
    "rams": "L.A. Rams",
    "ravens": "Baltimore",
    "saints": "New Orleans",
    "seahawks": "Seattle",
    "steelers": "Pittsburgh",
    "texans": "Houston",
    "titans": "Tennessee",
    "vikings": "Minnesota",
  };

  Future<void> _predecir() async {
    if (equipoLocal == null || equipoVisitante == null || lineaController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Selecciona ambos equipos y la línea")),
      );
      return;
    }

    final double? linea = double.tryParse(lineaController.text);
    if (linea == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Ingresa una línea válida")),
      );
      return;
    }

    try {
      final res = await ApiService.predict(
        local: equipoLocal!,
        visitante: equipoVisitante!,
        linea: linea,
      );

      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PrediccionPage(resultado: res),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error en la API: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<String> teams = teamMap.keys.toList();

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Image.asset('assets/logo.png', width: 397, height: 128),

            const SizedBox(height: 20),

            Expanded(
              child: GridView.count(
                crossAxisCount: 4,
                padding: const EdgeInsets.all(8),
                children: teams.map((team) {
                  bool isSelected = equipoLocal == teamMap[team] || equipoVisitante == teamMap[team];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (equipoLocal == null) {
                          equipoLocal = teamMap[team];
                        } else if (equipoVisitante == null && equipoLocal != teamMap[team]) {
                          equipoVisitante = teamMap[team];
                        } else if (equipoLocal == teamMap[team]) {
                          equipoLocal = null;
                        } else if (equipoVisitante == teamMap[team]) {
                          equipoVisitante = null;
                        }
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: isSelected ? Colors.green : Colors.transparent,
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Image.asset("assets/${team}.png"),
                    ),
                  );
                }).toList(),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              child: TextField(
                controller: lineaController,
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Ingresa línea (ej. 43.5)",
                  hintStyle: const TextStyle(color: Colors.white54),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white54),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.green),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            GestureDetector(
              onTap: _predecir,
              child: Image.asset(
                'assets/comenzar.png',
                width: 350,
                height: 100,
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
