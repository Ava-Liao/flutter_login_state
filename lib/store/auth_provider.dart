import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  String _email = '';
  String _password = '';
  bool _isRegistered = false;
  bool _isCodeSent = false;
  bool _isCodeVerified = false;

  String get email => _email;
  bool get isRegistered => _isRegistered;
  bool get isCodeSent => _isCodeSent;
  bool get isCodeVerified => _isCodeVerified;

  void checkEmail(String email) {
    // 假设我们有一个方法来检查邮箱是否注册
    _isRegistered = email == "registered@example.com";
    notifyListeners();
  }

  void sendVerificationCode() {
    // 发送验证码的逻辑
    _isCodeSent = true;
    notifyListeners();
  }

  void verifyCode() {
    // 验证码验证逻辑
    _isCodeVerified = true;
    notifyListeners();
  }

  void completeProfile(String password, String nickname) {
    // 完成 profile 的逻辑
    _password = password;
    // 保存昵称等其他信息
    notifyListeners();
  }
}