// lib/widgets/detailed_mitra_dialog.dart
import 'package:fistra_1/home/presentation/screens/mitra/mitra_model.dart';
import 'package:flutter/material.dart';
// Pastikan path import model Mitra sudah benar relatif terhadap file ini
// Jika model Mitra ada di lib/mitra_model.dart dan file ini di lib/widgets/detailed_mitra_dialog.dart,
// maka pathnya bisa ../mitra_model.dart
// Ganti 'package:fistra_1/home/presentation/screens/mitra/mitra_model.dart'
// dengan path yang benar jika berbeda.
// Contoh: jika struktur Anda:

class DetailedMitraDialog extends StatelessWidget {
  final Mitra mitra;
  final String headerImageAssetPath;

  // HAPUS BuildContext context dari sini
  const DetailedMitraDialog({
    super.key,
    required this.mitra,
    required this.headerImageAssetPath,
  });

  @override
  Widget build(BuildContext context) {
    // context didapatkan dari sini
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context), // Teruskan context dari build method
    );
  }

  Widget contentBox(BuildContext context) {
    // context ini adalah dari build method di atas
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: Offset(0.0, 10.0),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 150,
                width: double.infinity,
                child: Image.asset(
                  headerImageAssetPath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 150,
                      color: Colors.grey.shade300,
                      child: const Icon(
                        Icons.broken_image,
                        size: 50,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              ),
              Transform.translate(
                offset: const Offset(0, -40),
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6.0,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Image.asset(
                      mitra.logoAssetPath,
                      width: 120,
                      height: 50,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return const SizedBox(
                          width: 120,
                          height: 50,
                          child: Icon(Icons.store, size: 40),
                        );
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: 20,
                  top: 0,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      mitra.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    Text(
                      mitra.description ?? 'Deskripsi tidak tersedia.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey.shade700,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade400,
                    padding: const EdgeInsets.symmetric(vertical: 14.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    elevation: 2,
                  ),
                  onPressed: () {
                    Navigator.of(
                      context,
                    ).pop(); // Gunakan context dari build method
                  },
                  child: const Text(
                    'Mengerti',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Fungsi helper untuk menampilkan dialog (tidak ada perubahan di sini)
Future<void> showDetailedMitraInfoDialog(
  BuildContext context, { // Context ini dari layar pemanggil
  required Mitra mitra,
  required String headerImageAssetPath,
}) {
  return showDialog<void>(
    context: context, // Teruskan context dari layar pemanggil
    barrierDismissible: true,
    builder: (BuildContext dialogContext) {
      // dialogContext adalah context baru untuk builder dialog
      return DetailedMitraDialog(
        // Panggil konstruktor yang sudah diperbaiki
        mitra: mitra,
        headerImageAssetPath: headerImageAssetPath,
      );
    },
  );
}
