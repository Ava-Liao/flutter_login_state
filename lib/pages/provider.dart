import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../store/auth_provider.dart';

class ProviderLoginScreen extends StatelessWidget {
  const ProviderLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider 登录注册'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (!authProvider.isRegistered && !authProvider.isCodeSent)
              TextField(
                decoration: const InputDecoration(labelText: '邮箱'),
                onChanged: (value) {
                  authProvider.checkEmail(value);
                },
              ),
            if (authProvider.isRegistered)
              TextField(
                decoration: const InputDecoration(labelText: '密码'),
                obscureText: true,
                onChanged: (value) {
                  // 保存密码
                },
              ),
            if (authProvider.isRegistered)
              ElevatedButton(
                onPressed: () {
                  // 登录逻辑
                  print("Logging in with password");
                },
                child: const Text('登录'),
              ),
            if (!authProvider.isRegistered && authProvider.isCodeSent && !authProvider.isCodeVerified)
              ElevatedButton(
                onPressed: authProvider.verifyCode,
                child: const Text('验证验证码'),
              ),
            if (!authProvider.isRegistered && !authProvider.isCodeSent)
              ElevatedButton(
                onPressed: authProvider.sendVerificationCode,
                child: const Text('发送验证码'),
              ),
            if (authProvider.isCodeVerified)
              Column(
                children: [
                  TextField(
                    decoration: const InputDecoration(labelText: '设置密码'),
                    obscureText: true,
                    onChanged: (value) {
                      // 保存密码
                    },
                  ),
                  TextField(
                    decoration: const InputDecoration(labelText: '昵称'),
                    onChanged: (value) {
                      // 保存昵称
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      authProvider.completeProfile("password", "nickname");
                    },
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
