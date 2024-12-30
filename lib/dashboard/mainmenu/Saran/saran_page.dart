import 'package:flutter/material.dart';

class SaranPage extends StatefulWidget {
  const SaranPage({super.key});

  @override
  State<SaranPage> createState() => _SaranPageState();
}

class _SaranPageState extends State<SaranPage> {
  final _formKey = GlobalKey<FormState>();
  final _saranController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saran & Masukan'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF6A48FF), Color(0xFF00DDFF)],
            ),
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _saranController,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Tulis Saran',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your suggestion';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Submit suggestion
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6A48FF),
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: const Text('Submit Saran'),
            ),
          ],
        ),
      ),
    );
  }
}
