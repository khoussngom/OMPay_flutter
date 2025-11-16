import 'ClientEntity.dart';

class User {
  ClientEntity client;

  User({required this.client});

  Map<String, dynamic> toJson() {
    return {
      'prenom': client.prenom,
      'nom': client.nom,
      'telephone': client.numeroTelephone,
      'email': client.email,
      'username': client.username,
      'password': client.password,
      'cni': client.cni,
      'adresse': client.adresse,
    };
  }
}