import 'dart:convert';

import 'package:cabia_mobile/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  static const host = 'https://dummyjson.com';
  static const _userKey = 'authenticated_user';
  static const _demoUsername = 'Nashuu';
  static const _demoPassword = '123456';

  static Future<User> loginUser(String username, String password) async {
    if (username == _demoUsername && password == _demoPassword) {
      const user = User(
        id: 1,
        username: _demoUsername,
        email: 'nashuu@aquaria.local',
        firstName: 'Nash',
        lastName: 'Cabia',
        gender: 'unspecified',
        image: '',
        accessToken: 'local-demo-token',
        refreshToken: 'local-demo-refresh-token',
      );
      await saveUserData(user);
      return user;
    }

    final response = await http.post(
      Uri.parse('$host/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
        'expiresInMins': 30,
      }),
    );

    final body = jsonDecode(response.body);
    if (response.statusCode < 200 || response.statusCode >= 300) {
      final message = body is Map ? body['message'] : null;
      throw Exception(message is String ? message : 'Login failed');
    }

    if (body is! Map<String, dynamic>) {
      throw Exception('Invalid login response');
    }

    final user = User.fromJson(body);
    await saveUserData(user);
    return user;
  }

  static Future<void> saveUserData(User user) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_userKey, jsonEncode(user.toJson()));
  }

  static Future<Map<String, dynamic>?> getUserData() async {
    final preferences = await SharedPreferences.getInstance();
    final value = preferences.getString(_userKey);
    if (value == null) {
      return null;
    }

    final decoded = jsonDecode(value);
    return decoded is Map<String, dynamic> ? decoded : null;
  }

  static Future<User?> getUser() async {
    final data = await getUserData();
    return data == null ? null : User.fromJson(data);
  }

  static Future<bool> isLoggedIn() async => await getUser() != null;

  static Future<void> logout() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.remove(_userKey);
  }
}
