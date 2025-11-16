import 'package:flutter/material.dart';

class TransferSection extends StatefulWidget {
  const TransferSection({super.key});

  @override
  State<TransferSection> createState() => _TransferSectionState();
}

class _TransferSectionState extends State<TransferSection> {
  bool isPayer = true;
  final TextEditingController merchantController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  @override
  void dispose() {
    merchantController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF2D2D2D),
          width: 2,
        ),
        boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 4,
          offset: Offset(0, 2),
        ),
  ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
        
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => isPayer = true),
                  child: Row(
                    children: [
                      Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.orange.shade700,
                            width: 2,
                          ),
                          color: isPayer ? Colors.orange.shade700 : Colors.transparent,
                        ),
                        child: isPayer
                            ? const Icon(
                                Icons.circle,
                                size:10,
                                color: Colors.white,
                              )
                            : null,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Payer',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 18.0,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => isPayer = false),
                  child: Row(
                    children: [
                      Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                          color: !isPayer ? Colors.white : Colors.transparent,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Transférer',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 18.0,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
        
            ],
          ),
          const SizedBox(height: 32),
          
          TextField(
            controller: merchantController,
            style: const TextStyle(color: Colors.white, fontSize: 18),
            decoration: InputDecoration(
              hintText: 'Saisir le numéro/code marchand',
              hintStyle: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 18.0,
              ),
              filled: true,
              fillColor: const Color(0xFF0D0D0D),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Colors.grey.shade800,
                  width: 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Colors.grey.shade800,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Colors.orange.shade700,
                  width: 2,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
            ),
          ),
          const SizedBox(height: 15),

          TextField(
            controller: amountController,
            keyboardType: TextInputType.number,
            style: const TextStyle(color: Colors.white, fontSize: 18),
            decoration: InputDecoration(
              hintText: 'Saisir le montant',
              hintStyle: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 18,
              ),
              filled: true,
              fillColor: const Color(0xFF0D0D0D),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Colors.grey.shade800,
                  width: 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Colors.grey.shade800,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Colors.orange.shade700,
                  width: 2,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
            ),
          ),
          const SizedBox(height: 25),

          ElevatedButton(
            onPressed: () {

            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange.shade700,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: Text(
              'Valider',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}