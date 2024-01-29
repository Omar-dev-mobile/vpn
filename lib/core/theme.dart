import 'package:flutter/material.dart';
class CustomTextTheme extends TextTheme {
  const CustomTextTheme()
      : super(
    displayLarge: const TextStyle(fontSize: 32.0),
    displayMedium: const TextStyle(fontSize: 24.0),
    displaySmall: const TextStyle(fontSize: 10.0),
    headlineLarge: const TextStyle(fontSize: 28.0),
    headlineMedium: const TextStyle(fontSize: 20.0),
    headlineSmall: const TextStyle(fontSize: 16.0),
    titleLarge: const TextStyle(fontSize: 22.0),
    titleMedium: const TextStyle(fontSize: 18.0),
    titleSmall: const TextStyle(fontSize: 14.0),
    bodyLarge: const TextStyle(fontSize: 18.0),
    bodyMedium: const TextStyle(fontSize: 16.0),
    bodySmall: const TextStyle(fontSize: 14.0),
    labelLarge: const TextStyle(fontSize: 16.0),
  );
}
var theme = ThemeData(
    primaryColor: kPrimary,
    textTheme: const CustomTextTheme(),
);

const Color kWhite = Color(0xffFFFFFF);
const Color kBlack = Colors.black;
const Color kBluishGray = Color(0xffC9CAD1);
const Color kGray = Color(0xffAAAAAF);
const Color kPrimary = Color(0xff1392A4);
const Color kShadeOfGray = Color(0xff95A1A1);
const Color kGrayishBlue = Color(0xff222828);
const Color kTeal = Color(0xff1392A4);

class MyThemeData {
  static ThemeData lightTheme() {
    return ThemeData(
      primaryColor: kPrimary,
      brightness: Brightness.light,
      textTheme: const CustomTextTheme(),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      primaryColor: Colors.indigo,
      brightness: Brightness.dark,
      textTheme: const CustomTextTheme(),
    );
  }
}