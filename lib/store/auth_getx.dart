import 'package:get/get.dart';

class AuthController extends GetxController {
  var email = ''.obs;
  var password = ''.obs;
  var nickname = ''.obs;
  var isRegistered = false.obs;
  var isCodeSent = false.obs;
  var isCodeVerified = false.obs;

  void checkEmail(String inputEmail) {
    // 假设我们有一个方法来检查邮箱是否注册
    isRegistered.value = inputEmail == "registered@example.com";
  }

  void sendVerificationCode() {
    // 发送验证码的逻辑
    isCodeSent.value = true;
  }

  void verifyCode() {
    // 验证码验证逻辑
    isCodeVerified.value = true;
  }

  void completeProfile(String inputPassword, String inputNickname) {
    // 完成 profile 的逻辑
    password.value = inputPassword;
    nickname.value = inputNickname;
    // 保存密码和昵称等其他信息
  }
}
