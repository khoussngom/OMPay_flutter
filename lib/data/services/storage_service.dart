import 'package:hive_flutter/hive_flutter.dart';

class StorageService {
  static const String _tokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _tokenBox = 'auth_box';

  Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(_tokenBox);
  }

  Future<void> saveToken(String token) async {
    final box = Hive.box(_tokenBox);
    await box.put(_tokenKey, token);
  }

  Future<void> saveRefreshToken(String refreshToken) async {
    final box = Hive.box(_tokenBox);
    await box.put(_refreshTokenKey, refreshToken);
  }

  String? getToken() {
    final box = Hive.box(_tokenBox);
    return box.get(_tokenKey);
  }

  String? getRefreshToken() {
    final box = Hive.box(_tokenBox);
    return box.get(_refreshTokenKey);
  }

  Future<void> clearTokens() async {
    final box = Hive.box(_tokenBox);
    await box.delete(_tokenKey);
    await box.delete(_refreshTokenKey);
  }

  bool hasToken() {
    return getToken() != null;
  }
}