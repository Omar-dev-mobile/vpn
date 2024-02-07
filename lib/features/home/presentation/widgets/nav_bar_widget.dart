import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vpn/core/constants.dart';
import 'package:vpn/core/customs/common_text_widget.dart';
import 'package:vpn/core/theme/theme.dart';

class NavBarWidget extends StatelessWidget {
  const NavBarWidget(
      {super.key,
      required this.title,
      required this.icons,
      required this.onTap});
  final String title;
  final String icons;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(icons),
          5.ph,
          CommonTextWidget(
            text: title,
            size: screenUtil.setSp(12),
            color: kDarkBluishGrayColor,
            fontWeight: FontWeight.w500,
          )
        ],
      ),
    );
  }
}
