import '../ApiServices/AuthApiService.dart';
import '../entities/AuthDto.dart';

class AuthServices {
  Future<void> login(AuthDto authDto) async {
    await AuthApiService().login(authDto.toJson());
  }
}