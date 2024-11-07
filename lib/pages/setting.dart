import 'package:flutter/material.dart';
import '../store/auth.dart';

class SettingScreen extends StatefulWidget {
  @override
  SettingScreenState createState() => SettingScreenState();
}

class SettingScreenState extends State<SettingScreen> {
  String? nickname;
  String? email;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    final auth = Auth();
    final userInfo = await auth.getUserInfo();
    setState(() {
      nickname = userInfo['nickname'];
      email = userInfo['email'];
    });
  }

   @override
  Widget build(BuildContext context) {
     return PopScope(
      canPop: false,
      onPopInvokedWithResult: (context, result) {
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
        ),
        body: const Center(
          child: Text('This is the settings screen'),
        ),
      ),
    );
  }
}
