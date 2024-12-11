// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';

// for Color
const Color BaseColorWhite = Color(0xffffffff);
const Color BaseColorPale = Color(0xfff8f8f8);
const Color BaseColorRose = Color(0xffbfacb5);
const Color BaseColorTaupe = Color(0xff7f7b82);
const Color BaseColorCharcoal = Color(0xff444554);
const Color BaseColorEerie = Color(0xff172121);


// for Font
const TextStyle FontTap = TextStyle(fontSize: 25, fontWeight: FontWeight.bold);
const TextStyle FontCategory = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
const TextStyle FontProductName = TextStyle(fontSize: 22, fontWeight: FontWeight.bold);
const TextStyle FontProductDetail = TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: BaseColorTaupe);

// for App
class AppStyle {
  static const backgroundColor = BaseColorPale;
}

class AppBarStyle {
  static const backgroundColor = BaseColorCharcoal;
  static const titleTextStyle = TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold);
  static const elevation = 8.0;
}

class BottomNavStyle {
  static const backgroundColor = BaseColorCharcoal;
  static const selectedItemColor = BaseColorWhite;
  static const unselectedItemColor = BaseColorWhite;
  static const type = BottomNavigationBarType.fixed;
  static const borderRadius = 16.0;
  static const elevation = 4.0;
}

// for ChatBot
class Style {
  static const paddingAll12 = EdgeInsets.all(12);
  static const paddingAll8 = EdgeInsets.all(8);
  static const marginAll12 = EdgeInsets.all(12);
  static const messageMargin = EdgeInsets.symmetric(vertical: 4, horizontal: 8);

  static final chatContainerDecoration = BoxDecoration(
    color: Colors.grey[200],
    borderRadius: BorderRadius.circular(16),
  );

  static final userResponseContainerDecoration = BoxDecoration(
    color: Colors.blueAccent.withOpacity(0.1),
    borderRadius: BorderRadius.circular(16),
  );

  static const boldBlueTextStyle = TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.blueAccent,
  );

  static final ThemeData appTheme = ThemeData(
      primarySwatch: Colors.blue,
      scaffoldBackgroundColor: Colors.grey[200],
      textTheme: TextTheme(
        bodyMedium: TextStyle(color: Colors.black),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueAccent,
        ),
      ),
      appBarTheme: AppBarTheme(
          backgroundColor: Color(0xfffF7F6F2),
          scrolledUnderElevation: 0.0
      )
  );
}