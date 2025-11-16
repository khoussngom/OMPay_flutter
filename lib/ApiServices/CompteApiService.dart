import 'dart:convert';
import '../constants/apiUrl.dart';
import '../ApiServices/AuthSession.dart';
import '../ApiServices/BaseService.dart';

class CompteApiService extends BaseService {
  Future<List<dynamic>> fetchComptes() async {
    final data = await get(ApiUrls['getComptes']!);
    return data as List<dynamic>;
  }

  Future<Map<String, dynamic>> getDetailCompte() async {
    final data = await get(ApiUrls['getDetailCompte']!, headers: {'Authorization': 'Bearer ${AuthSession.token}'});
    return data['data'];
  }

  Future<Map<String, dynamic>> transfer(String dest, double montant) async {
    final url = '${ApiUrls['transfert']}?dest=$dest&montant=$montant';
    final data = await post(url, headers: {'Authorization': 'Bearer ${AuthSession.token}'});
    return data['data'];
  }

  Future<dynamic> createCompte(Map<String, dynamic> compteData) async {
    final data = await post(ApiUrls['createCompte']!, headers: {'Content-Type': 'application/json'}, body: jsonEncode(compteData));
    return data;
  }
}