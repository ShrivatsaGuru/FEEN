import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

const String baseUrl = 'http://10.0.2.2:8000/api';

class ApiService {
  // REGISTER
  static Future<bool> register(
      String name,
      String email,
      String password,
      String phone,
      String confirmPassword,
      ) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: {
          'Accept': 'application/json',
        },
        body: {
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': confirmPassword,
          'phone_number': phone,
        },
      );

      print('REGISTER RESPONSE: ${response.statusCode}');
      print('BODY: ${response.body}');

      if (response.statusCode == 201) {
        final responseData = json.decode(response.body);
        print("User registered: ${responseData['user']['email']}");
        return true;
      } else {
        final errorData = json.decode(response.body);
        print("Registration failed: ${errorData['message']}");
        return false;
      }
    } catch (e) {
      print('Register error: $e');
      return false;
    }
  }

  // LOGIN
  static Future<bool> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/login');
    try {
      final response = await http.post(
        url,
        headers: {'Accept': 'application/json'},
        body: {
          'email': email,
          'password': password,
        },
      );

      print('LOGIN RESPONSE: ${response.statusCode}');
      print('BODY: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', data['access_token']);
        return true;
      } else {
        final errorData = json.decode(response.body);
        print("Login failed: ${errorData['message']}");
        return false;
      }
    } catch (e) {
      print('Login error: $e');
      return false;
    }
  }
}
