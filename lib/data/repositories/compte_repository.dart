import '../../domain/entities/DetailCompte.dart';
import '../../domain/entities/ScheduledTransfer.dart';

abstract class CompteRepository {
  Future<DetailCompte> getDetailCompte();
  Future<void> paiement(String merchant, double amount);
  Future<void> transfer(String merchant, double amount);
  Future<ScheduledTransfer> scheduleTransfer(String numeroTelephoneDest, double montant, String dateProgrammee);
}