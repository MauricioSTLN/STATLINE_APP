import 'package:flutter/material.dart';

class PrediccionPage extends StatelessWidget {
  final Map<String, dynamic> resultado;
  const PrediccionPage({super.key, required this.resultado});

  @override
  Widget build(BuildContext context) {
    final Color primary = const Color(0xFF30B274);

    if (resultado.containsKey('error')) {
      return Scaffold(
        appBar: AppBar(title: const Text('Predicción'), backgroundColor: primary),
        body: Center(child: Text('Error: ${resultado['error']}\n${resultado['body'] ?? ''}')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Predicción'), backgroundColor: primary),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('LOCAL: ${resultado['equipo_local']}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF30B274))),
            const SizedBox(height: 8),
            Text('VISITANTE: ${resultado['equipo_visitante']}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('LÍNEA: ${resultado['linea']}', style: const TextStyle(fontSize: 16)),
            Text('TOTAL ESTIMADO: ${resultado['total_estimado']}', style: const TextStyle(fontSize: 16)),
            Text('DECISIÓN: ${resultado['resultado']}', style: TextStyle(fontSize: 16, color: resultado['resultado']=='OVER' ? Colors.red : Colors.green)),
            Text('CONFIANZA: ${resultado['confianza']}%', style: const TextStyle(fontSize: 16)),
            const Spacer(),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: primary),
                onPressed: () => Navigator.pop(context),
                child: const Text('Volver', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
