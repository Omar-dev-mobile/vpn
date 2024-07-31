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
    return Container(
      height: screenUtil.screenHeight,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(
            Assets.union,
          ),
        ),
      ),
      child: Column(
        children: [
          const AppBarHeader(),
          const Spacer(),
          // screenUtil.setHeight(85).ph,
          ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: 350,
              minWidth: 350,
              maxHeight: 750,
              maxWidth: 750,
            ),
            child: Flexible(
              child: Image.asset(
                Assets.notActive,
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: CommonTextWidget(
              text: title,
              size: screenUtil.setSp(20),
              color: Theme.of(context).textTheme.displaySmall!.color,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w500,
            ),
          ),
          screenUtil.setHeight(20).ph,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: CustomButton(
              title: textButton,
              color: kPrimary,
              onPressed: onPressed,
            ),
          ),
          screenUtil.setHeight(20).ph,
        ],
      ),
    );
  }
}
