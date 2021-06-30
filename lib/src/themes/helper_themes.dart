import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HelperThemeData {
  static ThemeData themeData() {
    return ThemeData(
      fontFamily: GoogleFonts.nunito().fontFamily,
      textTheme: textTheme,
    );
  }

  static final HTextTheme textTheme = HTextTheme(
    headline1: TextStyle(
        fontSize: 30, fontWeight: FontWeight.bold, letterSpacing: -1.6),
    headline2: TextStyle(
        fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: -1.6),
    headline3: TextStyle(
        fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: -1.6),
    headline4: TextStyle(
        fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: -1.6),
    headline5: TextStyle(
        fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: -1.6),
    buttonText1: TextStyle(
        fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 0.1),
    buttonText2: TextStyle(
        fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 0.1),
    bodyText1: TextStyle(
        fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 0.1),
    bodyText2: TextStyle(
        fontSize: 16, fontWeight: FontWeight.normal, letterSpacing: 0.1),
    bodyText3: TextStyle(
        fontSize: 14, fontWeight: FontWeight.normal, letterSpacing: 0.1),
    caption: TextStyle(
        fontSize: 12, fontWeight: FontWeight.normal, letterSpacing: -0.4),
    overline: TextStyle(
        fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 0.4),
  );
}

@immutable
class HTextTheme extends TextTheme {
  final TextStyle? bodyText3;

  const HTextTheme({
    TextStyle? headline1,
    TextStyle? headline2,
    TextStyle? headline3,
    TextStyle? headline4,
    TextStyle? headline5,
    TextStyle? buttonText1,
    TextStyle? buttonText2,
    TextStyle? bodyText1,
    TextStyle? bodyText2,
    this.bodyText3,
    TextStyle? caption,
    TextStyle? overline,
  }) : super(
          headline1: headline1,
          headline2: headline2,
          headline3: headline3,
          headline4: headline4,
          headline5: headline5,
          subtitle1: buttonText1,
          subtitle2: buttonText2,
          bodyText1: bodyText1,
          bodyText2: bodyText2,
          caption: caption,
          overline: overline,
        );
}
