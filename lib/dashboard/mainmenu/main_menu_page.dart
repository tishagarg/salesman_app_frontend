import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:test_saja/dashboard/mainmenu/Cek_Kendaraan/cek_kendaraan_page.dart';
import 'package:test_saja/dashboard/mainmenu/Cek_Pending/cek_pending_page.dart';
import 'package:test_saja/dashboard/mainmenu/Chat/chat_page.dart';
import 'package:test_saja/dashboard/mainmenu/Estimasi_Global/estimasi_global_page.dart';
import 'package:test_saja/dashboard/mainmenu/Gaji_Harian/gaji_harian_page.dart';
import 'package:test_saja/dashboard/mainmenu/ID_Card/id_card_page.dart';
import 'package:test_saja/dashboard/mainmenu/NOO_Online/noo_online_page.dart';
import 'package:test_saja/dashboard/mainmenu/Sales_TO/sales_to_page.dart';
import 'package:test_saja/dashboard/mainmenu/Saran/saran_page.dart';
import 'package:test_saja/dashboard/mainmenu/Visit_SPV/visit_spv_page.dart';
import 'package:test_saja/dashboard/mainmenu/event_page/event_detail_page.dart';
import 'package:test_saja/models/event_model.dart';
import 'package:test_saja/services/api_service.dart';
import 'package:test_saja/template/Device_ID/device_id_page.dart';
import 'package:test_saja/template/Reprint_Faktur/reprint_faktur_page.dart';

import '../../models/user_model.dart';
import '../setting_page.dart';
import 'Absensi/absensi_page.dart';
import 'Load_DO/load_do_page.dart';

class MainMenuPage extends StatefulWidget {
  final UserModel user;
  const MainMenuPage({super.key, required this.user});
  @override
  State<MainMenuPage> createState() => _MainMenuPageState();
}

class _MainMenuPageState extends State<MainMenuPage> {
  final ApiService _apiService = ApiService();
  List<EventModel> _events = [];
  bool _isLoading = true;
  int _selectedIndex = 0;

  final List<String> bannerImages = [
    'assets/banner1.jpg',
    'assets/banner2.jpg',
    'assets/banner3.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _loadEvents();
  }

