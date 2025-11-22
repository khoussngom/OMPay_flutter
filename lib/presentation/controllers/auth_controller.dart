import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/entities/AuthDto.dart';

class AuthController extends GetxController {
  final LoginUseCase loginUseCase;

  AuthController(this.loginUseCase);

  var isLoading = false.obs;


  final TextEditingController telephoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void onClose() {
    telephoneController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  Future<void> login() async {
    if (telephoneController.text.isEmpty || passwordController.text.isEmpty) return;

    isLoading.value = true;
    try {
      final authDto = AuthDto(
        telephone: telephoneController.text.trim(),
        password: passwordController.text.trim(),
      );
      await loginUseCase.execute(authDto);
      Get.offNamed('/home');
      Get.snackbar(
      'Succès', 
      'Connexion réussie !',
      backgroundColor: Colors.green,
      colorText: Colors.white,
      icon: Icon(Icons.check, color: Colors.white),
      snackPosition: SnackPosition.BOTTOM,
      borderRadius: 10,
      margin: EdgeInsets.all(10),
      duration: Duration(seconds: 3),
    );

    } catch (e) {
      Get.snackbar('Erreur', 'Erreur de connexion: $e');
    } finally {
      isLoading.value = false;
    }
  }
}