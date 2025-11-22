import '../../domain/entities/AuthDto.dart';

abstract class AuthRepository {
  Future<void> login(AuthDto authDto);
}