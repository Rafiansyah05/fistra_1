// lib/widgets/fingerprint_confirmation_dialog.dart
import 'package:flutter/material.dart';

Future<void> showFingerprintConfirmationDialog({
  required BuildContext context,
  required VoidCallback
  onMengerti, // Fungsi yang akan dipanggil saat "Mengerti" ditekan
}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // Pengguna harus menekan tombol
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        backgroundColor: Colors.white,
        contentPadding: const EdgeInsets.all(24.0),
        content: SingleChildScrollView(
          // Untuk menghindari overflow jika teks panjang
          child: Column(
            mainAxisSize:
                MainAxisSize.min, // Agar Column tidak mengambil tinggi maksimal
            children: <Widget>[
              // Ikon Informasi
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: const BoxDecoration(
                  color: Color(0xFFFFEB3B), // Warna kuning seperti di gambar
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.info_outline,
                  color: Colors.white,
                  size: 48.0,
                ),
              ),
              const SizedBox(height: 24.0),
              // Teks
              const Text(
                'Anda akan diminta untuk memindai sidik jari, Pastikan ini benar-benar sidik jari anda karena sidik jari ini akan anda gunakan selama proses transaksi',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black87,
                  height: 1.4, // Jarak antar baris
                ),
              ),
            ],
          ),
        ),
        actionsAlignment: MainAxisAlignment.center, // Pusatkan tombol
        actionsPadding: const EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          bottom: 20.0,
          top: 0,
        ),
        actions: <Widget>[
          SizedBox(
            width: double.infinity, // Agar tombol mengambil lebar penuh
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(
                  0xFF42A5F5,
                ), // Warna biru seperti di gambar
                padding: const EdgeInsets.symmetric(vertical: 14.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                elevation: 2,
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Tutup dialog
                onMengerti(); // Panggil callback setelah dialog ditutup
              },
              child: const Text(
                'Mengerti',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}
