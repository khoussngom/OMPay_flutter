import '../entities/User.dart';
import '../ApiServices/ApiServices.dart';

class UserServices {
  final ApiServices _apiServices = ApiServices();

  Future<List<dynamic>> getAllUsers() async {
    return await _apiServices.getAllUsers();
  }

  Future<void> createUser(User user) async {
    await _apiServices.createUser(user.toJson());
  }
}