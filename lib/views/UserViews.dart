import 'dart:io';
import '../ApiServices/UserServices.dart';
import '../validators/UserValidators.dart';
import '../validators/Regex.dart';
import '../domain/entities/User.dart';
import '../domain/entities/ClientEntity.dart';

class UserView {
    final UserServices _userServices = UserServices();
    

    Future<void> displayUsers() async {
      try {
        final users = await _userServices.getAllUsers();

        print('Liste des utilisateurs :');
        for (var user in users) {
          final client = user['client'];
          final prenom = client?['prenom'] ?? '';
          final nom = client?['nom'] ?? '';
          final numero = client?['numeroTelephone'] ?? client?['telephone'] ?? '';
          if(prenom != '' || nom != '' || numero != '') {
          print('Prénom: $prenom, Nom: $nom, Numéro: $numero');
          }

        }
      } catch (e) {
        print('Erreur: $e');
      }
    }

  
    Future<void> createUser() async {

    stdout.write('Entrez le prénom: ');
    final prenom = UserValidators.controleSaisie(stdin.readLineSync() ?? '');

    stdout.write('Entrez le nom: ');
    final nom = UserValidators.controleSaisie(stdin.readLineSync() ?? '');

    final email = UserValidators.customValidator(
      Regex.email,
      'Email invalide. Veuillez entrer un email valide.',
      'Entrez l\'email'
    );


    stdout.write('Entrez le nom d\'utilisateur: ');
    final username = UserValidators.controleSaisie(stdin.readLineSync() ?? '');

    final password = UserValidators.verifierPassword();

    final numero = UserValidators.customValidator(
      Regex.senegalPhoneRegex,
      'Numéro de téléphone invalide. Veuillez entrer un numéro valide (10 à 15 chiffres, peut commencer par +).',
      'Entrez le numéro de téléphone'
    );


    final cni = UserValidators.customValidator(
      Regex.isValidSenegalCNI,
      'CNI invalide. Veuillez entrer un CNI valide.',
      'Entrez le numéro de CNI'
    );

    stdout.write('Entrez l\'adresse: ');
    final String adresse =  UserValidators.controleSaisie(
      stdin.readLineSync() ?? ''
    );

    final user = User(
      client: ClientEntity(
          prenom: prenom,
          nom: nom,
          numeroTelephone: numero,
          email: email,
          username: username,
          password: password,
          cni: cni,
          adresse: adresse
        ),
      );

      try {
        await _userServices.createUser(user);
        print('Utilisateur créé avec succès.');
      } catch (e) {
        print('Erreur lors de la création de l\'utilisateur: $e');
      } 
    }
  }
