import '../../domain/entities/DetailCompte.dart';

abstract class CompteRepository {
  Future<DetailCompte> getDetailCompte();
  Future<void> paiement(String merchant, double amount);
  Future<void> transfer(String merchant, double amount);
}