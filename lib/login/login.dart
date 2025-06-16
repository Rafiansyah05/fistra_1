import 'package:flutter/material.dart';

// Definisikan warna-warna utama agar mudah diubah dan konsisten
const Color primaryColor = Color(0xFF3B97F7);
const Color textFieldBackgroundColor = Color(0xFFF2F2F7);

// 1. Ubah menjadi StatefulWidget
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // 2. Buat GlobalKey untuk Form dan Controller untuk setiap input
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _pinController = TextEditingController();

  // Jangan lupa dispose controller untuk mencegah memory leak
  @override
  void dispose() {
    _phoneController.dispose();
    _pinController.dispose();
    super.dispose();
  }

  void _login() {
    // 3. Tambahkan fungsi untuk validasi
    // Metode validate() akan menjalankan fungsi validator di setiap TextFormField
    if (_formKey.currentState!.validate()) {
      // Jika semua input valid, lanjutkan ke halaman home
      // Di sini Anda bisa menambahkan logika API call
      print('Login berhasil dengan nomor: ${_phoneController.text}');
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        // 4. Bungkus Column dengan Widget Form
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

                // 5. Ganti _buildTextField dengan TextFormField yang sudah ada controller & validator
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
                      Navigator.pushNamed(context, '/forgot-pin');
                    },
                    child: const Text(
                      'Lupa PIN FISTRA',
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                // Tombol Login Utama
                ElevatedButton(
                  // Panggil fungsi _login saat tombol ditekan
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
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
                    Navigator.pushNamed(context, '/register');
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

  // 6. Ganti _buildTextField menjadi _buildTextFormField
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
      // Fungsi validator
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$hintText tidak boleh kosong'; // Pesan error
        }
        return null; // Return null jika valid
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
        // Style untuk error, agar lebih rapi
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
