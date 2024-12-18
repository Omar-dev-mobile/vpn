import 'package:flutter/material.dart';
import 'package:vpn/core/constants.dart';

const Color kWhite = Color(0xffFFFFFF);
const Color kBlack = Colors.black;
const Color kBGDark = Color(0xff1D1D1D);
const Color kBGLight = Color(0xffF2F5F5);
const Color kBluishGray = Color(0xffC9CAD1);
const Color kGray = Color(0xffAAAAAF);
const Color kPrimary = Color(0xff1392A4);
const Color kShadeOfGray = Color(0xff95A1A1);
const Color kSlateGray = Color(0xff737373);

const Color kYellowColor = Color(0xFFFFD964);
const Color kDarkBluishGray = Color(0xFF222828);
const Color kLightCyanColor = Color(0xFFA5F4FF);
const Color kVibrantCyanColor = Color(0xFF00E0FF);
const Color kDarkTealColor = Color(0xFF006072);
const Color kLightTealColor = Color(0xFF20899B);
const Color kDeepPurpleColor = Color(0xFF7513A4);
const Color kOrangeColor = Color(0xFFF5990F);
const Color kGreenColor = Color(0xFF10BD6A);
const Color kAnotherOrangeColor = Color(0xFFF5990F);
const Color kDarkGrayColor = Color(0xFF252525);
const Color kBlueGray = Color(0xFF7D8696);
const Color kLightGray = Color(0xFFF6F6F6);
const Color kShadeBlueGray = Color(0xFF7D8797);
const Color kTransparent = Colors.transparent;
const Color kBackGround = Color(0xffECF1F1);
const Color kSendButton = Color(0xff1392A4);
const Color kStarIconOff = Color(0xffE0E0E0);
const Color kStarIconOn = Color(0xffF2994A);
const Color kFlagDivider = Color(0xffEAEAEA);
const Color kSilver = Color(0xffE5E5E5);
const Color kCharcoal = Color(0xff313131);
const Color lightGray = Color(0xffD9D9D9);
const Color kDarkRed = Color(0xffFFCDCD);

const Color kDarkGreen = Color(0xff006A7C);
const Color kGreyA4AAAA = Color(0xffA4AAAA);

Map<String, List<Color>> gradient = {
  kProductIds[0]: [kDarkTealColor, kDarkTealColor],
  kProductIds[1]: [kDeepPurpleColor, kDarkTealColor],
  kProductIds[2]: [kDeepPurpleColor, kOrangeColor],
  // kProductIds[2]: [kDeepPurpleColor, kStarIconOn],
}; //[kDarkTealColor, kDarkTealColor]

class MyThemeData {
  static ThemeData lightTheme() {
    return ThemeData(
        fontFamily: 'Saira',
        primaryColor: kPrimary,
        primaryColorLight: kBGLight,
        brightness: Brightness.light,
        textTheme: const CustomTextThemeLight(),
        disabledColor: kDarkBluishGray,
        indicatorColor: kYellowColor,
        scaffoldBackgroundColor: kBGLight,
        cardColor: kWhite,
        canvasColor: kWhite,
        dividerColor: lightGray);
  }

  static ThemeData darkTheme() {
    return ThemeData(
      fontFamily: 'Saira',
      primaryColor: kPrimary,
      primaryColorLight: kBGDark,
      brightness: Brightness.dark,
      textTheme: const CustomTextThemeDark(),
      scaffoldBackgroundColor: kBGDark,
      indicatorColor: kYellowColor,
      cardColor: kCharcoal,
      canvasColor: kBGDark,
      dividerColor: kCharcoal,
    );
  }
}

class CustomTextThemeLight extends TextTheme {
  const CustomTextThemeLight()
      : super(
          displayLarge: const TextStyle(fontSize: 35, color: kPrimary),
          displayMedium: const TextStyle(fontSize: 25, color: kBlack),
          displaySmall: const TextStyle(fontSize: 12, color: kShadeOfGray),
          headlineLarge: const TextStyle(
            fontSize: 30,
            color: kWhite,
          ),
          headlineMedium: const TextStyle(fontSize: 20, color: kDarkBluishGray),
          headlineSmall: const TextStyle(
            fontSize: 10,
            color: kDarkGrayColor,
          ),
          titleLarge: const TextStyle(fontSize: 28, color: kDarkGrayColor),
          titleMedium: const TextStyle(fontSize: 18, color: kBlack),
          titleSmall: const TextStyle(fontSize: 8, color: kShadeOfGray),
          bodyLarge: const TextStyle(fontSize: 35, color: kDarkBluishGray),
          bodyMedium: const TextStyle(fontSize: 16, color: kDarkGrayColor),
          bodySmall: const TextStyle(fontSize: 15, color: kBlack),
          labelLarge: const TextStyle(fontSize: 12, color: kDarkBluishGray),
          labelMedium: const TextStyle(fontSize: 17, color: kDarkGrayColor),
          labelSmall: const TextStyle(fontSize: 5, color: kDarkTealColor),
        );
}

class CustomTextThemeDark extends TextTheme {
  const CustomTextThemeDark()
      : super(
          displayLarge: const TextStyle(fontSize: 35, color: kPrimary),
          displayMedium: const TextStyle(fontSize: 25, color: kSlateGray),
          displaySmall: const TextStyle(fontSize: 12, color: kSilver),
          headlineLarge: const TextStyle(
            fontSize: 30,
          ),
          headlineMedium: const TextStyle(fontSize: 20, color: kSilver),
          headlineSmall: const TextStyle(fontSize: 10, color: kSilver),
          titleLarge: const TextStyle(fontSize: 28, color: kShadeOfGray),
          titleMedium: const TextStyle(fontSize: 18, color: kWhite),
          titleSmall: const TextStyle(fontSize: 8, color: kWhite),
          bodyLarge: const TextStyle(fontSize: 35, color: kWhite),
          bodySmall: const TextStyle(fontSize: 15, color: kBlack),
          bodyMedium: const TextStyle(fontSize: 11, color: kWhite),
          labelLarge: const TextStyle(fontSize: 11, color: kWhite),
          labelMedium: const TextStyle(fontSize: 17, color: kPrimary),
          labelSmall: const TextStyle(fontSize: 5, color: kSilver),
        );
}
