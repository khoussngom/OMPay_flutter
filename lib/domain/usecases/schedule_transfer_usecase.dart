import '../entities/ScheduledTransfer.dart';
import '../../data/repositories/compte_repository.dart';

class ScheduleTransferUseCase {
  final CompteRepository compteRepository;

  ScheduleTransferUseCase(this.compteRepository);

  Future<ScheduledTransfer> execute(String numeroTelephoneDest, double montant, String dateProgrammee) async {
    return await compteRepository.scheduleTransfer(numeroTelephoneDest, montant, dateProgrammee);
  }
}