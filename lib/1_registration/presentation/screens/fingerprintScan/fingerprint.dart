// lib/fingerprint_scan_page.dart
import 'package:fistra_1/1_registration/presentation/screens/tanggal_lahir.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore: depend_on_referenced_packages
import 'package:local_auth/local_auth.dart';
import 'package:fistra_1/1_registration/presentation/screens/fingerprintScan/successFinger.dart'; // Halaman tujuan setelah sukses
// import 'previous_page.dart'; // Impor halaman sebelumnya jika ada (misal: dob_input_page.dart)

class FingerprintScanPage extends StatefulWidget {
  const FingerprintScanPage({super.key});

  @override
  State<FingerprintScanPage> createState() => _FingerprintScanPageState();
}

class _FingerprintScanPageState extends State<FingerprintScanPage> {
  final LocalAuthentication _localAuth = LocalAuthentication();
  bool _isFingerprintScanned = false;
  bool _isAuthenticating = false; // Untuk mencegah multiple auth calls

  @override
  void initState() {
    super.initState();
    // Anda bisa langsung memicu autentikasi saat halaman dimuat jika diinginkan
    // _authenticate();
  }

  Future<void> _authenticate() async {
    if (_isAuthenticating) return; // Jangan jalankan jika sudah proses

    setState(() {
      _isAuthenticating = true;
    });

    bool authenticated = false;
    try {
      // Cek apakah perangkat mendukung biometrik
      bool canCheckBiometrics = await _localAuth.canCheckBiometrics;
      // Cek apakah ada biometrik yang terdaftar
      List<BiometricType> availableBiometrics =
          await _localAuth.getAvailableBiometrics();

      if (canCheckBiometrics &&
          availableBiometrics.contains(BiometricType.fingerprint)) {
        authenticated = await _localAuth.authenticate(
          localizedReason: 'Pindai sidik jari Anda untuk melanjutkan',
          options: const AuthenticationOptions(
            stickyAuth:
                true, // Tetap tampilkan dialog autentikasi meski app ke background
            biometricOnly: true, // Hanya izinkan biometrik (bukan PIN/Pola)
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Perangkat tidak mendukung sidik jari atau belum ada sidik jari terdaftar.',
            ),
            backgroundColor: Colors.orange,
          ),
        );
      }
    } on PlatformException catch (e) {
      print(e); // Log error
      String message = 'Terjadi kesalahan saat autentikasi.';
      if (e.code == 'NotAvailable') {
        message = 'Biometrik tidak tersedia di perangkat ini.';
      } else if (e.code == 'NotEnrolled') {
        message = 'Tidak ada sidik jari yang terdaftar.';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), backgroundColor: Colors.redAccent),
      );
    } finally {
      setState(() {
        _isAuthenticating = false;
      });
    }

    if (authenticated) {
      setState(() {
        _isFingerprintScanned = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Sidik jari berhasil dipindai!'),
          backgroundColor: Colors.green,
        ),
      );
    } else if (!_isAuthenticating && !_isFingerprintScanned) {
      // Hanya tampilkan jika bukan karena error/cancel dari plugin
      // Jika autentikasi gagal dan bukan karena error yang sudah ditangani di atas
      // (misalnya pengguna membatalkan)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pemindaian sidik jari gagal atau dibatalkan.'),
          backgroundColor: Colors.orange,
        ),
      );
    }
  }

  void _navigateToNextPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder:
            (context) =>
                const SuccessPage(message: "Pendaftaran Sidik Jari Berhasil"),
      ),
    );
  }

  void _navigateToPreviousPage() {
    // Pastikan Anda memiliki cara untuk kembali.
    // Jika halaman ini di-push, Navigator.pop(context) cukup.
    // Jika di-pushReplacement, Anda mungkin perlu navigasi ke halaman tertentu.
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      // Contoh: kembali ke halaman input tanggal lahir jika itu adalah halaman sebelumnya
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DobInputPage()),
      );
      // print(
      //   "Tidak bisa kembali, halaman ini adalah root atau di-pushReplacement.",
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 30), // Spasi untuk "21.20" dan status bar
              const Text(
                'Pendaftaran Sidik Jari',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'Silakan tempelkan sidik jari Anda secara penuh pada pemindai. Pastikan seluruh bagian sidik jari terbaca dengan baik.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 60),
              GestureDetector(
                onTap: _authenticate, // Panggil autentikasi saat ikon disentuh
                child: Icon(
                  Icons.fingerprint,
                  size: 150,
                  color:
                      _isFingerprintScanned
                          ? Colors.green
                          : const Color(0xFF42A5F5), // Warna biru atau hijau
                ),
              ),
              const Spacer(), // Mendorong tombol ke bawah
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        foregroundColor: Colors.blue, // Warna teks
                        backgroundColor:
                            Colors.grey[100], // Background agak abu-abu
                        side: BorderSide(
                          color: Colors.grey[300]!,
                        ), // Border tipis
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      onPressed: _navigateToPreviousPage,
                      child: const Text(
                        'Batal',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF42A5F5), // Warna biru
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        elevation: 2,
                      ),
                      onPressed:
                          _isFingerprintScanned
                              ? _navigateToNextPage
                              : null, // Aktifkan jika sudah scan
                      child: const Text(
                        'Lanjut',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
