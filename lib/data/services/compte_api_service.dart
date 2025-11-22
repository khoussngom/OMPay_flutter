import '../../domain/entities/DetailCompte.dart';
import '../../constants/apiUrl.dart';
import '../../ApiServices/BaseService.dart';
import 'storage_service.dart';

class CompteApiService extends BaseService {
  final StorageService storageService;

  CompteApiService(this.storageService);

  Future<DetailCompte> getDetailCompte() async {
    final token = storageService.getToken();
    final data = await get(ApiUrls['getDetailCompte']!, headers: {'Authorization': 'Bearer $token'});
    return DetailCompte.fromJson(data['data']);
  }

  Future<void> paiement(String merchant, double amount) async {
    final token = storageService.getToken();
    final url = '${ApiUrls['paiement']}?marchand=$merchant&montant=$amount';
    await post(url, headers: {'Authorization': 'Bearer $token'});
  }

  Future<void> transfer(String merchant, double amount) async {
    final token = storageService.getToken();
    final url = '${ApiUrls['transfert']}?dest=$merchant&montant=$amount';
    await post(url, headers: {'Authorization': 'Bearer $token'});
  }
}