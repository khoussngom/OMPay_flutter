import 'package:flutter/material.dart';
import '../../ApiServices/AuthServices.dart';
import '../../entities/AuthDto.dart';
import '../../acceuil/pages/home_page.dart';
import '../components/login_background.dart';
import '../components/login_title.dart';
import '../components/login_button.dart';
import '../widgets/input_phone.dart';
import '../widgets/input_password.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _telephoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authServices = AuthServices();
  bool _isLoading = false;

  @override
  void dispose() {
    _telephoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final authDto = AuthDto(
        telephone: _telephoneController.text.trim(),
        password: _passwordController.text.trim(),
      );

      await _authServices.login(authDto);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Connexion réussie !')),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur de connexion: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const LoginBackground(),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // const LoginTitle(),
                    const SizedBox(height: 400),
                    const SizedBox(height: 48),
                    InputPhone(controller: _telephoneController),
                    const SizedBox(height: 16),
                    InputPassword(controller: _passwordController),
                    const SizedBox(height: 32),
                    LoginButton(
                      onPressed: _isLoading ? null : _login,
                      isLoading: _isLoading,
                    ),
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