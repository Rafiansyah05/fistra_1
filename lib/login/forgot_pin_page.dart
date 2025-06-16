import 'package:flutter/material.dart';

class ForgotPinPage extends StatelessWidget {
  const ForgotPinPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lupa PIN'),
        backgroundColor: const Color(0xFF3B97F7),
      ),
      body: const Center(
        child: Text('Halaman Lupa PIN', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
