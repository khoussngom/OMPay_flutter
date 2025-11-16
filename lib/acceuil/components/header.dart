import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String title;
  final String subtitle;
  final dynamic user;

  const Header({
    super.key,
    required this.title,
    required this.subtitle,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF2D2D2D),
        borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(16),
        bottomRight: Radius.circular(16),
      ),

      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
  
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              
                const Icon(
                  Icons.menu,
                  size: 32,
                  color: Colors.white,
                ),
                const SizedBox(height: 24),
        
                Row(
                  children: [
                    Text(
                      'Bonjour ',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18.0,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        user['numeroTelephone'] ?? '',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Colors.orange.shade700,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
              
                Row(
                  children: [
                    Text(
                      '${user['solde']} ',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.orange.shade700,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    Text(
                      'FCFA',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18.0,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      Icons.visibility_off,
                      color: Colors.white,
                      size: 24,
                    ),
                  ],
                ),
              ],
            ),
          ),
    
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.white,
                width: 8,
              ),
            ),
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: user['qrcodeUrl'] != null
                    ? DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(user['qrcodeUrl']),
                      )
                    : null,
              ),
              child: user['qrcodeUrl'] == null
                  ? const Center(
                      child: Icon(
                        Icons.qr_code_2,
                        size: 70,
                        color: Colors.black,
                      ),
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}