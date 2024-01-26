import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    centerTitle: false,
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    shape: CircleBorder(),
    backgroundColor: Colors.white,
    elevation: 0,
  ),
  scaffoldBackgroundColor: const Color(0xffF5F5F5),
  cardTheme: const CardTheme(
    elevation: 0.1,
    margin: EdgeInsets.all(10),
    color: Colors.white,
  ),
  bottomAppBarTheme: const BottomAppBarTheme(
    height: 84,
    color: Colors.white,
    elevation: 20,
    surfaceTintColor: Colors.white,
    shadowColor: Colors.black,
  ),
  primaryTextTheme: const TextTheme(
    titleSmall: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: Colors.black,
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: Colors.black,
      backgroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      side: const BorderSide(
        color: Colors.red,
      ),
    ),
  ),
);
