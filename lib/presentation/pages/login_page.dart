import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../widgets/input_phone_field.dart';
import '../widgets/input_password_field.dart';
import '../widgets/login_button.dart';
import '../widgets/login_background.dart';
import '../widgets/login_title.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find();

    return Scaffold(
      body: Stack(
        children: [
          const LoginBackground(),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: GlobalKey<FormState>(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 400),
                    const SizedBox(height: 48),
                    InputPhoneField(
                      controller: authController.telephoneController,
                    ),
                    const SizedBox(height: 16),
                    InputPasswordField(
                      controller: authController.passwordController,
                    ),
                    const SizedBox(height: 32),
                    Obx(() => LoginButton(
                      onPressed: authController.isLoading.value ? null : authController.login,
                      isLoading: authController.isLoading.value,
                    )),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}