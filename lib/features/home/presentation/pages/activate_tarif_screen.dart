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

  Widget buildDesktop(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: screenHeight,
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
          Expanded(
            // Adjust to use Expanded instead of Spacer to fill available space
            child: Center(
              // Explicitly center the image
              child: Image.asset(
                Assets.notActive,
                width: screenWidth * 0.6, // Make image width responsive
                height: screenHeight * 0.6, // Make image height responsive
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal:
                    screenWidth * 0.05), // Responsive horizontal padding
            child: CommonTextWidget(
              text: title,
              size: screenHeight *
                  0.02, // Responsive font size based on screen height
              color: Theme.of(context).textTheme.displaySmall!.color,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: screenHeight * 0.02), // Responsive spacing
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: CustomButton(
              title: textButton,
              color: kPrimary,
              onPressed: onPressed,
            ),
          ),
          SizedBox(height: screenHeight * 0.03), // Responsive bottom spacing
        ],
      ),
    );
  }

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
