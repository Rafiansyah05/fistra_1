import 'dart:async';
import 'package:fistra_1/snap/presentation/screens/awal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:fistra_1/1_registration/presentation/screens/nomor_HP.dart'; // Untuk SystemChrome
// Pastikan path import ini benar sesuai struktur proyek Anda

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Mengatur UI overlay agar transparan atau sesuai tema
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge); // Full screen
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // Atur warna status bar
        statusBarIconBrightness:
            Brightness.dark, // Ikon status bar (gelap/terang)
        systemNavigationBarColor: Colors.white, // Warna navigation bar bawah
        systemNavigationBarIconBrightness:
            Brightness.dark, // Ikon navigation bar bawah
      ),
    );

    Timer(const Duration(seconds: 3), () {
      // Durasi splash screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const WelcomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // --- GANTI DENGAN GAMBAR LOGO DAN TAGLINE ANDA ---
            // 1. Pastikan Anda sudah memiliki file gambar yang menggabungkan
            //    logo "FISTRA" dan teks "Fingerprint Scanner of Transaction".
            // 2. Letakkan file gambar tersebut di folder assets Anda,
            //    misalnya: 'assets/images/logo_fistra_lengkap.png'
            // 3. Deklarasikan folder assets atau file gambar tersebut di pubspec.yaml:
            //
            //    flutter:
            //      assets:
            //        - assets/images/
            //        # atau - assets/images/logo_fistra_lengkap.png
            //
            // 4. Ganti 'assets/images/placeholder_logo_fistra.png' di bawah
            //    dengan path yang benar ke gambar Anda.
            Image.asset(
              'assets/logo_fistra.png', // <-- GANTI PATH INI
              width: 250, // Sesuaikan ukuran lebar gambar jika perlu
              // height: 150, // Anda juga bisa mengatur tinggi jika perlu
              // fit: BoxFit.contain, // Sesuaikan bagaimana gambar di-fit
            ),
            // Anda bisa menghapus SizedBox jika jarak sudah diatur dalam gambar itu sendiri
            // const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
