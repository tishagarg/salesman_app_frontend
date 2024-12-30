import 'package:flutter/material.dart';

class VisitSpvPage extends StatefulWidget {
  const VisitSpvPage({super.key});

  @override
  State<VisitSpvPage> createState() => _VisitSpvPageState();
}

class _VisitSpvPageState extends State<VisitSpvPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Supervisor Visit'),
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
          _buildUpcomingVisits(),
          _buildVisitHistory(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildUpcomingVisits() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Upcoming Visits',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Column(
              children: [
                Text('Next Visit: March 20, 2024'),
                Text('Location: Store A'),
                Text('Supervisor: John Doe'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVisitHistory() {
    return Expanded(
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const CircleAvatar(
              child: Icon(Icons.person),
            ),
            title: Text('Visit #${index + 1}'),
            subtitle: Text('March ${index + 1}, 2024'),
            trailing: const Icon(Icons.arrow_forward_ios),
          );
        },
      ),
    );
  }
}
