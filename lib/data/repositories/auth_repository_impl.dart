import '../../domain/entities/AuthDto.dart';
import '../services/auth_api_service.dart';
import 'auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApiService authApiService;

  AuthRepositoryImpl(this.authApiService);

  @override
  Future<void> login(AuthDto authDto) async {
    await authApiService.login({
      'telephone': authDto.telephone,
      'password': authDto.password,
    });
  }
}