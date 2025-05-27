// lib/confirm_pin_page.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 1. IMPOR YANG BENAR UNTUK FUNGSI DIALOG
import 'package:fistra_1/1_registration/presentation/screens/PIN/pinSukses.dart'; // <-- GANTI DENGAN PATH DAN NAMA FILE DIALOG ANDA YANG BENAR

// 2. Impor untuk halaman tujuan akhir
import 'package:fistra_1/home/presentation/screens/home.dart'; // Ini adalah HomePage
// Jika Anda masih ingin menampilkan halaman sukses PIN sebelum ke Home, Anda juga bisa mengimpornya

class ConfirmPinPage extends StatefulWidget {
  final String originalPin;

  const ConfirmPinPage({super.key, required this.originalPin});

  @override
  State<ConfirmPinPage> createState() => _ConfirmPinPageState();
}

class _ConfirmPinPageState extends State<ConfirmPinPage> {
  final _pinController = TextEditingController();
  final _pinFocusNode = FocusNode();
  final int _pinLength = 6;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_pinFocusNode);
    });
  }

  @override
  void dispose() {
    _pinController.dispose();
    _pinFocusNode.dispose();
    super.dispose();
  }

  void _onDialogMengerti() {
    print("Dialog 'Registrasi Akun FISTR Berhasil' dikonfirmasi.");

    // ARAHKAN KE HALAMAN SELANJUTNYA YANG BENAR (MISALNYA HomePage)
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        // Ganti HomePage() dengan halaman tujuan akhir Anda setelah registrasi
        builder: (context) => const HomeScreen(),
      ),
      (Route<dynamic> route) => false,
    );

    // ATAU, jika Anda ingin menampilkan RegistrationSuccessPage SEBELUM HomePage:
    // Navigator.pushReplacement( // Gunakan pushReplacement jika ini halaman antara
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => RegistrationSuccessPage(
    //       message: "Registrasi Akun FISTRA Berhasil!",
    //     ),
    //   ),
    // );
    // Kemudian dari RegistrationSuccessPage, Anda akan navigasi ke HomePage.
  }

  void _submitConfirmationPin() {
    if (_pinController.text.length == _pinLength) {
      String enteredConfirmationPin = _pinController.text;

      if (enteredConfirmationPin == widget.originalPin) {
        print("PIN berhasil dikonfirmasi: $enteredConfirmationPin");

        // PANGGIL FUNGSI DIALOG YANG BENAR
        ShowConfirmationSuccessPin(
          // Pastikan nama fungsi ini sesuai dengan definisi di file dialog
          context: context,
          onMengerti: _onDialogMengerti,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('PIN Konfirmasi tidak cocok. Silakan coba lagi.'),
            backgroundColor: Colors.redAccent,
          ),
        );
        _pinController.clear();
        FocusScope.of(context).requestFocus(_pinFocusNode);
        setState(() {});
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Silakan masukkan 6 digit PIN konfirmasi.'),
          backgroundColor: Colors.orange,
        ),
      );
    }
  }

  Widget _buildPinBox(int index) {
    bool isFilled = index < _pinController.text.length;
    String digit = isFilled ? _pinController.text[index] : '';
    return Container(
      width: 45,
      height: 45,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isFilled ? Colors.blue : Colors.grey[400]!,
          width: isFilled ? 1.5 : 1.0,
        ),
      ),
      child: Center(
        child: Text(
          digit,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // UI Widget build tetap sama
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(_pinFocusNode);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 20.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 40),
                const Text(
                  'Konfirmasi PIN FISTRA',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 12),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Masukkan kembali PIN yang telah Anda buat untuk konfirmasi.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                      height: 1.4,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 1,
                      height: 1,
                      child: Opacity(
                        opacity: 0.0,
                        child: TextFormField(
                          controller: _pinController,
                          focusNode: _pinFocusNode,
                          autofocus: false,
                          keyboardType: TextInputType.number,
                          maxLength: _pinLength,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          obscureText: false,
                          decoration: const InputDecoration(
                            counterText: '',
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                            setState(() {});
                          },
                          onTap: () {
                            FocusScope.of(context).requestFocus(_pinFocusNode);
                          },
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        FocusScope.of(context).requestFocus(_pinFocusNode);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(_pinLength, (index) {
                          return _buildPinBox(index);
                        }),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      elevation: 2,
                    ),
                    onPressed:
                        _pinController.text.length == _pinLength
                            ? _submitConfirmationPin
                            : null,
                    child: const Text(
                      'Konfirmasi',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
