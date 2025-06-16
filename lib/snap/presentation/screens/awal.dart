import 'package:fistra_1/1_registration/presentation/screens/nomor_HP.dart';
import 'package:fistra_1/login/login.dart';
import 'package:flutter/material.dart';

// Definisikan warna utama agar konsisten
const Color primaryColor = Color(0xFF3B97F7);

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween, // Memberi jarak antar elemen
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(flex: 2),
              Column(
                children: [
                  const Text(
                    'Hallo, Selamat Datang di',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Image.asset(
                    'assets/logo_fistra.png', // Pastikan path ini benar
                    height: 80,
                  ),
                ],
              ),
              const Spacer(flex: 3),
              Column(
                children: [
                  // Tombol Login
                  ElevatedButton(
                    onPressed: () {
                      // PERUBAHAN 2: Menggunakan MaterialPageRoute untuk navigasi langsung
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      padding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 150,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          30,
                        ), // UI tetap diperbaiki
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Tombol Registrasi
                  GestureDetector(
                    onTap: () {
                      // PERUBAHAN 3: Menggunakan MaterialPageRoute untuk navigasi langsung
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NomorHpScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Registrasi',
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
