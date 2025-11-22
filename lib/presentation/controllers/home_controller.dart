import 'dart:async';
import 'package:get/get.dart';
import '../../domain/usecases/get_detail_compte_usecase.dart';
import '../../domain/usecases/paiement_usecase.dart';
import '../../domain/usecases/transfer_usecase.dart';
import '../../domain/entities/DetailCompte.dart';
import '../../data/services/storage_service.dart';
import '../../core/exceptions/transaction_exceptions.dart';

class HomeController extends GetxController {
  final GetDetailCompteUseCase getDetailCompteUseCase;
  final PaiementUseCase paiementUseCase;
  final TransferUseCase transferUseCase;
  final StorageService storageService;

  HomeController(this.getDetailCompteUseCase, this.paiementUseCase, this.transferUseCase, this.storageService);

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
    try {
      if (isPayer) {
        await paiementUseCase.execute(merchant, amount);
        Get.snackbar('Succès', 'Paiement effectué avec succès');
      } else {
        await transferUseCase.execute(merchant, amount);
        Get.snackbar('Succès', 'Transfert effectué avec succès');
      }
      
      await fetchDetailCompte();
    } catch (e) {
      final transactionException = TransactionErrorParser.parseError(e);
      Get.snackbar('Erreur', transactionException.message);

      if (transactionException.type == TransactionErrorType.unauthorized) {
        Future.delayed(const Duration(seconds: 2), () {
          logout();
        });
      }

      rethrow;
    }
  }

  Future<void> logout() async {
    await storageService.clearTokens();
    Get.offAllNamed('/login');
  }
}