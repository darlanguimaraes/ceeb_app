import 'package:flutter/material.dart';

class UiConfig {
  UiConfig._();

  static String get title => 'CEEB';

  static ThemeData get theme => ThemeData(
        primaryColor: const Color(0xff33A2FF),
        primaryColorDark: const Color(0xff689F38),
        primaryColorLight: const Color(0xffDDE9C7),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xff96CFFE),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xff33A2FF),
          iconSize: 40,
          elevation: 10,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff33A2FF),
            foregroundColor: Colors.white,
            elevation: 10,
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            foregroundColor: const Color(0xff33A2FF),
          ),
        ),
      );
}
