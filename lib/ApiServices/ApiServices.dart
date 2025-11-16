import 'dart:convert';
import '../constants/apiUrl.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  Future<List<dynamic>> getAllUsers() async {
    final response = await http.get(Uri.parse(ApiUrls['getUser']!));
    if (response.statusCode == 200) {
      return jsonDecode(response.body) as List<dynamic>;
    }
    throw Exception('Erreur: ${response.statusCode}');
  }

  Future<void> createUser(Map<String, dynamic> userData) async {
    final response = await http.post(
      Uri.parse(ApiUrls['createUser']!),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(userData),
    );
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Erreur: ${response.statusCode}');
    }
  }
}