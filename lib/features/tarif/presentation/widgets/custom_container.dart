import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vpn/core/constants.dart';
import 'package:vpn/core/customs/common_text_widget.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({super.key, required this.icon, required this.text});

  final String icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).cardColor,
      ),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          SvgPicture.asset(icon),
          10.pw,
          CommonTextWidget(
            text: text,
            size: 13,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).textTheme.headlineMedium?.color,
          ),
        ],
      ),
    );
  }
}
