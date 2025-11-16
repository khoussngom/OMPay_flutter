import 'package:flutter/material.dart';
import '../../ApiServices/DetailCompteService.dart';
import '../../entities/DetailCompte.dart';
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

  @override
  void initState() {
    super.initState();
    _fetchDetailCompte();
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
      body: ListView(
        children: [
          Header(
            title: 'OM Pay',
            subtitle: 'Bienvenue',
            user: user,
          ),
          const SizedBox(height: 20),
          const TransferSection(),
          const SizedBox(height: 20),
          HistorySection(transactions: _detailCompte!.transactions),
        ],
      ),
    );
  }
}