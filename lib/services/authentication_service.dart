import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

class AuthService {
  static const String keyUsername = 'username';

  static Future<void> login(String username, String password) async {
    // Mock login logic: password must be '123'
    if (password == '123') {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(keyUsername, username);
    } else {
      throw Exception('Invalid credentials');
    }
  }

  static Future<User?> getLoggedInUser() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString(keyUsername);
    if (username != null) {
      return User(username: username);
    }
    return null;
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(keyUsername);
  }
}
