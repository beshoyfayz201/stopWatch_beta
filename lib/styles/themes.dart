import 'package:flutter/material.dart';

class AppStyles{
 static  ThemeData dark = ThemeData.dark().copyWith(
    appBarTheme: AppBarTheme(backgroundColor: Colors.black),
    primaryColor: Colors.black,
    scaffoldBackgroundColor: Colors.grey.shade900);

static ThemeData light = ThemeData.light().copyWith(
  appBarTheme: AppBarTheme(backgroundColor: Color(0xff944f64)),
);

}