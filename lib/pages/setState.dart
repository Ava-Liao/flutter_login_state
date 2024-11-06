import 'package:flutter/material.dart';

class SetStateLoginScreen extends StatefulWidget {
  const SetStateLoginScreen({super.key});

  @override
  SetStateLoginScreenState createState() => SetStateLoginScreenState();
}

class SetStateLoginScreenState extends State<SetStateLoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();
  bool _isRegistered = false;
  bool _isCodeSent = false;
  bool _isCodeVerified = false;

  void _checkEmail() {
    // 假设我们有一个方法来检查邮箱是否注册
    setState(() {
      _isRegistered = _emailController.text == "registered@example.com";
    });
  }

  void _sendVerificationCode() {
    // 发送验证码的逻辑
    setState(() {
      _isCodeSent = true;
    });
  }

  void _verifyCode() {
    // 验证码验证逻辑
    setState(() {
      _isCodeVerified = true;
    });
  }

  void _completeProfile() {
    // 完成 profile 的逻辑
    // 例如，保存密码和昵称
    print("Password: ${_passwordController.text}, Nickname: ${_nicknameController.text}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('setState 登录注册'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (!_isRegistered && !_isCodeSent)
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: '邮箱'),
              ),
            if (!_isRegistered && !_isCodeSent)
              ElevatedButton(
                onPressed: _checkEmail,
                child: const Text('检查邮箱'),
              ),
            if (_isRegistered)
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: '密码'),
                obscureText: true,
              ),
            if (_isRegistered)
              ElevatedButton(
                onPressed: () {
                  // 登录逻辑
                  print("Logging in with password: ${_passwordController.text}");
                },
                child: const Text('登录'),
              ),
            if (!_isRegistered && _isCodeSent && !_isCodeVerified)
              ElevatedButton(
                onPressed: _verifyCode,
                child: const Text('验证验证码'),
              ),
            if (!_isRegistered && !_isCodeSent)
              ElevatedButton(
                onPressed: _sendVerificationCode,
                child: const Text('发送验证码'),
              ),
            if (_isCodeVerified)
              Column(
                children: [
                  TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(labelText: '设置密码'),
                    obscureText: true,
                  ),
                  TextField(
                    controller: _nicknameController,
                    decoration: const InputDecoration(labelText: '昵称'),
                  ),
                  ElevatedButton(
                    onPressed: _completeProfile,
                    child: const Text('完成注册'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}