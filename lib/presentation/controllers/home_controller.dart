import 'dart:async';
import 'package:get/get.dart';
import '../../domain/usecases/get_detail_compte_usecase.dart';
import '../../domain/usecases/paiement_usecase.dart';
import '../../domain/usecases/transfer_usecase.dart';
import '../../domain/usecases/schedule_transfer_usecase.dart';
import '../../domain/entities/DetailCompte.dart';
import '../../data/services/storage_service.dart';
import '../../core/exceptions/transaction_exceptions.dart';
import '../../routes/app_routes.dart';
import '../pages/login_page.dart';
import '../controllers/auth_controller.dart';

class HomeController extends GetxController {
  final GetDetailCompteUseCase getDetailCompteUseCase;
  final PaiementUseCase paiementUseCase;
  final TransferUseCase transferUseCase;
  final ScheduleTransferUseCase scheduleTransferUseCase;
  final StorageService storageService;

  HomeController(this.getDetailCompteUseCase, this.paiementUseCase, this.transferUseCase, this.scheduleTransferUseCase, this.storageService);

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

  Future<void> handleTransaction(String merchant, double amount, int transferType, DateTime? scheduledDate) async {
    try {
      if (transferType == 2) {
        // Scheduled transfer
        final date = scheduledDate!;
        final dateProgrammee = '${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}T${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}:${date.second.toString().padLeft(2, '0')}';
        await scheduleTransferUseCase.execute(merchant, amount, dateProgrammee);
        Get.snackbar('Succès', 'Transfert programmé avec succès');
      } else if (transferType == 0) {
        // Payment
        await paiementUseCase.execute(merchant, amount);
        Get.snackbar('Succès', 'Paiement effectué avec succès');
      } else {
        // Transfer
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
    _timer?.cancel();
    await storageService.clearTokens();

    // Ensure AuthController is available for the login page
    if (!Get.isRegistered<AuthController>()) {
      Get.put(AuthController(Get.find()));
    }

    Get.offAll(() => const LoginPage());
  }
}