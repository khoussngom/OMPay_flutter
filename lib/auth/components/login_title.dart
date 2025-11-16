import 'package:flutter/material.dart';

class LoginTitle extends StatelessWidget {
  const LoginTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'OmPay',
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }
}