import 'package:flutter/material.dart';
import 'package:vpn/core/constants.dart';
import 'package:vpn/core/customs/common_text_widget.dart';

class NavBarWidget extends StatelessWidget {
  const NavBarWidget(
      {super.key,
      required this.title,
      required this.icons,
      required this.onTap});
  final String title;
  final Widget icons;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme.labelLarge;
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icons,
          5.ph,
          CommonTextWidget(
            text: title,
            size: screenUtil.setSp(12),
            color: theme!.color,
            fontWeight: FontWeight.w500,
          )
        ],
      ),
    );
  }
}
