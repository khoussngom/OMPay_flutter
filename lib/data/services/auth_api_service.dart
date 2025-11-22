import 'dart:convert';
import 'storage_service.dart';
import '../../constants/apiUrl.dart';
import '../../ApiServices/BaseService.dart';

class AuthApiService extends BaseService {
  final StorageService storageService;

  AuthApiService(this.storageService);

  Future<void> login(Map<String, String> authDto) async {
    final uri = Uri.parse(ApiUrls['login']!).replace(queryParameters: authDto);
    final data = await post(uri.toString(), headers: {'accept': '*/*'}, body: '');
    await storageService.saveToken(data['accessToken']);
    await storageService.saveRefreshToken(data['refreshToken']);
  }
}