import 'package:shared_preferences/shared_preferences.dart';

class Auth {
  Future<void> saveUserInfo(String nickname, String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('nickname', nickname);
    await prefs.setString('email', email);
  }

  Future<Map<String, String?>> getUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final nickname = prefs.getString('nickname');
    final email = prefs.getString('email');
    return {'nickname': nickname, 'email': email};
  }
} 