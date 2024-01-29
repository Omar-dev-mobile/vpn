import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vpn/core/constants.dart';

import '../theme.dart';
import 'common_text_widget.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  const BottomNavigationBarWidget({super.key, required this.onTap});

  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    final List<Widget> image = [
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset('assets/icons/RU.svg'),
          5.ph,
          CommonTextWidget(
            text: "Russia",
            size: screenUtil.setSp(12),
            color: kGrayishBlue,
            fontWeight: FontWeight.w500,
          )
        ],
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset('assets/icons/person.svg'),
          5.ph,
           CommonTextWidget(
            text: "Tarif",
            color: kGrayishBlue,
            size: screenUtil.setSp(12),
            fontWeight: FontWeight.w500,
          )
        ],
      ),
    ];
    return AnimatedBottomNavigationBar.builder(
      backgroundGradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment(0, 1),
        colors: [
          Theme.of(context).primaryColor.withOpacity(0.25),
          Theme.of(context).primaryColor.withOpacity(0),
        ],
      ),
      safeAreaValues: const SafeAreaValues(bottom: false),
      itemCount: 2,
      tabBuilder: (int index, bool isActive) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [image[index]],
        );
      },
      // backgroundColor: kWhite,
      activeIndex: 1,
      splashSpeedInMilliseconds: 300,
      notchSmoothness: NotchSmoothness.defaultEdge,
      gapLocation: GapLocation.center,
      onTap: onTap,
      shadow: BoxShadow(
        offset: const Offset(0, 1),
        blurRadius: 12,
        spreadRadius: 0.5,
        color: kGray.withOpacity(0.14),
      ),
    );
  }
}