  Future<void> _loadEvents() async {
    try {
      final events = await _apiService.getEvents();
      setState(() {
        _events = events;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bakery Factory Management'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF6A48FF), Color(0xFF00DDFF)],
            ),
          ),
        ),
      ),
      drawer: _buildDrawer(),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  _buildBannerCarousel(),
                  const SizedBox(height: 20),
                  _buildQuickActions(),
                  const SizedBox(height: 20),
                  _buildProductionSection(),
                  const SizedBox(height: 20),
                  _buildInventorySection(),
                  const SizedBox(height: 20),
                  _buildSalesSection(),
                  const SizedBox(height: 20),
                  if (_events.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'Events',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 200,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _events.length,
                            itemBuilder: (context, index) => SizedBox(
                              width: 300,
                              child: _buildEventCard(_events[index]),
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF6A48FF), Color(0xFF00DDFF)],
              ),
            ),
            accountName: Text(widget.user.nama),
            accountEmail: Text('NIP: ${widget.user.nip}'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                widget.user.nama[0].toUpperCase(),
                style: const TextStyle(fontSize: 24),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.devices),
            title: const Text('Device ID'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DeviceIDPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.receipt_long),
            title: const Text('Reprint Faktur'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ReprintFakturPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.menu_book),
            title: const Text('Buku Manual'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.print),
            title: const Text('Setting Printer'),
            onTap: () {
              // Navigate to profile
            },
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notifications'),
            trailing: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: const Text(
                '3',
                style: TextStyle(color: Colors.white),
              ),
            ),
            onTap: () {
              // Navigate to notifications
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.help_outline),
            title: const Text('Tentang Kami'),
            onTap: () {
              // Basic navigation or dialog can be added here if needed
              Navigator.pop(context);
            },
          ),
          const Spacer(),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Logout', style: TextStyle(color: Colors.red)),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Logout'),
                  content: const Text('Are you sure you want to logout?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                      child: const Text('Logout',
                          style: TextStyle(color: Colors.red)),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF6A48FF), Color(0xFF00DDFF)],
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white60,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Pelanggan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payment),
            label: 'Expenses',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: 'Transactions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.upload_file),
            label: 'Upload',
          ),
        ],
      ),
    );
  }

  Widget _buildBannerCarousel() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200,
        autoPlay: true,
        enlargeCenterPage: true,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        viewportFraction: 0.8,
      ),
      items: [
        _buildBannerCard(
          'Production Goals',
          'Daily target: 5000 units',
          Icons.trending_up,
          Colors.blue,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EventDetailPage(
                  title: 'Special Event',
                  description: 'Christmas Orders Open',
                  date: 'Dec 25, 2024',
                ),
              ),
            );
          },
          child: _buildBannerCard(
            'Special Event',
            'Christmas Orders Open',
            Icons.event,
            Colors.orange,
          ),
        ),
        _buildBannerCard(
          'Inventory Alert',
          'Low stock on wheat flour',
          Icons.warning,
          Colors.red,
        ),
      ],
    );
  }

  Widget _buildBannerCard(
      String title, String subtitle, IconData icon, Color color) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color, color.withOpacity(0.7)],
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 50),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              subtitle,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventCard(EventModel event) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF6A48FF),
            const Color(0xFF00DDFF).withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          if (event.imageUrl.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                event.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.7),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        blurRadius: 10,
                        color: Colors.black,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  event.description,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 16,
                    shadows: const [
                      Shadow(
                        blurRadius: 8,
                        color: Colors.black,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today,
                      color: Colors.white,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      event.date,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Quick Actions',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            children: [
              _buildActionItem('Load DO', Icons.local_shipping, Colors.blue),
              _buildActionItem('Absensi', Icons.people_alt, Colors.green),
              _buildActionItem('Sales TO', Icons.point_of_sale, Colors.orange),
              _buildActionItem(
                  'Visit SPV', Icons.supervised_user_circle, Colors.purple),
              _buildActionItem(
                  'Cek Pending', Icons.pending_actions, Colors.red),
              _buildActionItem('ID Card', Icons.badge, Colors.indigo),
              _buildActionItem('Saran', Icons.lightbulb, Colors.teal),
              _buildActionItem(
                  'Gaji Harian', Icons.monetization_on, Colors.amber),
              _buildActionItem(
                  'NOO Online', Icons.online_prediction, Colors.brown),
              _buildActionItem('Estimasi Global', Icons.adobe, Colors.cyan),
              _buildActionItem('Chat', Icons.chat, Colors.pink),
              _buildActionItem(
                  'Cek Kendaraan', Icons.directions_car, Colors.deepOrange),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionItem(String title, IconData icon, Color color) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: () {
          if (title == 'Load DO') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoadDOPage()),
            );
          }
          if (title == 'Absensi') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AbsensiPage()),
            );
          }
          if (title == 'Sales TO') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SalesToPage()),
            );
          }
          if (title == 'Visit SPV') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const VisitSpvPage()),
            );
          }
          if (title == 'ID Card') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const IdCardPage()),
            );
          }
          if (title == 'Cek Pending') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CekPendingPage()),
            );
          }
          if (title == 'Cek Kendaraan') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CekKendaraanPage()),
            );
          }
          if (title == 'Chat') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ChatPage()),
            );
          }
          if (title == 'Estimasi Global') {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const EstimasiGlobalPage()),
            );
          }
          if (title == 'Gaji Harian') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const GajiHarianPage()),
            );
          }
          if (title == 'NOO Online') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NooOnlinePage()),
            );
          }
          if (title == 'Saran') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SaranPage()),
            );
          }
          // Handle navigation
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildProductionSection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Today\'s Production',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                _buildProductionItem(
                    'Wheat Bread', '1200/2000', 0.6, Colors.blue),
                _buildProductionItem(
                    'Sweet Rolls', '800/1000', 0.8, Colors.green),
                _buildProductionItem(
                    'Croissants', '300/500', 0.6, Colors.orange),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductionItem(
      String name, String progress, double value, Color color) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(name),
            Text(progress),
          ],
        ),
        const SizedBox(height: 5),
        LinearProgressIndicator(
          value: value,
          backgroundColor: color.withOpacity(0.2),
          valueColor: AlwaysStoppedAnimation<Color>(color),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildInventorySection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Inventory Status',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          _buildInventoryCard('Flour', '500 kg', '70%', Colors.green),
          _buildInventoryCard('Sugar', '200 kg', '45%', Colors.orange),
          _buildInventoryCard('Eggs', '100 trays', '20%', Colors.red),
        ],
      ),
    );
  }

  Widget _buildInventoryCard(
      String item, String quantity, String percentage, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Icon(Icons.inventory_2, color: color),
        title: Text(item),
        subtitle: Text(quantity),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            percentage,
            style: TextStyle(color: color),
          ),
        ),
      ),
    );
  }

  Widget _buildSalesSection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Sales Overview',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _buildSalesCard(
                  'Today\'s Sales',
                  'Rp 5.2M',
                  Icons.trending_up,
                  Colors.green,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildSalesCard(
                  'Orders',
                  '42',
                  Icons.shopping_basket,
                  Colors.blue,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSalesCard(
      String title, String value, IconData icon, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, color: color),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(color: Colors.grey[600]),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
