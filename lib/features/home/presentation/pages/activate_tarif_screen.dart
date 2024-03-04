import 'package:flutter/material.dart';
import 'package:vpn/core/constants.dart';
import 'package:vpn/core/customs/common_text_widget.dart';
import 'package:vpn/core/customs/custom_button.dart';
import 'package:vpn/core/theme/assets.dart';
import 'package:vpn/core/theme/theme.dart';
import 'package:vpn/core/customs/app_bar_header.dart';

class ActivateTarifScreen extends StatelessWidget {
  const ActivateTarifScreen(
      {super.key,
      required this.title,
      required this.textButton,
      required this.onPressed});
  final String title;
  final String textButton;
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          Assets.notActive,
          height: 250,
        ),
        Image.asset(Assets.union),
        const Align(alignment: Alignment.topCenter, child: AppBarHeader()),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CommonTextWidget(
                    text: title,
                    size: screenUtil.setSp(20),
                    color: Theme.of(context).textTheme.displaySmall!.color,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w500),
                screenUtil.setHeight(50).ph,
                CustomButton(
                  title: textButton,
                  color: kPrimary,
                  onPressed: onPressed,
                ),
                screenUtil.setHeight(10).ph,
              ],
            ),
          ),
        ),
      ],
    );
  }
}
