import 'package:flutter/material.dart';

class CekPendingPage extends StatefulWidget {
  const CekPendingPage({super.key});

  @override
  State<CekPendingPage> createState() => _CekPendingPageState();
}

class _CekPendingPageState extends State<CekPendingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pending Tasks'),
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
          _buildPendingCounter(),
          _buildPendingList(),
        ],
      ),
    );
  }

  Widget _buildPendingCounter() {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Pending Tasks',
            style: TextStyle(fontSize: 18),
          ),
          Text(
            '5',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPendingList() {
    return Expanded(
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: const Icon(Icons.warning, color: Colors.red),
              title: Text('Pending Task #${index + 1}'),
              subtitle: Text('Due: March ${index + 15}, 2024'),
              trailing: TextButton(
                onPressed: () {},
                child: const Text('Resolve'),
              ),
            ),
          );
        },
      ),
    );
  }
}
