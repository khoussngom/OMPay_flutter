import 'package:flutter/material.dart';
import 'auth/pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'OMPay',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange.shade800),
        useMaterial3: true,
      ),
      home: const LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
