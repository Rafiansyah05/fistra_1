// lib/success_page.dart
import 'package:flutter/material.dart';

class SuccessPage extends StatelessWidget {
  final String message;
  const SuccessPage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Berhasil'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        automaticallyImplyLeading:
            false, // Hapus tombol back default jika ini halaman akhir alur
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle_outline,
              color: Colors.green,
              size: 100,
            ),
            const SizedBox(height: 20),
            Text(
              message,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Aksi selanjutnya, misal kembali ke halaman utama aplikasi
                // Navigator.of(context).popUntil((route) => route.isFirst);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Navigasi ke halaman utama (belum diimplementasi)",
                    ),
                  ),
                );
              },
              child: const Text("Selesai"),
            ),
          ],
        ),
      ),
    );
  }
}
