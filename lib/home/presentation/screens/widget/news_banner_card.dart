// lib/widgets/news_banner_card.dart
import 'package:flutter/material.dart';

class NewsBannerCard extends StatelessWidget {
  final String imagePath; // Path ke aset gambar untuk banner

  const NewsBannerCard({
    super.key,
    required this.imagePath, // Wajibkan path gambar
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      margin:
          EdgeInsets
              .zero, // Sama seperti desain awal, margin diatur oleh parent
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      // clipBehavior penting agar gambar di dalamnya terpotong sesuai bentuk rounded card
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        height: 150, // Sesuaikan tinggi banner sesuai kebutuhan
        width:
            double
                .infinity, // Memastikan banner mengambil lebar penuh yang tersedia
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover, // Membuat gambar mengisi seluruh area SizedBox,
          // mungkin memotong gambar jika rasio aspek tidak cocok.
          // Opsi lain: BoxFit.contain, BoxFit.fill, BoxFit.fitWidth, dll.
        ),
      ),
    );
  }
}
