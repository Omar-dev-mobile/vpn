import 'package:flutter/material.dart';

const Color kWhite = Color(0xffFFFFFF);
const Color kBlack = Colors.black;
const Color kBluishGray = Color(0xffC9CAD1);
const Color kGray = Color(0xffAAAAAF);
const Color kPrimary = Color(0xff1392A4);
const Color kShadeOfGray = Color(0xff95A1A1);
const Color kSlateGray = Color(0xff737373);

const Color kYellowColor = Color(0xFFFFD964);
const Color kDarkBluishGrayColor = Color(0xFF222828);
const Color kLightCyanColor = Color(0xFFA5F4FF);
const Color kVibrantCyanColor = Color(0xFF00E0FF);
const Color kDarkTealColor = Color(0xFF006072);
const Color kDeepPurpleColor = Color(0xFF7513A4);
const Color kOrangeColor = Color(0xFFF5990F);
const Color kGreenColor = Color(0xFF10BD6A);
const Color kAnotherOrangeColor = Color(0xFFF5990F);
const Color kDarkGrayColor = Color(0xFF252525);
const Color kBlueGray = Color(0xFF7D8696);
const Color kLightGray = Color(0xFFF6F6F6);
const Color kShadeBlueGray = Color(0xFF7D8797);

const Color kTransparent = Colors.transparent;

List<List<Color>> gradient = [
  [kDarkTealColor, kDarkTealColor],
  [kDeepPurpleColor, kDarkTealColor],
  [kDeepPurpleColor, kOrangeColor],
];

class MyThemeData {
  static ThemeData lightTheme() {
    return ThemeData(
      fontFamily: 'Saira',
      primaryColor: kPrimary,
      brightness: Brightness.light,
      textTheme: const CustomTextThemeLight(),
      disabledColor: kDarkBluishGrayColor,
      indicatorColor: kYellowColor,
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      fontFamily: 'Saira',
      primaryColor: Colors.indigo,
      brightness: Brightness.dark,
      textTheme: const CustomTextThemeDark(),
    );
  }
}

class CustomTextThemeLight extends TextTheme {
  const CustomTextThemeLight()
      : super(
          displayLarge: const TextStyle(fontSize: 35, color: kPrimary),
          displayMedium: const TextStyle(fontSize: 25, color: kWhite),
          displaySmall: const TextStyle(fontSize: 14),
          headlineLarge: const TextStyle(fontSize: 30, color: kWhite),
          headlineMedium: const TextStyle(fontSize: 20),
          headlineSmall: const TextStyle(fontSize: 10),
          titleLarge: const TextStyle(fontSize: 28),
          titleMedium: const TextStyle(fontSize: 18),
          titleSmall: const TextStyle(fontSize: 8),
          bodyLarge: const TextStyle(fontSize: 35, color: kDarkBluishGrayColor),
          bodyMedium: const TextStyle(fontSize: 16, color: kDarkGrayColor),
          bodySmall: const TextStyle(fontSize: 15, color: kBlack),
          labelLarge: const TextStyle(fontSize: 12, color: kWhite),
          labelMedium: const TextStyle(fontSize: 17),
          labelSmall: const TextStyle(fontSize: 5),
        );
}

class CustomTextThemeDark extends TextTheme {
  const CustomTextThemeDark()
      : super(
          displayLarge: const TextStyle(fontSize: 35, color: kPrimary),
          displayMedium: const TextStyle(fontSize: 25, color: kSlateGray),
          displaySmall: const TextStyle(fontSize: 14),
          headlineLarge: const TextStyle(fontSize: 30),
          headlineMedium: const TextStyle(fontSize: 20),
          headlineSmall: const TextStyle(fontSize: 10),
          titleLarge: const TextStyle(fontSize: 28),
          titleMedium: const TextStyle(fontSize: 18),
          titleSmall: const TextStyle(fontSize: 8),
          bodySmall: const TextStyle(fontSize: 15, color: kBlack),
          labelLarge: const TextStyle(fontSize: 11),
          labelMedium: const TextStyle(fontSize: 17),
          labelSmall: const TextStyle(fontSize: 5),
        );
}