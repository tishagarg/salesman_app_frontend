import 'package:flutter/material.dart';

class CekKendaraanPage extends StatefulWidget {
  const CekKendaraanPage({super.key});

  @override
  State<CekKendaraanPage> createState() => _CekKendaraanPageState();
}

class _CekKendaraanPageState extends State<CekKendaraanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cek Kendaraan'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF6A48FF), Color(0xFF00DDFF)],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildVehicleStatus(),
            _buildMaintenanceCard(),
            _buildCheckList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new vehicle check
        },
        backgroundColor: const Color(0xFF6A48FF),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildVehicleStatus() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6A48FF), Color(0xFF00DDFF)],
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Vehicle ID: TRK-001',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(Icons.local_shipping, color: Colors.white, size: 30),
            ],
          ),
          const Divider(color: Colors.white30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatusItem('Fuel', '75%', Icons.local_gas_station),
              _buildStatusItem('Mileage', '12,500 km', Icons.speed),
              _buildStatusItem('Status', 'Active', Icons.check_circle),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.white),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(color: Colors.white70),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildMaintenanceCard() {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Maintenance Schedule',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildMaintenanceItem(
              'Oil Change',
              'Due in 500 km',
              Colors.orange,
            ),
            _buildMaintenanceItem(
              'Tire Rotation',
              'Due in 1,000 km',
              Colors.green,
            ),
            _buildMaintenanceItem(
              'Brake Check',
              'Due in 200 km',
              Colors.red,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMaintenanceItem(String title, String status, Color color) {
    return ListTile(
      leading: Icon(Icons.build, color: color),
      title: Text(title),
      subtitle: Text(status),
      trailing: Icon(Icons.arrow_forward_ios, size: 16),
    );
  }

  Widget _buildCheckList() {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Daily Inspection Checklist',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildChecklistItem('Exterior Condition', true),
            _buildChecklistItem('Tire Pressure', true),
            _buildChecklistItem('Oil Level', false),
            _buildChecklistItem('Brake Fluid', true),
            _buildChecklistItem('Lights', true),
            _buildChecklistItem('Wipers', true),
          ],
        ),
      ),
    );
  }

  Widget _buildChecklistItem(String title, bool isChecked) {
    return CheckboxListTile(
      title: Text(title),
      value: isChecked,
      onChanged: (value) {
        setState(() {
          // Update checklist item
        });
      },
      activeColor: const Color(0xFF6A48FF),
    );
  }
}
