// lib/create_pin_page.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Untuk TextInputFormatter
// Pastikan import halaman konfirmasi PIN benar
import 'package:fistra_1/1_registration/presentation/screens/PIN/pinKonfir.dart';

class CreatePinPage extends StatefulWidget {
  const CreatePinPage({super.key});

  @override
  State<CreatePinPage> createState() => _CreatePinPageState();
}

class _CreatePinPageState extends State<CreatePinPage> {
  final _pinController = TextEditingController();
  final _pinFocusNode = FocusNode();
  final int _pinLength = 6; // Jumlah digit PIN
  // String? createdPin; // Hapus getter yang salah, ini bisa jadi variabel jika diperlukan di sini

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

  void _submitPin() {
    if (_pinController.text.length == _pinLength) {
      String enteredPin = _pinController.text;
      print("PIN yang dibuat: $enteredPin");

      // Simpan PIN yang baru dibuat untuk dikirim ke halaman konfirmasi
      // setState(() {
      //   createdPin = enteredPin; // Jika Anda ingin menyimpan state PIN di sini
      // });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          // Kirimkan PIN yang baru dibuat ke halaman konfirmasi
          builder: (context) => ConfirmPinPage(originalPin: enteredPin),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Silakan masukkan 6 digit PIN.'),
          backgroundColor: Colors.orange,
        ),
      );
    }
  }

  Widget _buildPinBox(int index) {
    bool isFilled = index < _pinController.text.length;
    String digit =
        isFilled ? _pinController.text[index] : ''; // Ambil digit jika terisi

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
      // Menampilkan digit di tengah kotak
      child: Center(
        child: Text(
          digit, // Tampilkan digit yang dimasukkan
          style: const TextStyle(
            fontSize: 22, // Sesuaikan ukuran font jika perlu
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                  'Buat PIN FISTRA',
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
                    'PIN ini hanya digunakan ketika isi saldo dan ketika sidik jari tidak bisa diakses',
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
                          // obscureText: true, // Jika Anda ingin angka terlihat, set ini ke false
                          obscureText:
                              false, // --- Angka akan terlihat di TextFormField (meskipun fieldnya tidak terlihat) ---
                          // Ini penting agar kita bisa mengambil digitnya.
                          // Keamanan visual dihandle oleh tidak menampilkannya langsung dari TextFormField.
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
                            ? _submitPin
                            : null,
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
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
