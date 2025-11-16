import 'dart:io';
import '../entities/DetailCompte.dart';
import '../ApiServices/DetailCompteService.dart';

class CompteViews {
  final DetailCompteService _detailCompteService = DetailCompteService();

  Future<void> afficherDetailCompte() async {
    try {
      DetailCompte detail = await _detailCompteService.getDetailCompte();
      print("Détails du compte:");
      print("Solde: ${detail.solde}");
      print("Numéro de téléphone: ${detail.numeroTelephone}");
      print("Date d'ouverture: ${detail.dateOuverture}");
      print("Transactions:");
      for (var trans in detail.transactions) {
        print(" - ${trans.type}: ${trans.montant} (${trans.date})");
      }
    } catch (e) {
      print("Erreur lors de la récupération des détails du compte: $e");
    }
  }

  Future<void> transferView() async {
    stdout.write('Entrez le numéro de téléphone destinataire: ');
    final String dest = stdin.readLineSync() ?? '';

    stdout.write('Entrez le montant à transférer: ');
    final String montantStr = stdin.readLineSync() ?? '';
    final double? montant = double.tryParse(montantStr);

    if (montant == null || montant <= 0) {
      print('Montant invalide.');
      return;
    }

    try {
      DetailCompte updatedDetail = await _detailCompteService.transfer(dest, montant);
      print("Transfert effectué avec succès !");
      print("Nouveau solde: ${updatedDetail.solde}");
    } catch (e) {
      print("Erreur lors du transfert: $e");
    }
  }
}
