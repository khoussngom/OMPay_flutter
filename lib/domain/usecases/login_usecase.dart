import '../entities/AuthDto.dart';
import '../../data/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository authRepository;

  LoginUseCase(this.authRepository);

  Future<void> execute(AuthDto authDto) async {
    return await authRepository.login(authDto);
  }
}