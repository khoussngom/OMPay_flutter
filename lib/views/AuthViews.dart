import 'dart:io';
import '../domain/entities/AuthDto.dart';
import '../ApiServices/AuthServices.dart';

class AuthViews {
  final AuthServices _authServices = AuthServices();

  Future<void> loginView() async {
    stdout.write('Entrez votre numéro de téléphone: ');
    final String telephone = stdin.readLineSync() ?? '';

    stdout.write('Entrez le mot de passe: ');
    final String password = stdin.readLineSync() ?? '';

    final authDto = AuthDto(telephone: telephone, password: password);

    try {
      await _authServices.login(authDto);
      print('Connexion réussie !');
    } catch (e) {
      print('Échec de la connexion : $e');
    }
  }
}