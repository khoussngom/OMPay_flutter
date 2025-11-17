import 'dart:async';
import 'package:flutter/material.dart';
import '../../ApiServices/DetailCompteService.dart';
import '../../entities/DetailCompte.dart';
import '../../ApiServices/AuthSession.dart';
import '../../auth/pages/login_page.dart';
import '../components/header.dart';
import '../components/transfer_section.dart';
import '../components/history_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DetailCompteService _detailCompteService = DetailCompteService();
  DetailCompte? _detailCompte;
  bool _isLoading = true;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _fetchDetailCompte().then((_) {
      _timer = Timer.periodic(const Duration(seconds: 1), (_) => _fetchDetailCompte());
    });
  }

  Future<void> _fetchDetailCompte() async {
    try {
      final detail = await _detailCompteService.getDetailCompte();
      setState(() {
        _detailCompte = detail;
        _isLoading = false;
      });
    } catch (e) {

      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur lors du chargement: $e')),
        );
      }
    }
  }

  Future<void> _handleTransfer(String merchant, double amount, bool isPayer) async {
    if (isPayer) {
      await _detailCompteService.paiement(merchant, amount);
    } else {
      await _detailCompteService.transfer(merchant, amount);
    }
  }

  Future<void> _logout() async {
    await AuthSession.clearTokens();
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_detailCompte == null) {
      return const Scaffold(
        body: Center(child: Text('Erreur de chargement des données')),
      );
    }

    final user = {
      'numeroTelephone': _detailCompte!.numeroTelephone,
      'solde': _detailCompte!.solde,
      'qrcodeUrl': 'https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=${_detailCompte!.numeroTelephone}',
    };

    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        title: const Text('OM Pay'),
        backgroundColor: Colors.orange.shade800,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.orange.shade800,
              ),
              child: const Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Déconnexion'),
              onTap: _logout,
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          Header(
            title: '',
            subtitle: 'Bienvenue',
            user: user,
          ),
          const SizedBox(height: 20),
          TransferSection(onTransfer: _handleTransfer),
          const SizedBox(height: 20),
          HistorySection(transactions: _detailCompte!.transactions),
        ],
      ),
    );
  }
}