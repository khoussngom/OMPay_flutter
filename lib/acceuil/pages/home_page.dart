// This file is deprecated - using new architecture in lib/presentation/
// TODO: Remove this file after migration is complete

/*
import 'dart:async';
import 'package:flutter/material.dart';
import '../../ApiServices/DetailCompteService.dart';
import '../../domain/entities/DetailCompte.dart';
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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  // Temporarily commented out - using new architecture
  // final DetailCompteService _detailCompteService = DetailCompteService();
  DetailCompte? _detailCompte;
  bool _isLoading = true;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Commented out to avoid compilation errors
    // _fetchDetailCompte().then((_) {
    //   _timer = Timer.periodic(const Duration(seconds: 1), (_) => _fetchDetailCompte());
    // });
  }

  // Commented out methods to avoid compilation errors
  // Future<void> _fetchDetailCompte() async { ... }
  // Future<void> _handleTransfer(String merchant, double amount, bool isPayer) async { ... }
  // Future<void> _logout() async { ... }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Page d\'accueil temporaire - Utilisez la nouvelle architecture'),
      ),
    );
  }
}
*/