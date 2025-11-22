import '../entities/DetailCompte.dart';
import '../../data/repositories/compte_repository.dart';

class GetDetailCompteUseCase {
  final CompteRepository compteRepository;

  GetDetailCompteUseCase(this.compteRepository);

  Future<DetailCompte> execute() async {
    return await compteRepository.getDetailCompte();
  }
}