import '../../domain/entities/DetailCompte.dart';
import '../../domain/entities/ScheduledTransfer.dart';
import '../services/compte_api_service.dart';
import 'compte_repository.dart';

class CompteRepositoryImpl implements CompteRepository {
  final CompteApiService compteApiService;

  CompteRepositoryImpl(this.compteApiService);

  @override
  Future<DetailCompte> getDetailCompte() async {
    return await compteApiService.getDetailCompte();
  }

  @override
  Future<void> paiement(String merchant, double amount) async {
    await compteApiService.paiement(merchant, amount);
  }

  @override
  Future<void> transfer(String merchant, double amount) async {
    await compteApiService.transfer(merchant, amount);
  }

  @override
  Future<ScheduledTransfer> scheduleTransfer(String numeroTelephoneDest, double montant, String dateProgrammee) async {
    return await compteApiService.scheduleTransfer(numeroTelephoneDest, montant, dateProgrammee);
  }
}