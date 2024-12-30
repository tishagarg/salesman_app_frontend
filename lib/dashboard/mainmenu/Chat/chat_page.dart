import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _searchController = TextEditingController();
  String _selectedUserType = 'admin';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF6A48FF), Color(0xFF00DDFF)],
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: 5, // Replace with actual chat list length
        itemBuilder: (context, index) {
          return _buildChatItem(
            name: 'User ${index + 1}',
            lastMessage: 'Last message preview...',
            time: '12:00',
            unread: index == 0 ? 3 : 0,
          );
        },
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF6A48FF), Color(0xFF00DDFF)],
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: FloatingActionButton.extended(
          onPressed: () => _showNewChatDialog(),
          backgroundColor: Colors.transparent,
          elevation: 0,
          label: const Text(
            'New Chat',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          icon: const Icon(
            Icons.chat_bubble_outline,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildChatItem({
    required String name,
    required String lastMessage,
    required String time,
    int unread = 0,
  }) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: const Color(0xFF6A48FF),
        child: Text(
          name[0].toUpperCase(),
          style: const TextStyle(color: Colors.white),
        ),
      ),
      title: Text(
        name,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        lastMessage,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            time,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
            ),
          ),
          if (unread > 0)
            Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                color: Color(0xFF6A48FF),
                shape: BoxShape.circle,
              ),
              child: Text(
                unread.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ),
        ],
      ),
      onTap: () {
        // Navigate to chat detail
      },
    );
  }

  void _showNewChatDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('New Chat'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text('Admin'),
                    value: 'admin',
                    groupValue: _selectedUserType,
                    onChanged: (value) =>
                        setState(() => _selectedUserType = value!),
                  ),
                ),
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text('Sales'),
                    value: 'sales',
                    groupValue: _selectedUserType,
                    onChanged: (value) =>
                        setState(() => _selectedUserType = value!),
                  ),
                ),
              ],
            ),
            if (_selectedUserType == 'sales')
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Enter Sales Code',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF6A48FF), Color(0xFF00DDFF)],
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ElevatedButton(
              onPressed: () {
                // Handle new chat creation
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
              ),
              child: const Text(
                'Start Chat',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
