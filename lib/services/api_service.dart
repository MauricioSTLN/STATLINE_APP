import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // Endpoint de tu API en Render
  static const String baseUrl = "https://statline-api.onrender.com/predict";

  // Método para obtener predicción
  static Future<Map<String, dynamic>> predict({
    required String local,
    required String visitante,
    required double linea,
  }) async {
    try {
      final uri = Uri.parse(baseUrl).replace(queryParameters: {
        "local": local,
        "visitante": visitante,
        "linea": linea.toString(),
      });

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        return json.decode(response.body) as Map<String, dynamic>;
      } else {
        return {"error": "Error en la API: ${response.statusCode}"};
      }
    } catch (e) {
      return {"error": e.toString()};
    }
  }
}
