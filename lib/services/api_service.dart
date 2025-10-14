import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://statline-api.onrender.com";

  static Future<Map<String, dynamic>> predict({
    required String local,
    required String visitante,
    required double linea,
  }) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/predict?local=$local&visitante=$visitante&linea=$linea"),
      );

      if (response.statusCode == 200) {
        return Map<String, dynamic>.from(json.decode(response.body));
      } else {
        return {"error": "Error en la API: ${response.statusCode}"};
      }
    } catch (e) {
      return {"error": e.toString()};
    }
  }
}
