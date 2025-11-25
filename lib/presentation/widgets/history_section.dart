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

  String _formatRecipientInfo(Transaction transaction) {
    if (transaction.numero != null) {
      // Format phone number for better readability
      String phone = transaction.numero!;
      if (phone.startsWith('+221')) {
        // Format Senegalese phone number: +221 77 123 45 67
        String number = phone.substring(4); // Remove +221
        if (number.length == 9) {
          return '+221 ${number.substring(0, 2)} ${number.substring(2, 5)} ${number.substring(5, 7)} ${number.substring(7)}';
        }
      }
      return phone; // Return as is if not a standard format
    } else if (transaction.codeMarchand != null) {
      // Handle merchant codes
      String code = transaction.codeMarchand!.trim();
      if (code.startsWith('MRC-')) {
        return 'Marchand ${code}';
      } else if (RegExp(r'^\d{9}$').hasMatch(code)) {
          
        return '${code.substring(0, 2)} ${code.substring(2, 5)} ${code.substring(5, 7)} ${code.substring(7)}';
      }
      return code;
    }
    return 'N/A';
  }

String formatJourMois(String date) {
try {
  final d = DateTime.parse(date);
  return "${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}";
} catch (e) {
  return date;
}
}

void _showTransactionDetails(BuildContext context, Transaction transaction) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: '',
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) {
      return ScaleTransition(
        scale: Tween<double>(
          begin: 0.8,
          end: 1.0,
        ).animate(CurvedAnimation(
          parent: animation,
          curve: Curves.elasticOut,
        )),
        child: FadeTransition(
          opacity: animation,
          child: AlertDialog(
            backgroundColor: const Color(0xFF2C2C2E),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            titlePadding: EdgeInsets.zero,
            contentPadding: const EdgeInsets.all(24),
            title: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Color(0xFF3C3C3E),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: _getAmountColor(transaction.type).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      _getTransactionIcon(transaction.type),
                      color: _getAmountColor(transaction.type),
                      size: 32,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          transaction.type,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Transaction ${transaction.type.toLowerCase()}',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailCard(
                    'Montant',
                    '${transaction.montant.toStringAsFixed(2)} CFA',
                    Icons.account_balance_wallet,
                    _getAmountColor(transaction.type),
                  ),
                  const SizedBox(height: 16),
                  _buildDetailCard(
                    'Date et heure',
                    _formatFullDate(transaction.date),
                    Icons.calendar_today,
                    Colors.blue,
                  ),
                  if (transaction.numero != null) ...[
                    const SizedBox(height: 16),
                    _buildDetailCard(
                      'Destinataire',
                      _formatRecipientInfo(transaction),
                      Icons.phone,
                      Colors.green,
                    ),
                  ],
                  if (transaction.codeMarchand != null) ...[
                    const SizedBox(height: 16),
                    _buildDetailCard(
                      'Code marchand',
                      transaction.codeMarchand!,
                      Icons.store,
                      Colors.purple,
                    ),
                  ],
                  const SizedBox(height: 16),
                  _buildDetailCard(
                    'Statut',
                    'Terminée',
                    Icons.check_circle,
                    Colors.green,
                  ),
                  const SizedBox(height: 16),
                  _buildDetailCard(
                    'Référence',
                    'TXN-${transaction.date.substring(0, 10).replaceAll('-', '')}-${transaction.montant.toStringAsFixed(0)}',
                    Icons.tag,
                    Colors.orange,
                  ),
                ],
              ),
            ),
            
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Fermer',
                  style: TextStyle(
                    color: Colors.orange,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget _buildDetailCard(String label, String value, IconData icon, Color iconColor) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFF3C3C3E),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: Colors.white.withOpacity(0.1),
        width: 1,
      ),
    ),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: iconColor,
            size: 20,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

String _formatFullDate(String date) {
  try {
    final d = DateTime.parse(date);
    return "${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year} ${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}:${d.second.toString().padLeft(2, '0')}";
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
                return GestureDetector(
                  onTap: () => _showTransactionDetails(context, transaction),
                  child: Container(
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
                              _formatRecipientInfo(transaction),
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
                ),
                );
              },
            ),
        ],
      ),
    );
  }
}