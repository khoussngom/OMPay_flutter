import 'dart:async';
import 'package:get/get.dart';
import '../../domain/usecases/get_detail_compte_usecase.dart';
import '../../domain/entities/DetailCompte.dart';
import '../../data/services/storage_service.dart';

class HomeController extends GetxController {
  final GetDetailCompteUseCase getDetailCompteUseCase;
  final StorageService storageService;

  HomeController(this.getDetailCompteUseCase, this.storageService);

  var detailCompte = Rxn<DetailCompte>();
  var isLoading = true.obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    fetchDetailCompte().then((_) {
      _timer = Timer.periodic(const Duration(seconds: 1), (_) => fetchDetailCompte());
    });
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  Future<void> fetchDetailCompte() async {
    try {
      final detail = await getDetailCompteUseCase.execute();
      detailCompte.value = detail;
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Erreur', 'Erreur lors du chargement: $e');
    }
  }

  Future<void> handleTransfer(String merchant, double amount, bool isPayer) async {
    // TODO: Implement transfer logic with use cases
  }

  Future<void> logout() async {
    await storageService.clearTokens();
    Get.offAllNamed('/login');
  }
}