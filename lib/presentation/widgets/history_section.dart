import 'package:flutter/material.dart';
import '../../domain/entities/DetailCompte.dart';

class HistorySection extends StatelessWidget {
  final List<Transaction> transactions;

  const HistorySection({super.key, required this.transactions});

  IconData _getTransactionIcon(String type) {
    switch (type.toUpperCase()) {
      case 'DEPOT':
        return Icons.account_balance_wallet;
      case 'TRANSFERT':
      case 'TRANSFERT D\'ARGENT':
        return Icons.phone_android;
      case 'TRANSFERT NATIONAL':
        return Icons.account_balance_wallet;
      default:
        return Icons.credit_card;
    }
  }

  Color _getAmountColor(String type) {
    return type.toUpperCase() == 'DEPOT' || type.toUpperCase() == 'TRANSFERT_ENTRANT'
        ? const Color(0xFF4CAF50)
        : const Color(0xFFFF5252);
  }

  String _formatAmount(double montant, String type) {
    final isPositive = type.toUpperCase() == 'DEPOT' || type.toUpperCase() == 'TRANSFERT_ENTRANT';
    return '${isPositive ? '+' : ''} ${montant.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]} ')} CFA';
  }

String formatJourMois(String date) {
  try {
    final d = DateTime.parse(date);
    return "${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}";
  } catch (e) {
    return date;
  }
}


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Historique des transactions',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          if (transactions.isEmpty)
            const Text(
              'Aucune transaction trouvée.',
              style: TextStyle(color: Colors.white70, fontSize: 18),
            )
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2C2C2E),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  
                    children: [
                      Row(
                        children: [
                          Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: const Color(0xFF3C3C3E),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          _getTransactionIcon(transaction.type),
                          color: Colors.white70,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 16),
                    
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              transaction.type,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              transaction.codeMarchand ?? 
                              (transaction.type.toUpperCase().contains('TRANSFERT') 
                                ? '785441721' 
                                : '776363260'),
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white60,
                              ),
                            ),
                          ],
                        ),
                      ),
                        ]),
                      
                    
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [

                          Text(
                            _formatAmount(transaction.montant, transaction.type),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: _getAmountColor(transaction.type),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            formatJourMois(transaction.date),
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white60,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}