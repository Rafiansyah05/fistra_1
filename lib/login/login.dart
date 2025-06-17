import 'package:fistra_1/1_registration/presentation/screens/nomor_HP.dart';
import 'package:fistra_1/home/presentation/screens/home.dart';
import 'package:fistra_1/login/forgot_pin_page.dart';
import 'package:flutter/material.dart';

// Definisikan warna-warna utama agar mudah diubah dan konsisten
const Color primaryColor = Color(0xFF3B97F7);
const Color textFieldBackgroundColor = Color(0xFFF2F2F7);

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _pinController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    _pinController.dispose();
    super.dispose();
  }

  void _login() {
    // Validasi form sebelum melanjutkan
    if (_formKey.currentState!.validate()) {
      // Jika semua input valid, lanjutkan ke halaman home
      print('Login berhasil dengan nomor: ${_phoneController.text}');

      // PERUBAHAN 2: Ganti pushReplacementNamed dengan pushReplacement
      // pushReplacement digunakan agar pengguna tidak bisa kembali ke halaman login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(),
                const Text(
                  'Login FISTRA',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 40),

                _buildTextFormField(
                  controller: _phoneController,
                  hintText: 'Masukkan Nomor HP Kamu',
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 20),

                _buildTextFormField(
                  controller: _pinController,
                  hintText: 'Masukkan PIN FISTRA Kamu',
                  isObscure: true,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 12),

                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      // PERUBAHAN 3: Ganti pushNamed dengan push
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ForgotPinPage(),
                        ),
                      );
                    },
                    child: const Text(
                      'Lupa PIN FISTRA',
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ), //

                const SizedBox(height: 40),

                // Tombol Login Utama
                ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // UI Diperbaiki
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                GestureDetector(
                  onTap: () {
                    // PERUBAHAN 4: Ganti pushNamed dengan push
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NomorHpScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'Registrasi',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String hintText,
    bool isObscure = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isObscure,
      keyboardType: keyboardType,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$hintText tidak boleh kosong';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey[400]),
        filled: true,
        fillColor: textFieldBackgroundColor,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 20,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.red, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
        ),
      ),
    );
  }
}
