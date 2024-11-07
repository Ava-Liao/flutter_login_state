import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../store/auth.dart';
import 'setting.dart';

class SetStateLoginScreen extends StatefulWidget {
  const SetStateLoginScreen({super.key});
  @override
  SetStateLoginScreenState createState() => SetStateLoginScreenState();
}

enum LoginState {
  email,
  password,
  code,
  profile,
}

class SetStateLoginScreenState extends State<SetStateLoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();
  LoginState _loginState = LoginState.email;
  bool _isRegistered = false;
  bool _isCodeVerified = false;

  void _checkEmail() {
    setState(() {
      _isRegistered = _emailController.text == "registered@example.com";
      _loginState = _isRegistered ? LoginState.password : LoginState.code;
    });
  }

  void _verifyCode() {
    setState(() {
      _isCodeVerified = _codeController.text == "123456";
      if (_isCodeVerified) {
        _loginState = LoginState.profile;
      }
    });
  }

  void _completeProfile() {
    final auth = Auth();
    auth.saveUserInfo(_nicknameController.text, _emailController.text).then((_) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SettingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Log in to your Account',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            GoogleSignInButton(),
            const SizedBox(height: 24),
            _buildLoginStateUI(),
            const SizedBox(height: 24),
            const Text(
              'By continuing, you acknowledge that you understand and agree to the Terms & Conditions and Privacy Policy',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginStateUI() {
    switch (_loginState) {
      case LoginState.email:
        return CustomInputField(
          controller: _emailController,
          hintText: 'Enter your email',
          buttonText: 'Continue',
          onPressed: _checkEmail,
        );
      case LoginState.password:
        return CustomInputField(
          controller: _passwordController,
          hintText: 'Enter your password',
          buttonText: 'Login',
          isPassword: true,
          onPressed: () {
            Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => SettingScreen()),
          );
          },
        );
      case LoginState.code:
        return CustomInputField(
          controller: _codeController,
          hintText: 'Enter verification code',
          buttonText: 'Verify',
          onPressed: _verifyCode,
        );
      case LoginState.profile:
        return ProfileInput(
          nicknameController: _nicknameController,
          passwordController: _passwordController,
          onComplete: _completeProfile,
        );
    }
  }
}

class CustomInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String buttonText;
  final bool isPassword;
  final VoidCallback onPressed;

  const CustomInputField({
    required this.controller,
    required this.hintText,
    required this.buttonText,
    this.isPassword = false,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: Colors.grey[100],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
          obscureText: isPassword,
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black87,
            padding: const EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            buttonText,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

class ProfileInput extends StatelessWidget {
  final TextEditingController nicknameController;
  final TextEditingController passwordController;
  final VoidCallback onComplete;

  const ProfileInput({
    required this.nicknameController,
    required this.passwordController,
    required this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: nicknameController,
          decoration: InputDecoration(
            hintText: 'Enter your nickname',
            filled: true,
            fillColor: Colors.grey[100],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: passwordController,
          decoration: InputDecoration(
            hintText: 'Enter your password',
            filled: true,
            fillColor: Colors.grey[100],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
          obscureText: true,
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            if (nicknameController.text.isNotEmpty &&
                passwordController.text.isNotEmpty) {
              onComplete();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Please fill in all fields')),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black87,
            padding: const EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            'Complete',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

class GoogleSignInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () {
        // Google登录逻辑
      },
      icon: SvgPicture.asset(
        'assets/icon/mx_n_1718090036956.svg',
        height: 24,
      ),
      label: const Text(
        'Continue with Google',
        style: TextStyle(
          color: Colors.black87,
          fontSize: 16,
        ),
      ),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12),
        side: const BorderSide(color: Colors.grey),
        backgroundColor: Colors.white,
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: FutureBuilder<Map<String, String?>>(
        future: Auth().getUserInfo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading profile'));
          } else {
            final userInfo = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Nickname: ${userInfo['nickname'] ?? 'N/A'}'),
                  SizedBox(height: 8),
                  Text('Email: ${userInfo['email'] ?? 'N/A'}'),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}