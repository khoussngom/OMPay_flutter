import '../entities/DetailCompte.dart';
import '../../data/repositories/compte_repository.dart';

class PaiementUseCase {
  final CompteRepository compteRepository;

  PaiementUseCase(this.compteRepository);

  Future<void> execute(String merchant, double amount) async {
    return await compteRepository.paiement(merchant, amount);
  }
}