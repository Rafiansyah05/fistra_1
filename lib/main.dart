import 'package:flutter/material.dart';
import 'package:fistra_1/snap/presentation/screens/SplashScreen.dart'; // Import splash screen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fistra App',
      theme: ThemeData(
        primarySwatch:
            Colors.blue, // Anda bisa membuat MaterialColor kustom dari logoBlue
        scaffoldBackgroundColor: Colors.white, // Latar belakang default
        fontFamily: 'Poppins', // Contoh jika Anda ingin menggunakan font kustom
      ),
      home: const SplashScreen(), // Mulai dengan splash screen
      debugShowCheckedModeBanner: false,
    );
  }
}
