import 'package:flutter/material.dart';
import 'package:vpn/core/constants.dart';
import 'package:vpn/core/customs/common_text_widget.dart';
import 'package:vpn/core/customs/custom_button.dart';
import 'package:vpn/core/theme/theme.dart';

class CustomError extends StatelessWidget {
  const CustomError(
      {super.key, required this.error, this.onPressed, this.isLoading = false});
  final String error;
  final VoidCallback? onPressed;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // const AppBarHeader(),
        const Spacer(),
        SizedBox(
          width: screenUtil.screenWidth * 0.7,
          child: CommonTextWidget(
            text: error,
            size: 18,
            color: Theme.of(context).textTheme.displaySmall!.color,
            textAlign: TextAlign.center,
          ),
        ),
        const Spacer(),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: screenUtil.screenWidth * 0.07),
          child: CustomButton(
            title: 'Repeat',
            onPressed: onPressed,
            color: kPrimary,
            isLoading: isLoading,
          ),
        ),
        (screenUtil.screenHeight * 0.1).ph,
      ],
    );
  }
}
