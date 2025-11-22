import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'bindings/app_bindings.dart';
import 'routes/app_routes.dart';
import 'data/services/storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  // Initialize storage service
  final storageService = StorageService();
  await storageService.init();

  // Inject storage service globally
  Get.put<StorageService>(storageService);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'OMPay',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange.shade800),
        useMaterial3: true,
      ),
      initialRoute: AppRoutes.login,
      getPages: AppRoutes.pages,
      initialBinding: AppBindings(),
      debugShowCheckedModeBanner: false,
    );
  }
}
