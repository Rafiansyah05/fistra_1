import 'package:flutter/material.dart';
import 'package:fistra_1/1_registration/presentation/screens/tanggal_lahir.dart'; // We will create this file next

class NameInputPage extends StatefulWidget {
  const NameInputPage({super.key});

  @override
  State<NameInputPage> createState() => _NameInputPageState();
}

class _NameInputPageState extends State<NameInputPage> {
  final _nameController = TextEditingController();
  // final _formKey =
  //     GlobalKey<FormState>(); // Optional: for more complex validation

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _submitName() {
    // Simple validation: check if the field is not empty
    if (_nameController.text.trim().isNotEmpty) {
      Navigator.pushReplacement(
        // Use pushReplacement if you don't want to go back to this page
        context,
        MaterialPageRoute(builder: (context) => DobInputPage()),
      );
    } else {
      // Show a message if the field is empty
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nama Lengkap tidak boleh kosong!'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // This simulates the status bar height, not interactive
    // In a real app, the OS handles the status bar.
    // We use SafeArea to avoid drawing under it.
    // The time "21.20" and icons are part of the OS, not the app UI itself.

    return Scaffold(
      body: SafeArea(
        // Ensures content is not obscured by notches/status bar
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            20.0,
            0,
            20.0,
            20.0,
          ), // Adjusted top padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Simulate some space for the status bar or top elements if no AppBar
              const SizedBox(height: 50), // Approximate space based on image

              const Text(
                'Nama Lengkap',
                style: TextStyle(
                  fontSize: 24, // Made slightly larger to match general UI feel
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                // Using TextFormField for potential future validation via _formKey
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: 'Masukkan Nama Lengkap Kamu',
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  filled: true,
                  fillColor:
                      Colors.grey[100], // Light grey background for the input
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      25.0,
                    ), // Rounded corners
                    borderSide: BorderSide.none, // No visible border line
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 18,
                  ),
                ),
                style: const TextStyle(fontSize: 16, color: Colors.black87),
                keyboardType: TextInputType.name,
              ),
              const Spacer(), // Pushes the button to the bottom
              SizedBox(
                width: double.infinity, // Make button full width
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Button color
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        30.0,
                      ), // Rounded button
                    ),
                    elevation: 2, // Subtle shadow
                  ),
                  onPressed: _submitName,
                  child: const Text(
                    'Lanjut',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ), // Text color for the button
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
