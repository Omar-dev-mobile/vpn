import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vpn/core/constants.dart';
import 'package:vpn/core/customs/common_text_widget.dart';
import 'package:vpn/core/theme/theme.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget(
      {super.key,
      required this.title,
      required this.text,
      required this.asset});
  final String title;
  final String text;
  final String asset;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonTextWidget(
          text: title,
          fontWeight: FontWeight.w500,
          color: Theme.of(context).textTheme.bodyLarge!.color,
        ),
        10.ph,
        Container(
          decoration: BoxDecoration(
            color: kDarkGreen,
            borderRadius: BorderRadius.circular(7),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  SvgPicture.asset(
                    asset,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 20, right: 30),
                    child: VerticalDivider(
                      width: 10,
                      thickness: 2,
                      color: kWhite,
                    ),
                  ),
                  CommonTextWidget(
                    text: text,
                    color: kWhite,
                    fontWeight: FontWeight.w500,
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
