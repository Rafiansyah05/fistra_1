import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart'; // 1. Tambahkan import ini
import 'package:fistra_1/snap/presentation/screens/SplashScreen.dart'; // Import splash screen

void main() async {
  // 2. Jadikan fungsi main menjadi async
  // 3. Pastikan Flutter binding diinisialisasi sebelum menggunakan plugin atau operasi async
  WidgetsFlutterBinding.ensureInitialized();

  // 4. Inisialisasi data lokal untuk package intl (misalnya untuk bahasa Indonesia 'id_ID')
  //    Ganti 'id_ID' jika Anda menggunakan locale lain secara primer.
  await initializeDateFormatting('id_ID', null);

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

// import 'package:fistra_1/1_registration/presentation/screens/nomor_HP.dart';
// import 'package:fistra_1/home/presentation/screens/home.dart';
// import 'package:fistra_1/login/forgot_pin_page.dart';
// import 'package:fistra_1/login/login.dart';
// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'FISTRA',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         fontFamily:
//             'Poppins', // Opsional: gunakan font yang lebih bagus seperti Poppins
//       ),
//       // Mendefinisikan rute/halaman aplikasi
//       initialRoute: '/login', // Halaman awal adalah login
//       routes: {
//         '/login': (context) => const LoginPage(),
//         '/register': (context) => const NomorHpScreen(),
//         '/forgot-pin': (context) => const ForgotPinPage(),
//         '/home': (context) => const HomeScreen(),
//       },
//     );
//   }
// }
