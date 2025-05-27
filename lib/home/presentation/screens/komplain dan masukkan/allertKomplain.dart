// lib/widgets/info_dialog.dart (Nama file bisa disesuaikan)
import 'package:flutter/material.dart';

// Nama fungsi bisa tetap atau diubah.
Future<void> showAppInfoDialog({
  required BuildContext context,
  required VoidCallback
  onMengerti, // Fungsi yang akan dipanggil saat "Mengerti" ditekan
}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // Agar bisa ditutup dengan tap di luar dialog
    builder: (BuildContext dialogContext) {
      // Context khusus untuk dialog ini
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0), // Rounded corners
        ),
        backgroundColor: Colors.white,
        contentPadding: const EdgeInsets.fromLTRB(
          24.0,
          24.0,
          24.0,
          0,
        ), // Padding konten
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center, // Pusatkan ikon
            children: <Widget>[
              // Ikon Informasi
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: const BoxDecoration(
                  color: Color(0xFFFFEB3B), // Warna kuning
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.info_outline_rounded, // Ikon info
                  color: Colors.white,
                  size: 40.0,
                ),
              ),
              const SizedBox(height: 24.0),

              // Daftar Informasi
              _buildInfoItem(
                dialogContext, // Gunakan dialogContext untuk DefaultTextStyle
                index: '1.',
                textSpans: [
                  const TextSpan(
                    text:
                        'Demi kenyamanan bersama kami berharap pengguna setia FISTRA tetap menggunakan bahasa yang sopan dan tidak mengandung SARA.',
                  ),
                ],
              ),
              const SizedBox(height: 12.0),
              _buildInfoItem(
                dialogContext,
                index: '2.',
                textSpans: [
                  const TextSpan(
                    text:
                        'Admin hanya akan menjawab pada saat jam kerja mulai dari hari senin-sabtu pada pukul 08:00 WIB - 16:30 WIB, lebih dari itu Kami akan menjawabnya di hari berikutnya.',
                  ),
                ],
              ),
              const SizedBox(height: 12.0),
              _buildInfoItem(
                dialogContext,
                index: '3.',
                textSpans: [
                  const TextSpan(
                    text:
                        'Jika pesan anda tidak dibalas dalam waktu lebih dari 4 hari, silahkan hubungi melalui panggilan suara kepada nomor ini ',
                  ),
                  const TextSpan(
                    // Nomor telepon sekarang hanya teks tebal
                    text: '+6281243202344',
                    style: TextStyle(
                      // color: Colors.blue, // Warna bisa dihilangkan atau disesuaikan
                      fontWeight: FontWeight.bold, // Hanya tebal
                      // decoration: TextDecoration.underline, // Underline dihilangkan
                    ),
                  ),
                  const TextSpan(text: ' (ADMIN PUSAT)'),
                ],
              ),
              const SizedBox(height: 24.0), // Spasi sebelum tombol
            ],
          ),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actionsPadding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 20.0),
        actions: <Widget>[
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF42A5F5), // Warna biru
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
                'Mengerti',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
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

// Helper widget _buildInfoItem
Widget _buildInfoItem(
  BuildContext context, {
  required String index,
  required List<TextSpan> textSpans,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        index,
        style: const TextStyle(
          fontSize: 14.0,
          color: Colors.black87,
          fontWeight: FontWeight.w500,
        ),
      ),
      const SizedBox(width: 8.0),
      Expanded(
        child: RichText(
          textAlign: TextAlign.start,
          text: TextSpan(
            style: DefaultTextStyle.of(context).style.copyWith(
              fontSize: 14.0,
              color: Colors.black.withOpacity(0.75),
              height: 1.4,
            ),
            children: textSpans,
          ),
        ),
      ),
    ],
  );
}
