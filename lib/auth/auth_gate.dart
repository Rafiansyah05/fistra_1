import 'package:fistra_1/auth/auth_services.dart';
import 'package:fistra_1/home/presentation/screens/home.dart'; // <-- SESUAIKAN PATH INI
import 'package:fistra_1/login/login.dart'; // <-- SESUAIKAN PATH INI
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        // Mendengarkan stream dari AuthService
        stream: AuthService().authStateChanges,
        builder: (context, snapshot) {
          // 1. Jika masih menunggu koneksi, tampilkan loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // 2. Jika stream memiliki data (user tidak null), berarti sudah login
          if (snapshot.hasData) {
            return const HomeScreen(); // <-- SESUAIKAN NAMA WIDGET INI
          }
          // 3. Jika stream tidak memiliki data (user null), tampilkan halaman login
          else {
            return const LoginPage(); // <-- SESUAIKAN NAMA WIDGET INI
          }
        },
      ),
    );
  }
}
