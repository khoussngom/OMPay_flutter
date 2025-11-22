import '../domain/entities/DetailCompte.dart';
import '../ApiServices/CompteApiService.dart';
import '../data/services/storage_service.dart';

class DetailCompteService {
  final StorageService storageService;

  DetailCompteService(this.storageService);

  Future<DetailCompte> getDetailCompte() async {
    final compteApiService = CompteApiService(storageService);
    final response = await compteApiService.getDetailCompte();
    return DetailCompte.fromJson(response);
  }

  Future<DetailCompte> transfer(String dest, double montant) async {
    final compteApiService = CompteApiService(storageService);
    final response = await compteApiService.transfer(dest, montant);
    return DetailCompte.fromJson(response);
  }

  Future<DetailCompte> paiement(String marchand, double montant) async {
    final compteApiService = CompteApiService(storageService);
    final response = await compteApiService.paiement(marchand, montant);
    return DetailCompte.fromJson(response);
  }
}
