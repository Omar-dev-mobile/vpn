import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
    // Determine screen width for responsiveness
    double screenWidth = MediaQuery.of(context).size.width;
    double paddingHorizontal =
        screenWidth > 600 ? 30 : 20; // Adjust padding for desktop
    double fontSize =
        screenWidth > 600 ? 22 : 18; // Adjust font size for desktop

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonTextWidget(
            text: title,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).textTheme.bodyLarge!.color,
            size: screenWidth > 600
                ? 20
                : 16, // Adjust title font size for desktop
          ),
          SizedBox(
              height: screenWidth > 600 ? 20 : 10), // Adjust vertical spacing
          Container(
            decoration: BoxDecoration(
              color: kDarkGreen,
              borderRadius: BorderRadius.circular(7),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: paddingHorizontal,
                  vertical: screenWidth > 600 ? 20 : 15),
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    SvgPicture.asset(
                      asset,
                      width: screenWidth > 600
                          ? 60
                          : 40, // Adjust SVG size for desktop
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 20, right: 30),
                      child: VerticalDivider(
                        width: 10,
                        thickness: 2,
                        color: kWhite,
                      ),
                    ),
                    Expanded(
                      // Make text expandable to fit remaining space
                      child: CommonTextWidget(
                        text: text,
                        color: kWhite,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w500,
                        size: fontSize, // Use adjusted font size
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
