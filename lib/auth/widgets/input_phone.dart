import 'package:flutter/material.dart';

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
          borderSide: const BorderSide(color: Colors.white),
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
        if (value.length != 9) {
          return 'Le numéro doit contenir 9 chiffres (ex: 774730039)';
        }
        if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
          return 'Le numéro doit contenir uniquement des chiffres';
        }
        return null;
      },
    );
  }
}