import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
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
    return OrientationLayoutBuilder(
      portrait: (context) => buildDesktop(context),
      landscape: (context) => buildMobile(context),
      mode: OrientationLayoutBuilderMode.portrait,
    );
  }

  Widget buildDesktop(BuildContext context) => Container(
        height: MediaQuery.of(context).size.height,
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AppBarHeader(),
            const Spacer(),
            Image.asset(
              Assets.notActive,
              width: 350,
              height: 350,
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
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: CustomButton(
                title: textButton,
                color: kPrimary,
                onPressed: onPressed,
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      );

  Widget buildMobile(BuildContext context) => Container(
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
            screenUtil.setHeight(85).ph,
            Image.asset(
              Assets.notActive,
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
            screenUtil.setHeight(30).ph,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: CustomButton(
                title: textButton,
                color: kPrimary,
                onPressed: onPressed,
              ),
            ),
            screenUtil.setHeight(30).ph,
          ],
        ),
      );
}
