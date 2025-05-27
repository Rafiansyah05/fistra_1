// lib/screens/profile_screen.dart
import 'package:flutter/material.dart';
import 'package:fistra_1/home/presentation/screens/profil/placeholder.dart'; // Impor placeholder screen
// Impor halaman awal Anda (ganti dengan path yang benar)
// import 'package:nama_proyek_anda/screens/home_screen.dart'; // Contoh

// Placeholder untuk halaman awal jika Anda belum memilikinya
// Anda harus mengganti ini dengan navigasi ke halaman awal aplikasi Anda yang sebenarnya
class InitialScreenPlaceholder extends StatelessWidget {
  const InitialScreenPlaceholder({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Halaman Awal")),
      body: const Center(
        child: Text("Anda telah keluar dan kembali ke halaman awal."),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _navigateTo(BuildContext context, String screenName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlaceholderScreen(title: screenName),
      ),
    );
  }

  void _logout(BuildContext context) {
    // Navigasi ke halaman awal dan hapus semua rute sebelumnya
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const InitialScreenPlaceholder(),
      ), // GANTI DENGAN HALAMAN AWAL ANDA
      (Route<dynamic> route) => false, // Predikat untuk menghapus semua rute
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Colors.blue.shade500; // Warna biru dari gambar
    final Color iconColor = Colors.blue.shade600;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Profil',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined, color: Colors.white),
            onPressed: () {
              _navigateTo(context, 'Edit Profil');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Profil
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24.0),
              color: primaryColor,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4), // Sedikit border putih
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.9),
                    ),
                    child: CircleAvatar(
                      radius: 45,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.person_outline,
                        size: 60,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Ahmad Rafiansyah',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Bergabung sejak: 23 Jan 2026',
                    style: TextStyle(fontSize: 14, color: Colors.white70),
                  ),
                ],
              ),
            ),

            // Daftar Menu
            _buildProfileMenuItem(
              context,
              icon: Icons.shield_outlined,
              iconColor: iconColor,
              title: 'Keamanan akun',
              subtitle:
                  'Atur biometrik buat login, ubah password, dan ubah PIN FISTRA',
              onTap: () => _navigateTo(context, 'Keamanan Akun'),
            ),
            const Divider(height: 1, thickness: 0.5, indent: 20, endIndent: 20),
            _buildProfileMenuItem(
              context,
              icon: Icons.settings_outlined,
              iconColor: iconColor,
              title: 'Pengaturan',
              subtitle:
                  'Atur preferensi aplikasi seperti tema, bahasa, dan notifikasi di sini.',
              onTap: () => _navigateTo(context, 'Pengaturan'),
            ),
            const Divider(height: 1, thickness: 0.5, indent: 20, endIndent: 20),
            _buildProfileMenuItem(
              context,
              icon: Icons.help_outline,
              iconColor: iconColor,
              title: 'Bantuan & informasi',
              subtitle:
                  'Akses pusat bantuan, informasi umum, pembagian data probadi, dan syarat dan ketentuan.',
              onTap: () => _navigateTo(context, 'Bantuan & Informasi'),
            ),
            const Divider(height: 1, thickness: 0.5, indent: 20, endIndent: 20),
            _buildProfileMenuItem(
              context,
              icon: Icons.link_outlined, // Mirip dengan ikon di gambar
              iconColor: iconColor,
              title: 'Bantu Teman Daftar',
              subtitle:
                  'Teman Anda bisa mendaftar sidik jari menggunakan perangkat Anda. Data tetap milik mereka, Anda hanya membantu prosesnya.',
              onTap: () => _navigateTo(context, 'Bantu Teman Daftar'),
            ),
            const SizedBox(height: 30), // Jarak sebelum tombol keluar
            // Tombol Keluar
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: TextButton.icon(
                icon: const Icon(Icons.logout, color: Colors.red),
                label: const Text(
                  'Keluar',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () => _logout(context),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  // Bisa tambahkan shape jika ingin ada border atau background
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileMenuItem(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: iconColor, size: 28),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade700,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
            // Icon panah kanan (opsional, tidak ada di desain asli)
            // Icon(Icons.chevron_right, color: Colors.grey.shade400),
          ],
        ),
      ),
    );
  }
}
