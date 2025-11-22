import '../entities/DetailCompte.dart';
import '../../data/repositories/compte_repository.dart';

class TransferUseCase {
  final CompteRepository compteRepository;

  TransferUseCase(this.compteRepository);

  Future<void> execute(String recipient, double amount) async {
    return await compteRepository.transfer(recipient, amount);
  }
}