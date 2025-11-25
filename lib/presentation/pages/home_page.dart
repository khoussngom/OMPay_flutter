import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../widgets/header.dart';
import '../widgets/transfer_section.dart';
import '../widgets/history_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find();
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.grey.shade900,
      drawer: _buildDrawer(controller),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final detailCompte = controller.detailCompte.value;
        if (detailCompte == null) {
          return const Center(child: Text('Erreur de chargement des données'));
        }

        final user = {
          'numeroTelephone': detailCompte.numeroTelephone,
          'solde': detailCompte.solde,
          'qrcodeUrl': 'https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=${detailCompte.numeroTelephone}',
        };

        return ListView(
          children: [
            Header(
              title: '',
              subtitle: 'Bienvenue',
              user: user,
              onMenuPressed: () => scaffoldKey.currentState?.openDrawer(),
            ),
            const SizedBox(height: 20),
            TransferSection(onTransfer: controller.handleTransaction),
            const SizedBox(height: 20),
            HistorySection(transactions: detailCompte.transactions),
          ],
        );
      }),
    );
  }

  Widget _buildDrawer(HomeController controller) {
    return Drawer(
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
            onTap: () {
              Get.back(); // Fermer le drawer
              controller.logout();
            },
          ),
        ],
      ),
    );
  }
}