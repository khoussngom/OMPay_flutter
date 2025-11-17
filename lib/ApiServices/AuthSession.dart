import 'package:hive/hive.dart';

class AuthSession {
  static const String _boxName = 'authBox';
  static const String _tokenKey = 'token';
  static const String _refreshTokenKey = 'refreshToken';

  static Future<Box> _getBox() async {
    return await Hive.openBox(_boxName);
  }

  static Future<String?> getToken() async {
    final box = await _getBox();
    return box.get(_tokenKey);
  }

  static Future<String?> getRefreshToken() async {
    final box = await _getBox();
    return box.get(_refreshTokenKey);
  }

  static Future<void> setToken(String? token) async {
    final box = await _getBox();
    if (token != null) {
      await box.put(_tokenKey, token);
    } else {
      await box.delete(_tokenKey);
    }
  }

  static Future<void> setRefreshToken(String? refreshToken) async {
    final box = await _getBox();
    if (refreshToken != null) {
      await box.put(_refreshTokenKey, refreshToken);
    } else {
      await box.delete(_refreshTokenKey);
    }
  }

  static Future<void> clearTokens() async {
    final box = await _getBox();
    await box.delete(_tokenKey);
    await box.delete(_refreshTokenKey);
  }
}
