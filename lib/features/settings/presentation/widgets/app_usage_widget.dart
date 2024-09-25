import 'package:flutter/material.dart';
import 'package:vpn/core/constants.dart';
import 'package:vpn/core/customs/common_text_widget.dart';
import 'package:vpn/core/theme/theme.dart';

class AppUsageWidget extends StatelessWidget {
  const AppUsageWidget({
    super.key,
    required this.number,
    required this.text,
  });
  final String number;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            height: 20,
            width: 20,
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: kOrangeColor),
            child: Center(
              child: CommonTextWidget(
                text: number,
                color: kWhite,
                size: screenUtil.setSp(13),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        screenUtil.setHeight(10).ph,
        CommonTextWidget(
          text: text,
          color: kWhite,
          size: screenUtil.setSp(12),
          fontWeight: FontWeight.w400,
          height: 20 / 12,
        ),
      ],
    );
  }
}
