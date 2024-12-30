import 'package:flutter/material.dart';

class EstimasiGlobalPage extends StatelessWidget {
  const EstimasiGlobalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Estimasi Global'),
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
          _buildEstimasiCard(),
          _buildChartSection(),
          _buildDetailsList(),
        ],
      ),
    );
  }

  Widget _buildEstimasiCard() {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Total Estimasi Global',
              style: TextStyle(fontSize: 16),
            ),
            const Text(
              'Rp 1.500.000.000',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildEstimasiInfo('Target', 'Rp 2M'),
                _buildEstimasiInfo('Progress', '75%'),
                _buildEstimasiInfo('Status', 'On Track'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEstimasiInfo(String label, String value) {
    return Column(
      children: [
        Text(label, style: TextStyle(color: Colors.grey[600])),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildChartSection() {
    return Container(
      height: 200,
      margin: const EdgeInsets.all(16),
      color: Colors.grey[200],
      child: const Center(child: Text('Chart Area')),
    );
  }

  Widget _buildDetailsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'Details',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 5,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('Category ${index + 1}'),
              trailing: Text('Rp ${(index + 1) * 100000}'),
            );
          },
        ),
      ],
    );
  }
}
