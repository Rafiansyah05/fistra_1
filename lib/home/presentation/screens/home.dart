import 'package:fistra_1/home/presentation/screens/profil/profil.dart';
import 'package:flutter/material.dart';
import 'package:fistra_1/home/presentation/screens/widget/feature_button.dart';
import 'package:fistra_1/home/presentation/screens/widget/news_banner_card.dart';
import 'package:fistra_1/home/presentation/screens/widget/transaction_card_widget.dart';
import 'package:fistra_1/home/presentation/screens/notifikasi/notifikasi.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color primaryBlue = Colors.blue.shade600; // Consistent blue

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(0), // Remove default ListView padding
          children: [
            // Custom Header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 15),
              child: Column(
                // Kolom utama untuk header
                crossAxisAlignment: CrossAxisAlignment.start, // Logo rata kiri
                children: [
                  // Baris 1: Logo
                  Image.asset(
                    'assets/logo_fistra.png',
                    height: 40, // Adjust as needed
                  ),
                  const SizedBox(
                    height: 15,
                  ), // Spasi antara logo dan baris berikutnya
                  // Baris 2: Teks Sapaan dan Ikon
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment
                            .spaceBetween, // Sapaan di kiri, ikon di kanan
                    crossAxisAlignment:
                        CrossAxisAlignment
                            .center, // Sejajarkan item secara vertikal
                    children: [
                      // Kolom untuk teks "Halo," dan "Ahmad Rafiansyah"
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          // Tambahkan const jika teks statis
                          Text(
                            'Halo,',
                            style: TextStyle(
                              fontSize: 20, // Ukuran asli dari desain Anda
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            'Ahmad Rafiansyah',
                            style: TextStyle(
                              fontSize: 20, // Ukuran asli dari desain Anda
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                      // Row untuk ikon Notifikasi dan Profil
                      Row(
                        children: [
                          _buildHeaderIcon(
                            context,
                            icon: Icons.notifications_outlined,
                            label: 'Notifikasi',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NotificationScreen(),
                                ), // Panggil NotificationScreen()
                              );
                            },
                            hasBadge: true,
                          ),
                          const SizedBox(width: 15),
                          _buildHeaderIcon(
                            context,
                            icon: Icons.person_outline,
                            label: 'Profil',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProfileScreen(),
                                ), // Panggil NotificationScreen()
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Kartu Transaksi FISTRA Section
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Kartu transaksi FISTRA',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TransactionCardWidget(
                    cardNumber: '082345673214',
                    initialBalance: 500000,
                    cardColor: primaryBlue,
                  ),
                ],
              ),
            ),

            // Fitur Pilihan FISTRA Section
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 20.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Fitur pilihan FISTRA',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FeatureButton(
                        icon: Icons.add_circle_outline,
                        label: 'Isi Saldo',
                        onTap: () => Navigator.pushNamed(context, '/isi_saldo'),
                        iconColor: primaryBlue,
                      ),
                      FeatureButton(
                        icon: Icons.edit_note_outlined,
                        label: 'Aktifitas',
                        onTap: () => Navigator.pushNamed(context, '/aktifitas'),
                        iconColor: primaryBlue,
                      ),
                      FeatureButton(
                        icon: Icons.support_agent_outlined,
                        label: 'Komplain & \nMasukkan',
                        onTap: () => Navigator.pushNamed(context, '/komplain'),
                        iconColor: primaryBlue,
                      ),
                      FeatureButton(
                        icon: Icons.store_mall_directory_outlined,
                        label: 'Mitra',
                        onTap: () => Navigator.pushNamed(context, '/mitra'),
                        iconColor: primaryBlue,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Berita FISTRA Section
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Berita FISTRA',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const NewsBannerCard(imagePath: 'assets/berita_fistra.png'),
                ],
              ),
            ),
            const SizedBox(height: 20), // Some spacing at the bottom
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderIcon(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool hasBadge = false,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Icon(icon, size: 28, color: Colors.black54),
              if (hasBadge)
                Positioned(
                  top: -2,
                  right: -2,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        width: 1.5,
                      ),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 8,
                      minHeight: 8,
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.black54),
        ),
      ],
    );
  }
}
