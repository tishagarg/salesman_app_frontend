import 'package:flutter/material.dart';

class SalesToPage extends StatefulWidget {
  const SalesToPage({super.key});

  @override
  State<SalesToPage> createState() => _SalesToPageState();
}

class _SalesToPageState extends State<SalesToPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sales Turnover'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF6A48FF), Color(0xFF00DDFF)],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          _buildSalesTotalCard(),
          _buildSalesChart(),
          _buildSalesList(),
        ],
      ),
    );
  }

  Widget _buildSalesTotalCard() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6A48FF), Color(0xFF00DDFF)],
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          const Text(
            'Total Sales Today',
            style: TextStyle(color: Colors.white),
          ),
          const Text(
            'Rp 15,000,000',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSalesChart() {
    return Container(
      height: 200,
      margin: const EdgeInsets.all(16),
      color: Colors.grey[200],
      child: const Center(
        child: Text('Sales Chart Here'),
      ),
    );
  }

  Widget _buildSalesList() {
    return Expanded(
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Sale #${index + 1}'),
            subtitle: Text('Rp ${(index + 1) * 1000000}'),
            trailing: const Icon(Icons.arrow_forward_ios),
          );
        },
      ),
    );
  }
}
