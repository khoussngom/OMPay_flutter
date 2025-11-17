import 'dart:convert';
import '../ApiServices/AuthSession.dart';
import '../constants/apiUrl.dart';
import '../ApiServices/BaseService.dart';

class AuthApiService extends BaseService {
  Future<void> login(Map<String, String> authDto) async {
    final uri = Uri.parse(ApiUrls['login']!).replace(queryParameters: authDto);
    print('URI: ${uri.toString()}');
    final data = await post(uri.toString(), headers: {'accept': '*/*'}, body: '');
    print('Response data: $data');
    await AuthSession.setToken(data['accessToken']);
    await AuthSession.setRefreshToken(data['refreshToken']);
  }
}