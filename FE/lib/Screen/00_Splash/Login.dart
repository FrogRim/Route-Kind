import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:dart_findy/Constant/Constants.dart';
import 'package:dart_findy/Constant/InApp.dart';
import './guest.dart';
import './Register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController controller_email = TextEditingController();
  TextEditingController controller_password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/app/Findy.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.4),
          ),
          GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 200),
                      const SizedBox(height: 190),
                      // 환영 메시지
                      const Text(
                        '  ''맞춤 여행을 시작하세요',
                        style: TextStyle(
                          color: BaseColorWhite,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      //const SizedBox(height: 8),
                      const Text(
                        '    ''당신만의 특별한 여행을 찾아드립니다!',
                        style: TextStyle(
                          color: BaseColorWhite,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.85),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: controller_email,
                              decoration: InputDecoration(
                                labelText: '이메일',
                                prefixIcon: const Icon(Icons.email_outlined),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Colors.grey.shade300),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(color: BaseColorCharcoal),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              keyboardType: TextInputType.emailAddress,
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: controller_password,
                              decoration: InputDecoration(
                                labelText: '비밀번호',
                                prefixIcon: const Icon(Icons.lock_outline),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Colors.grey.shade300),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(color: BaseColorCharcoal),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              obscureText: true,
                            ),
                            const SizedBox(height: 24),
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: _ToHome,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: BaseColorCharcoal,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 2,
                                ),
                                child: const Text(
                                  '로그인',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      Center(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: '아직 계정이 없으신가요?''  ',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 15,
                                ),
                              ),
                              TextSpan(
                                text: '회원가입',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                                recognizer: TapGestureRecognizer()..onTap = _ToRegister,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _ToHome() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: controller_email.text,
        password: controller_password.text,
      );
      // 로그인 성공 시 처리
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => InApp()), // ListPage로 이동
      );
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'user-not-found':
          message = 'No user found for that email.';
          break;
        case 'wrong-password':
          message = 'Wrong password provided for that user.';
          break;
        default:
          message = 'An error occurred. Please try again.';
      }
      // 에러 메시지를 스낵바로 출력
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred. Please try again.')),
      );
    }
  }
  //   if (controller.text == guestList[0].email && controller2.text == guestList[0].password) {
  //     final SharedPreferences prefs = await SharedPreferences.getInstance();
  //     await prefs.setBool('isLoggedIn', true);
  //     Navigator.of(context).pushReplacement(
  //         MaterialPageRoute(builder: (context) => const InApp()));
  //   } else if (controller.text == guestList[0].email && controller2.text != guestList[0].password) {
  //     showSnackBar(context, const Text('비밀번호가 올바르지 않습니다'));
  //   } else if (controller.text != guestList[0].email && controller2.text == guestList[0].password) {
  //     showSnackBar(context, const Text('이메일이 올바르지 않습니다'));
  //   } else {
  //     showSnackBar(context, const Text('로그인 정보를 다시 확인해주세요'));
  //   }
  // }
  //
  Future<void> _ToRegister() async {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const RegisterPage()));
  }
}

void showSnackBar(BuildContext context, Text text) {
  final snackBar = SnackBar(
    content: text,
    backgroundColor: Colors.red.shade800,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    margin: const EdgeInsets.all(20),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}