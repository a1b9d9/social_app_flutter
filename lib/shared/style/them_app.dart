import 'package:flutter/material.dart';

import 'colors.dart';

ThemeData light = ThemeData(
  fontFamily: "Jannah",
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: defaultColorBackGround,
  appBarTheme: AppBarTheme(
      backgroundColor: defaultColorBackGround,
      elevation: 0,
      titleTextStyle: const TextStyle(
          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
      iconTheme: IconThemeData(color: defaultColor, size: 27)),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      unselectedIconTheme: const IconThemeData(size: 20),
      elevation: 20,
      selectedItemColor: defaultColor,
      unselectedItemColor: Colors.grey[500],
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.grey[100]),
  textTheme: const TextTheme(subtitle1:TextStyle(fontSize: 14,fontWeight: FontWeight.w700,height: 1.5,color: Colors.black)),
);
