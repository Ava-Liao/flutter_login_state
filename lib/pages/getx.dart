import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../store/auth_getx.dart';

class GetXLoginScreen extends StatelessWidget {
  const GetXLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('GetX 登录注册'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Obx(() {
              if (!authController.isRegistered.value && !authController.isCodeSent.value) {
                return Column(
                  children: [
                    TextField(
                      decoration: const InputDecoration(labelText: '邮箱'),
                      onChanged: (value) {
                        authController.email.value = value;
                      },
                    ),
                    ElevatedButton(
                      onPressed: () {
                        authController.checkEmail(authController.email.value);
                      },
                      child: const Text('检查邮箱'),
                    ),
                  ],
                );
              } else if (authController.isRegistered.value) {
                return Column(
                  children: [
                    TextField(
                      decoration: const InputDecoration(labelText: '密码'),
                      obscureText: true,
                      onChanged: (value) {
                        authController.password.value = value;
                      },
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // 登录逻辑
                        print("Logging in with password: ${authController.password.value}");
                      },
                      child: const Text('登录'),
                    ),
                  ],
                );
              } else if (!authController.isRegistered.value && authController.isCodeSent.value && !authController.isCodeVerified.value) {
                return ElevatedButton(
                  onPressed: authController.verifyCode,
                  child: const Text('验证验证码'),
                );
              } else if (!authController.isRegistered.value && !authController.isCodeSent.value) {
                return ElevatedButton(
                  onPressed: authController.sendVerificationCode,
                  child: const Text('发送验证码'),
                );
              } else if (authController.isCodeVerified.value) {
                return Column(
                  children: [
                    TextField(
                      decoration: const InputDecoration(labelText: '设置密码'),
                      obscureText: true,
                      onChanged: (value) {
                        authController.password.value = value;
                      },
                    ),
                    TextField(
                      decoration: const InputDecoration(labelText: '昵称'),
                      onChanged: (value) {
                        authController.nickname.value = value;
                      },
                    ),
                    ElevatedButton(
                      onPressed: () {
                        authController.completeProfile(authController.password.value, authController.nickname.value);
                      },
                      child: const Text('完成注册'),
                    ),
                  ],
                );
              }
              return Container();
            }),
          ],
        ),
      ),
    );
  }
}
