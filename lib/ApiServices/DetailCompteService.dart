import '../entities/DetailCompte.dart';
import '../ApiServices/CompteApiService.dart';

class DetailCompteService {
  final CompteApiService _compteApiService = CompteApiService();

  Future<DetailCompte> getDetailCompte() async {
    final response = await _compteApiService.getDetailCompte();
    return DetailCompte.fromJson(response);
  }

  Future<DetailCompte> transfer(String dest, double montant) async {
    final response = await _compteApiService.transfer(dest, montant);
    return DetailCompte.fromJson(response);
  }
}
