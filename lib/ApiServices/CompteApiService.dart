import 'dart:convert';
import '../constants/apiUrl.dart';
import '../data/services/storage_service.dart';
import '../ApiServices/BaseService.dart';

class CompteApiService extends BaseService {
  final StorageService storageService;

  CompteApiService(this.storageService);

  Future<List<dynamic>> fetchComptes() async {
    final data = await get(ApiUrls['getComptes']!);
    return data as List<dynamic>;
  }

  Future<Map<String, dynamic>> getDetailCompte() async {
    final token = storageService.getToken();
    final data = await get(ApiUrls['getDetailCompte']!, headers: {'Authorization': 'Bearer $token'});
    return data['data'];
  }

  Future<Map<String, dynamic>> transfer(String dest, double montant) async {
    final token = storageService.getToken();
    final url = '${ApiUrls['transfert']}?dest=$dest&montant=$montant';
    final data = await post(url, headers: {'Authorization': 'Bearer $token'});
    return data['data'];
  }

  Future<Map<String, dynamic>> paiement(String marchand, double montant) async {
    final token = storageService.getToken();
    final url = '${ApiUrls['paiement']}?marchand=$marchand&montant=$montant';
    final data = await post(url, headers: {'Authorization': 'Bearer $token'});
    return data['data'];
  }

  Future<dynamic> createCompte(Map<String, dynamic> compteData) async {
    final data = await post(ApiUrls['createCompte']!, headers: {'Content-Type': 'application/json'}, body: jsonEncode(compteData));
    return data;
  }
}