class ScheduledTransfer {
  final String id;
  final String compteId;
  final String compteDestId;
  final double montant;
  final String dateProgrammee;
  final bool executed;

  ScheduledTransfer({
    required this.id,
    required this.compteId,
    required this.compteDestId,
    required this.montant,
    required this.dateProgrammee,
    required this.executed,
  });

  factory ScheduledTransfer.fromJson(Map<String, dynamic> json) {
    return ScheduledTransfer(
      id: json['id'],
      compteId: json['compteId'],
      compteDestId: json['compteDestId'],
      montant: (json['montant'] as num).toDouble(),
      dateProgrammee: json['dateProgrammee'],
      executed: json['executed'],
    );
  }
}