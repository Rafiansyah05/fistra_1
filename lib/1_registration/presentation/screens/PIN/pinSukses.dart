import 'package:flutter/material.dart';

Future<void> ShowConfirmationSuccessPin({
  // Pastikan nama fungsi dan parameter sama
  required BuildContext context,
  required VoidCallback onMengerti,
  // String? message, // Jika Anda ingin pesan dinamis di dialog
}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        backgroundColor: Colors.white,
        contentPadding: const EdgeInsets.all(24.0),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(11, 218, 0, 1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle_outline,
                  color: Colors.white,
                  size: 48.0,
                ),
              ),
              const SizedBox(height: 24.0),
              const Text(
                // message ?? 'Registrasi Akun FISTR Berhasil', // Gunakan pesan dinamis jika ada
                'Registrasi Akun FISTRA Berhasil',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black87,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actionsPadding: const EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          bottom: 20.0,
          top: 0,
        ),
        actions: <Widget>[
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF42A5F5),
                padding: const EdgeInsets.symmetric(vertical: 14.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                elevation: 2,
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Tutup dialog
                onMengerti(); // Panggil callback
              },
              child: const Text(
                'Yey, Lanjut',
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
