import 'package:flutter/material.dart';

// Model untuk data notifikasi
class NotificationItemData {
  final String title;
  final String message;
  final String date;
  final String iconImagePath; // Path ke gambar ikon
  final Color? iconBackgroundColor; // Bisa null jika gambar sudah ada BG
  final VoidCallback? onTap;

  NotificationItemData({
    required this.title,
    required this.message,
    required this.date,
    required this.iconImagePath,
    this.iconBackgroundColor, // Jadikan opsional atau beri default
    this.onTap,
  });
}

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});

  // Data notifikasi
  final List<NotificationItemData> _notifications = [
    NotificationItemData(
      title: 'Biometrik berhasil diaktifkan',
      message:
          'Akses biometrik sudah siap, gunakan FISTRA untuk transaksi yang lebih cepat dengan sidik jari',
      date: '13 april 2026',
      iconImagePath:
          'assets/icon_petik_aktif.png', // GANTI DENGAN PATH GAMBAR ANDA
      iconBackgroundColor:
          Colors.blue, // Warna latar jika gambar ikonnya transparan
      onTap: () {
        print('Notifikasi Biometrik diklik!');
      },
    ),
    NotificationItemData(
      title: 'Aktivasi FISTRA berhasil',
      message:
          'Sekarang kamu sudah bisa bertransaksi dengan mitra dengan sidik jari',
      date: '2 feb 2026',
      iconImagePath: 'assets/icon_read.png', // GANTI DENGAN PATH GAMBAR ANDA
      iconBackgroundColor:
          Colors.grey[200], // Warna latar jika gambar ikonnya transparan
      onTap: () {
        print('Notifikasi Aktivasi FISTRA diklik!');
      },
    ),
  ];

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
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Notifikasi',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16.0),
        itemCount: _notifications.length,
        itemBuilder: (context, index) {
          final item = _notifications[index];
          return _buildNotificationItem(context, item);
        },
        separatorBuilder: (context, index) => const SizedBox(height: 16.0),
      ),
    );
  }

  Widget _buildNotificationItem(
    BuildContext context,
    NotificationItemData item,
  ) {
    const double iconContainerRadius = 22; // Radius untuk CircleAvatar
    const double imagePadding =
        6; // Padding di dalam CircleAvatar agar gambar tidak terlalu mepet

    return InkWell(
      onTap: () {
        item.onTap?.call();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Membuka: ${item.title}'),
            duration: const Duration(seconds: 1),
          ),
        );
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Ikon menggunakan gambar
          CircleAvatar(
            radius: iconContainerRadius,
            backgroundColor:
                item.iconBackgroundColor ??
                Colors.transparent, // Latar belakang avatar
            child: Padding(
              padding: const EdgeInsets.all(
                imagePadding,
              ), // Padding untuk gambar di dalam avatar
              child: Image.asset(
                item.iconImagePath,
                // `fit` bisa disesuaikan, BoxFit.contain atau BoxFit.cover
                // Jika gambar sudah pas ukurannya, mungkin tidak perlu `fit`
                // Atau, jika gambar ikonnya sendiri sudah bundar dan berukuran pas,
                // Anda bisa menggunakan `backgroundImage` pada CircleAvatar:
                // backgroundImage: AssetImage(item.iconImagePath),
                // dan hilangkan child Image.asset ini.
                // Untuk fleksibilitas, menggunakan child Image.asset lebih baik.
                width: (iconContainerRadius - imagePadding) * 2,
                height: (iconContainerRadius - imagePadding) * 2,
                fit: BoxFit.contain, // Pastikan seluruh gambar terlihat
              ),
            ),
          ),
          const SizedBox(width: 16.0),
          // Konten teks
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  item.message,
                  style: TextStyle(fontSize: 14.0, color: Colors.grey[700]),
                ),
                const SizedBox(height: 8.0),
                Text(
                  item.date,
                  style: TextStyle(fontSize: 12.0, color: Colors.grey[500]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
