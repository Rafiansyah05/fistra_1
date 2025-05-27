// lib/mitra_screen.dart
import 'package:fistra_1/home/presentation/screens/mitra/mitra_item_dialog.dart';
import 'package:flutter/material.dart';
import 'mitra_model.dart';
// 1. Import dialog yang benar (dengan gambar header)
// Pastikan path ini benar

class MitraScreen extends StatefulWidget {
  const MitraScreen({super.key});

  @override
  State<MitraScreen> createState() => _MitraScreenState();
}

class _MitraScreenState extends State<MitraScreen> {
  final List<Mitra> _mitraList = [
    Mitra(
      id: 'M001',
      name: 'Indomaret',
      // 2. Pastikan path logo benar dan ada di folder assets/images/ (sesuai pubspec.yaml)
      logoAssetPath: 'assets/indomaret.png',
      description:
          'Indomaret adalah jaringan minimarket waralaba terbesar di Indonesia yang menyediakan berbagai kebutuhan sehari-hari seperti makanan, minuman, produk kebersihan, perlengkapan rumah tangga, dan lainnya. Dikelola oleh PT Indomarco Prismatama, Indomaret hadir dengan konsep toko modern yang mudah dijangkau masyarakat, baik di perkotaan maupun pedesaan. Minimarket ini bertujuan memberikan kemudahan dan kenyamanan dalam berbelanja dengan harga terjangkau dan lokasi yang strategis. Selain itu, Indomaret juga menyediakan layanan tambahan seperti pembayaran tagihan, pembelian pulsa, dan layanan keuangan lainnya.',
    ),
    Mitra(
      id: 'M002',
      name: 'Alfamart',
      logoAssetPath: 'assets/alfamart.png', // Ganti dengan logo Alfamart Anda
      description:
          'Alfamart adalah jaringan toko swalayan yang memiliki banyak cabang di Indonesia, menawarkan berbagai produk kebutuhan sehari-hari dengan harga kompetitif.',
    ),
    // Tambahkan mitra lain jika ada
  ];

  // 3. Hapus getter yang salah ini. Kita akan definisikan path gambar header di dalam onTap.
  // get headerImageForMitra => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Mitra',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        itemCount: _mitraList.length,
        itemBuilder: (context, index) {
          final mitra = _mitraList[index];
          return _buildMitraItem(context, mitra);
        },
        separatorBuilder:
            (context, index) => const Divider(
              height: 1,
              thickness: 1,
              indent: 16,
              endIndent: 16,
            ),
      ),
    );
  }

  Widget _buildMitraItem(BuildContext context, Mitra mitra) {
    return InkWell(
      onTap: () {
        // 4. Tentukan path gambar header di sini.
        // Ini bisa statis atau dinamis berdasarkan mitra.
        // Untuk contoh ini, kita gunakan gambar yang sama untuk semua,
        // tapi idealnya Anda punya gambar header spesifik per mitra.
        String currentHeaderImage;
        if (mitra.name == 'Indomaret') {
          currentHeaderImage =
              'assets/indoHeader.png'; // Pastikan gambar ini ada
        } else if (mitra.name == 'Alfamart') {
          currentHeaderImage =
              'assets/alfaHeaderjpg.png'; // Buat gambar header untuk Alfamart
        } else {
          currentHeaderImage =
              'assets/images/default_store_header.png'; // Gambar default jika ada
        }

        // Panggil fungsi helper untuk menampilkan dialog
        showDetailedMitraInfoDialog(
          context, // context dari _buildMitraItem (yang berasal dari _MitraScreenState)
          mitra: mitra,
          headerImageAssetPath: currentHeaderImage,
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          children: [
            Image.asset(
              mitra.logoAssetPath,
              width: 60,
              height: 25,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 60,
                  height: 25,
                  color: Colors.grey.shade200,
                  child: const Icon(Icons.broken_image, color: Colors.grey),
                );
              },
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Text(
                mitra.name,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),
            Icon(
              Icons.store_mall_directory_outlined,
              color: Colors.blue.shade600,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }
}
