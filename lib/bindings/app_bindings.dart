import 'package:get/get.dart';
import '../data/services/storage_service.dart';
import '../data/services/auth_api_service.dart';
import '../data/services/compte_api_service.dart';
import '../data/repositories/auth_repository.dart';
import '../data/repositories/compte_repository.dart';
import '../data/repositories/auth_repository_impl.dart';
import '../data/repositories/compte_repository_impl.dart';
import '../domain/usecases/login_usecase.dart';
import '../domain/usecases/get_detail_compte_usecase.dart';
import '../domain/usecases/paiement_usecase.dart';
import '../domain/usecases/transfer_usecase.dart';
import '../presentation/controllers/auth_controller.dart';
import '../presentation/controllers/home_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    // Storage Service is already initialized in main.dart

    // Services
    Get.lazyPut<AuthApiService>(() => AuthApiService(Get.find<StorageService>()));
    Get.lazyPut<CompteApiService>(() => CompteApiService(Get.find<StorageService>()));

    // Repositories
    Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl(Get.find<AuthApiService>()));
    Get.lazyPut<CompteRepository>(() => CompteRepositoryImpl(Get.find<CompteApiService>()));

    // Use Cases
    Get.lazyPut(() => LoginUseCase(Get.find()));
    Get.lazyPut(() => GetDetailCompteUseCase(Get.find()));
    Get.lazyPut(() => PaiementUseCase(Get.find()));
    Get.lazyPut(() => TransferUseCase(Get.find()));

    // Controllers
    Get.lazyPut(() => AuthController(Get.find()));
    Get.lazyPut(() => HomeController(Get.find(), Get.find(), Get.find(), Get.find<StorageService>()));
  }
}
