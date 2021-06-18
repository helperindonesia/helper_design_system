import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HelperThemeData {
  static ThemeData themeData() {
    return ThemeData(
      fontFamily: GoogleFonts.nunito().fontFamily,
      textTheme: textTheme,
    );
  }

  static final TextTheme textTheme = TextTheme(
    headline1: TextStyle(
        fontSize: 30, fontWeight: FontWeight.bold, letterSpacing: 0.25),
    headline2: TextStyle(
        fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: 0.25),
    headline3: TextStyle(
        fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 0.25),
    subtitle1: TextStyle(
        fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 0.25),
    subtitle2: TextStyle(
        fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 0.25),
    bodyText1: TextStyle(
        fontSize: 14, fontWeight: FontWeight.normal, letterSpacing: 0.15),
    caption: TextStyle(
        fontSize: 12, fontWeight: FontWeight.normal, letterSpacing: 0.4),
    bodyText2: TextStyle(
        fontSize: 10, fontWeight: FontWeight.normal, letterSpacing: 0.4),
    button: TextStyle(
        fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 1.0),
  );
}
