import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vpn/core/constants.dart';
import 'package:vpn/core/customs/common_text_widget.dart';
import 'package:vpn/core/theme/theme.dart';

class ProfileContainer extends StatelessWidget {
  final Widget icon;
  final String title;
  final String text;
  final IconData? trailingIcon;
  final double textSize;

  const ProfileContainer({
    super.key,
    required this.icon,
    required this.title,
    required this.text,
    this.trailingIcon,
    required this.textSize,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        height: screenUtil.setHeight(210),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (trailingIcon != null)
              Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      trailingIcon,
                      color: kShadeOfGray,
                    ),
                    onPressed: () {
                      Clipboard.setData(
                        ClipboardData(text: text),
                      );
                    },
                  )),
            trailingIcon != null ? 0.ph : 30.ph,
            const Spacer(),
            Center(
              child: Column(
                children: [
                  icon,
                  10.ph,
                  CommonTextWidget(
                    text: text,
                    size: textSize,
                    color: Theme.of(context).textTheme.labelLarge?.color,
                    fontWeight: FontWeight.w500,
                  ),
                  5.ph,
                  CommonTextWidget(
                    text: title,
                    size: 15,
                    color: kShadeOfGray,
                    fontWeight: FontWeight.w400,
                  )
                ],
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
