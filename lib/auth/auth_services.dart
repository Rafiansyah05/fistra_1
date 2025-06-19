import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  // Membuat instance dari Firebase Auth untuk digunakan di seluruh class
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  String? _verificationId;

  Future<void> sendOtp({
    required String phone,
    required BuildContext context, // Dibutuhkan untuk menangani callback
    required Function
    onCodeSent, // Callback untuk memberitahu UI bahwa kode terkirim
  }) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phone, // Nomor HP dengan kode negara, contoh: +6281234567890
      // Callback saat verifikasi selesai secara otomatis (umumnya di Android)
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Langsung login jika verifikasi otomatis berhasil
        await _auth.signInWithCredential(credential);
      },

      // Callback saat verifikasi gagal
      verificationFailed: (FirebaseAuthException e) {
        // Tampilkan pesan error ke pengguna
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? 'Terjadi kesalahan')),
        );
      },

      // Callback saat kode sudah berhasil dikirim ke HP
      codeSent: (String verificationId, int? resendToken) {
        // Simpan verificationId untuk digunakan di langkah selanjutnya
        _verificationId = verificationId;
        // Panggil callback untuk memberitahu UI agar pindah ke layar input OTP
        onCodeSent();
      },

      // Callback saat waktu tunggu habis
      codeAutoRetrievalTimeout: (String verificationId) {
        // Anda bisa meng-handle ini jika diperlukan
      },
    );
  }

  // FUNGSI 2: Memverifikasi OTP yang dimasukkan pengguna
  Future<void> verifyOtp({required String otp}) async {
    try {
      // Buat kredensial menggunakan verificationId yang disimpan dan kode OTP dari pengguna
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: otp,
      );

      // Gunakan kredensial tersebut untuk login
      await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  // Fungsi untuk logout
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
