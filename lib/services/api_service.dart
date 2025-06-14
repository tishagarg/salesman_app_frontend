import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:test_saja/models/event_model.dart';

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:3000/api/v1';

  Future<Map<String, dynamic>> testApi() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/test'));
      return jsonDecode(response.body);
    } catch (e) {
      return {'status': false, 'message': 'Error: $e'};
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      print('Attempting login with NIP: $email');

      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      print('Login error: $e');
      return {'status': false, 'message': 'Koneksi error: $e'};
    }
  }

  Future<List<EventModel>> getEvents() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/events'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

      print('Response status: ${response.statusCode}'); // Debug
      print('Response body: ${response.body}'); // Debug

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == true && data['data'] != null) {
          return (data['data'] as List)
              .map((event) => EventModel.fromJson(event))
              .toList();
        }
      }
      return [];
    } catch (e) {
      print('Error getting events: $e');
      return [];
    }
  }
}
