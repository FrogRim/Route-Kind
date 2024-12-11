import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:dart_findy/Constant/InApp.dart';
import 'package:dart_findy/Screen/00_Splash/Login.dart';
// import 'package:dart_findy/Screen/01_Search/Search.dart';
// import 'package:dart_findy/Screen/02_Wish/Wish.dart';
import 'package:dart_findy/Screen/02_Wish/provider.dart';
// import 'package:dart_findy/Screen/03_Home/Home.dart';
// import 'package:dart_findy/Screen/04_ChatBot/ChatBot.dart';
// import 'package:dart_findy/Screen/05_Profile/Profile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (_) => WishlistProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Findy App',
      home: FutureBuilder(
        future: _getLoginStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return snapshot.data == true ? InApp() : LoginPage();
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }

  Future<bool> _getLoginStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }
}