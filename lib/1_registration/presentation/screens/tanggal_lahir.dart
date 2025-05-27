import 'package:fistra_1/1_registration/presentation/screens/allertToFingger.dart';
import 'package:flutter/material.dart';
// import 'package:fistra_1/1_registration/presentation/screens/fingerprintScan/fingerprint.dart';
import 'package:fistra_1/1_registration/presentation/screens/PIN/pin.dart';
// Hapus import 'package:flutter/services.dart'; karena tidak lagi dibutuhkan untuk inputFormatters
import 'package:intl/intl.dart'; // Untuk formatting tanggal
// import 'home_page.dart'; // Pastikan file ini ada dan sesuai

class DobInputPage extends StatefulWidget {
  const DobInputPage({super.key});

  @override
  State<DobInputPage> createState() => _DobInputPageState();
}

class _DobInputPageState extends State<DobInputPage> {
  final _dobController = TextEditingController();
  DateTime? _selectedDate;

  @override
  void dispose() {
    _dobController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      helpText: 'Pilih Tanggal Lahir',
      cancelText: 'Batal',
      confirmText: 'Pilih',
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.blue,
              onPrimary: Colors.white,
              onSurface: Colors.black87,
            ),
            dialogTheme: DialogThemeData(backgroundColor: Colors.white),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dobController.text = DateFormat('dd/MM/yyyy').format(_selectedDate!);
      });
    }
  }

  void _proceedToNextStep() {
    // Ini adalah fungsi yang akan dipanggil SETELAH dialog dikonfirmasi
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => CreatePinPage()),
    );
  }

  void _handleSubmission() {
    if (_selectedDate != null) {
      // Tampilkan dialog konfirmasi sidik jari
      showFingerprintConfirmationDialog(
        context: context,
        onMengerti: () {
          // Aksi setelah "Mengerti" ditekan: lanjut ke halaman berikutnya
          _proceedToNextStep();
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tanggal Lahir belum dipilih!'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 50),
              const Text(
                'Tanggal Lahir',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _dobController,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: 'HH/BB/TT',
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 18,
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today, color: Colors.blue),
                    onPressed: () {
                      _selectDate(context);
                    },
                  ),
                ),
                style: const TextStyle(fontSize: 16, color: Colors.black87),
                onTap: () {
                  _selectDate(context);
                },
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    elevation: 2,
                  ),
                  onPressed: _handleSubmission, // Panggil _handleSubmission
                  child: const Text(
                    'Lanjut',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
