import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences.dart';
import '../models/user.dart';

class AuthService {
  final String baseUrl;
  final SharedPreferences _prefs;

  AuthService({required this.baseUrl, required SharedPreferences prefs}) : _prefs = prefs;

  Future<User> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        await _prefs.setString('token', data['token']);
        return User.fromJson(data['user']);
      } else {
        throw Exception('Login failed: ${response.body}');
      }
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  Future<void> logout() async {
    await _prefs.remove('token');
  }

  String? getToken() {
    return _prefs.getString('token');
  }
}
