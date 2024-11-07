import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/setState.dart';
import 'pages/provider.dart';
import 'pages/getx.dart';
import 'store/auth_provider.dart';
import 'pages/setting.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => const LaunchScreen(),
        '/setStateLogin': (context) => const SetStateLoginScreen(),
        '/providerLogin': (context) => const ProviderLoginScreen(),
        '/getXLogin': (context) => const GetXLoginScreen(),
      },
    );
  }
}

class LaunchScreen extends StatelessWidget {
  const LaunchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('选择登录注册方式'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/setStateLogin');
              },
              child: const Text('使用 setState'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/providerLogin');
              },
              child: const Text('使用 Provider'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/getXLogin');
              },
              child: const Text('使用 GetX'),
            ),
          ],
        ),
      ),
    );
  }
}


