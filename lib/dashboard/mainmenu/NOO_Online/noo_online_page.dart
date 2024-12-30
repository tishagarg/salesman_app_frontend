import 'package:flutter/material.dart';

class NooOnlinePage extends StatelessWidget {
  const NooOnlinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NOO Online'),
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
          _buildStatusCard(),
          Expanded(
            child: _buildOrdersList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildStatusCard() {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildStatusItem('Pending', '5', Colors.orange),
            _buildStatusItem('Process', '3', Colors.blue),
            _buildStatusItem('Complete', '12', Colors.green),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusItem(String label, String count, Color color) {
    return Column(
      children: [
        Text(
          count,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(label),
      ],
    );
  }

  Widget _buildOrdersList() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            leading: const CircleAvatar(
              child: Icon(Icons.shopping_bag),
            ),
            title: Text('Order #${1000 + index}'),
            subtitle: Text('Customer ${index + 1}'),
            trailing: const Chip(
              label: Text('Pending'),
              backgroundColor: Colors.orange,
            ),
          ),
        );
      },
    );
  }
}
