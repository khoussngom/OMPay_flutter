import 'package:http/http.dart' as http;
import 'dart:convert';

class BaseService {
  Future<dynamic> get(String url, {Map<String, String>? headers}) async {
    final response = await http.get(Uri.parse(url), headers: headers ?? {});
    return _processResponse(response);
  }

  Future<dynamic> post(String url, {Map<String, String>? headers, dynamic body}) async {
    try {
      final response = await http.post(Uri.parse(url), headers: headers ?? {}, body: body);
      return _processResponse(response);
    } catch (e) {
      throw Exception('Erreur de connexion: $e');
    }
  }

  Future<dynamic> put(String url, {Map<String, String>? headers, dynamic body}) async {
    final response = await http.put(Uri.parse(url), headers: headers ?? {}, body: body);
    return _processResponse(response);
  }

  Future<dynamic> delete(String url, {Map<String, String>? headers}) async {
    final response = await http.delete(Uri.parse(url), headers: headers ?? {});
    return _processResponse(response);
  }

  dynamic _processResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      throw Exception('HTTP ${response.statusCode}: ${response.body}');
    }
  }
}