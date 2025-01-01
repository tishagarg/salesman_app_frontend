import 'package:flutter/material.dart';

class GajiHarianPage extends StatelessWidget {
  const GajiHarianPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gaji Harian'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF6A48FF), Color(0xFF00DDFF)],
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          _buildSalaryCard(),
          _buildSalaryHistory(),
        ],
      ),
    );
  }

  Widget _buildSalaryCard() {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Total Gaji Hari Ini',
              style: TextStyle(fontSize: 16),
            ),
            const Text(
              'Rp 150.000',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSalaryInfo('Jam Kerja', '8 jam'),
                _buildSalaryInfo('Rate/Jam', 'Rp 18.750'),
                _buildSalaryInfo('Status', 'Lunas'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSalaryInfo(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.grey[600]),
        ),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildSalaryHistory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'Riwayat Gaji',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 7,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(DateTime.now()
                  .subtract(Duration(days: index))
                  .toString()
                  .split(' ')[0]),
              trailing: const Text(
                'Rp 150.000',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            );
          },
        ),
      ],
    );
  }
}
