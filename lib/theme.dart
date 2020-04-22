import 'package:flutter/material.dart';
import 'package:iconnect/utils/colors.dart';
import 'package:iconnect/utils/utils.dart';

ThemeData buildThemeData() {
  final baseTheme = ThemeData(fontFamily: AvailableFonts.primaryFont);

  // return baseTheme.copyWith();
  return baseTheme.copyWith(
    bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.transparent),
    brightness: Brightness.light,
    textTheme: TextTheme(
      title: TextStyle(color: Colors.black),
      button: TextStyle(color: Colors.white),
      body1: TextStyle(
        color: Colors.black,
        fontSize: 16,
      ),
      body2: TextStyle(
          color: Colors.black, fontSize: 15, fontWeight: FontWeight.w400),
      subtitle: TextStyle(color: secondaryTitle),
    ),
    primaryColor: primaryColor,
    scaffoldBackgroundColor: Colors.white, //scaffoldBackgroundColor,
    accentColor: secondaryColor,
  );
}
