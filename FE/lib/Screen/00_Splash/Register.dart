import 'package:dart_findy/Screen/00_Splash/guest.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './guest.dart';
import 'package:dart_findy/Constant/Constants.dart';
import 'package:dart_findy/Constant/InApp.dart';
import './Login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final database = FirebaseFirestore.instance;

  TextEditingController controller_name = TextEditingController();
  TextEditingController controller_phone = TextEditingController();
  TextEditingController controller_email = TextEditingController();
  TextEditingController controller_password = TextEditingController();
  TextEditingController controller_pwtest = TextEditingController();
  int? selectedGender;

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
            color: Colors.black.withOpacity(0.6),
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
                      const SizedBox(height: 30),
                      const Text(
                        '  ''회원가입',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 50),
                      // 입력 폼
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
                          // 이름 입력
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '  ''이름을 입력해주세요.',
                              style: TextStyle(
                                color: BaseColorCharcoal,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 2),
                            TextFormField(
                              controller: controller_name,
                              decoration: InputDecoration(
                                //labelText: '이름',
                                hintText: 'name',
                                hintStyle: TextStyle(color: BaseColorTaupe),
                                prefixIcon: const Icon(Icons.person_2_outlined),
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

                            ),
                            const SizedBox(height: 16),
                            const Text(
                              '  ''성별을 선택해주세요.',
                              style: TextStyle(
                                color: BaseColorCharcoal,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: RadioListTile<int>(
                                      title: const Text('남성',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      value: 1,
                                      groupValue: selectedGender,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedGender = value;
                                        });
                                      },
                                      contentPadding: EdgeInsets.zero,
                                      dense: true,
                                    ),
                                  ),
                                  Expanded(
                                    child: RadioListTile<int>(
                                      title: const Text('여성',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      value: 2,
                                      groupValue: selectedGender,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedGender = value;
                                        });
                                      },
                                      contentPadding: EdgeInsets.zero,
                                      dense: true,
                                    ),
                                  ),
                                  Expanded(
                                    child: RadioListTile<int>(
                                      title: const Text('선택 안함',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      value: 0,
                                      groupValue: selectedGender,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedGender = value;
                                        });
                                      },
                                      contentPadding: EdgeInsets.zero,
                                      dense: true,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // const SizedBox(height: 16),
                            // // 휴대폰 입력
                            // const Text(
                            //   '  ''휴대폰을 입력해주세요.',
                            //   style: TextStyle(
                            //     color: BaseColorCharcoal,
                            //     fontSize: 14,
                            //   ),
                            // ),
                            // const SizedBox(height: 2),
                            // TextFormField(
                            //   controller: controller_phone,
                            //   decoration: InputDecoration(
                            //     //labelText: '휴대폰',
                            //     hintText: '010-0000-0000',
                            //     hintStyle: TextStyle(color: BaseColorTaupe),
                            //     prefixIcon: const Icon(Icons.phone_android_outlined),
                            //     border: OutlineInputBorder(
                            //       borderRadius: BorderRadius.circular(12),
                            //     ),
                            //     enabledBorder: OutlineInputBorder(
                            //       borderRadius: BorderRadius.circular(12),
                            //       borderSide: BorderSide(color: Colors.grey.shade300),
                            //     ),
                            //     focusedBorder: OutlineInputBorder(
                            //       borderRadius: BorderRadius.circular(12),
                            //       borderSide: const BorderSide(color: BaseColorCharcoal),
                            //     ),
                            //     filled: true,
                            //     fillColor: Colors.white,
                            //   ),
                            //   keyboardType: TextInputType.phone,
                            //   inputFormatters: [
                            //     FilteringTextInputFormatter.digitsOnly,
                            //     HyphenFormatter(),
                            //     ],
                            // ),
                            const SizedBox(height: 16),
                            // 이메일 입력
                            const Text(
                              '  ''이메일을 입력해주세요.',
                              style: TextStyle(
                                color: BaseColorCharcoal,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 2),
                            TextFormField(
                              controller: controller_email,
                              decoration: InputDecoration(
                                //labelText: '이메일',
                                hintText: 'email@donga.ac.kr',
                                hintStyle: TextStyle(color: BaseColorTaupe),
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
                            const SizedBox(height: 20),
                            // 비밀번호 입력
                            const Text(
                              '  ''비밀번호를 입력해주세요.',
                              style: TextStyle(
                                color: BaseColorCharcoal,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 2),
                            TextFormField(
                              controller: controller_password,
                              decoration: InputDecoration(
                                //labelText: '비밀번호',
                                hintText: 'password',
                                hintStyle: TextStyle(color: BaseColorTaupe),
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
                            const SizedBox(height: 5),
                            // 비밀번호 확인
                            TextFormField(
                              controller: controller_pwtest,
                              decoration: InputDecoration(
                                //labelText: '비밀번호 확인',
                                hintText: 'password',
                                hintStyle: TextStyle(color: BaseColorTaupe),
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
                            // 로그인 버튼
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: _register,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: BaseColorCharcoal,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 2,
                                ),
                                child: const Text(
                                  '회원가입',
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
                      // 돌아가기
                      Center(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: '이미 계정이 있으신가요?''  ',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 15,
                                ),
                              ),
                              TextSpan(
                                text: '로그인',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                                recognizer: TapGestureRecognizer()..onTap = _ToLogin,
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

  Future<void> _ToLogin() async {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
  }

  Future<void> _register() async {
    // 입력값 검증
    if (controller_name.text.isEmpty ||
        // controller_phone.text.isEmpty ||
        controller_email.text.isEmpty ||
        controller_password.text.isEmpty ||
        controller_pwtest.text.isEmpty ||
        selectedGender == null) {
      showSnackBar(
        context,
        const Text('모든 항목을 입력해주세요.'),
      );
      return;
    }

    // 비밀번호 일치 검증
    if (controller_password.text != controller_pwtest.text) {
      showSnackBar(
        context,
        const Text('비밀번호가 일치하지 않습니다.'),
      );
      return;
    }

    // 비밀번호 길이 검증
    if (controller_password.text.length < 6) {
      showSnackBar(
        context,
        const Text('비밀번호가 최소 6자 이상 필요합니다.'),
      );
      return;
    }

    // 확인 다이얼로그 표시
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            '회원가입 확인',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('로그인 창으로 이동합니다.'),
              const SizedBox(height: 16),
              // Text('이름: ${controller_name.text}'),
              // Text('휴대폰: ${controller_phone.text}'),
              // Text('이메일: ${controller_email.text}'),
              // Text('성별: $selectedGender'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 다이얼로그 닫기
              },
              child: const Text(
                '취소',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 다이얼로그 닫기
                // 여기에 실제 회원가입 처리 로직 추가
                _processRegistration();
              },
              child: const Text(
                '확인',
                style: TextStyle(
                  color: BaseColorCharcoal,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

// 실제 회원가입 처리를 위한 메서드
  Future<void> _processRegistration() async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: controller_email.text,
        password: controller_password.text,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Successfully registered!')),
      );
      Guest guest = Guest(
          email: controller_email.text,
          gender: selectedGender,
          level: 'Bronze',
          name: controller_name.text,
      );
      await database
          .collection("guests")
          .doc(userCredential.user!.uid)
          .set(guest.toJson());

      // 성공 시 로그인 페이지로 이동
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginPage())
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to register: ${e.message}')),
      );
    }
  }
}

class HyphenFormatter extends TextInputFormatter {
  HyphenFormatter ();

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    if (newValue.text.length > 11) {
      return oldValue;
    }

    final newText = StringBuffer();
    for (int i = 0; i < newValue.text.length; i++) {
      if (i == 3 || i == 7) {
        newText.write('-');
      }
      newText.write(newValue.text[i]);
    }

    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

void showSnackBar(BuildContext context, Text text) {
  final snackBar = SnackBar(
    content: text,
    backgroundColor: Color.fromARGB(255, 112, 48, 48),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}