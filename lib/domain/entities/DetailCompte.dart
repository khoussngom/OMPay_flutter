class DetailCompte {
  final double? solde;
  final String numeroTelephone;
  final String dateOuverture;
  final List<Transaction> transactions;

  DetailCompte({

    this.solde,
    required this.numeroTelephone,
    required this.dateOuverture,
    required this.transactions,
  });

  factory DetailCompte.fromJson(Map<String, dynamic> json) {
    return DetailCompte(
      solde: json['solde'] != null ? (json['solde'] as num).toDouble() : null,
      numeroTelephone: json['numeroTelephone'],
      dateOuverture: json['dateOuverture'],
      transactions: json['transactions'] != null ? (json['transactions'] as List)
          .map((t) => Transaction.fromJson(t))
          .toList() : [],
    );
  }
}

class Transaction {
  final String type;
  final double montant;
  final String date;
  final String? codeMarchand;
  final String? numero;

  Transaction({
    required this.type,
    required this.montant,
    required this.date,
    this.codeMarchand,
    this.numero,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      type: json['type'],
      montant: double.parse(json['montant'].toString()),
      date: json['date'],
      codeMarchand: json['codeMarchand'],
      numero: json['numero'],
    );
  }
}