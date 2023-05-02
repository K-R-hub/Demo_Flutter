import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import 'colors.dart';

ThemeData lightTheme = ThemeData(
  primaryColor: defaultColor,
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: Colors.white,
  iconTheme: const IconThemeData(color: Colors.black),
  appBarTheme: const AppBarTheme(
    color: Colors.white,
    elevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white, statusBarIconBrightness: Brightness.dark),
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(
      fontFamily: "Jannah",
      fontWeight: FontWeight.bold,
      fontSize: 30,
      color: Colors.black,
    ),
    actionsIconTheme: IconThemeData(
      color: Colors.black,
      size: 30,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedIconTheme: const IconThemeData(
      size: 35,
    ),
    selectedLabelStyle: TextStyle(fontSize: 15),
    selectedItemColor: defaultColor,
    type: BottomNavigationBarType.fixed,
    backgroundColor: Colors.grey[100],
    elevation: 20,
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    subtitle1: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w300,
      color: Colors.black,
    ),

  ),
);

ThemeData darkTheme = ThemeData(
  primaryColor: defaultColor,
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: HexColor('333739'),
  appBarTheme: AppBarTheme(
    color: HexColor('333739'),
    elevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: HexColor('333739'),
      statusBarIconBrightness: Brightness.light,
    ),
    titleTextStyle: const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 30,
      color: Colors.white,
    ),
    actionsIconTheme: const IconThemeData(
      color: Colors.white,
      size: 30,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedIconTheme: const IconThemeData(
      color: defaultColor,
      size: 42,
    ),
    unselectedItemColor: Colors.white,
    selectedLabelStyle: const TextStyle(fontSize: 18),
    selectedItemColor: Colors.deepOrange,
    type: BottomNavigationBarType.fixed,
    backgroundColor: HexColor('333739'),
    elevation: 20,
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    subtitle1: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w300,
      color: Colors.black,
    ),
  ),
);
