import 'package:flutter/material.dart';
import '../../validators/Regex.dart';

class InputPhone extends StatelessWidget {
  final TextEditingController controller;

  const InputPhone({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: 'Numéro de téléphone',
        labelStyle: const TextStyle(color: Colors.white),
        prefixIcon: const Icon(Icons.phone, color: Colors.white),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white70),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color.fromARGB(255, 255, 110, 14)),
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
      ),
      style: const TextStyle(color: Colors.white),
      keyboardType: TextInputType.phone,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Veuillez entrer votre numéro de téléphone';
        }
        if (!Regex.senegalPhoneRegex.hasMatch(value)) {
          return 'Numéro de téléphone invalide (ex: 774730039)';
        }
        return null;
      },
    );
  }
}