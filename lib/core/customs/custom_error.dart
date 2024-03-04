import 'package:flutter/material.dart';
import 'package:vpn/core/customs/app_bar_header.dart';
import 'package:vpn/core/customs/common_text_widget.dart';

class CustomError extends StatelessWidget {
  const CustomError({super.key, required this.error});
  final String error;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const AppBarHeader(),
        const Spacer(),
        CommonTextWidget(
          text: error,
          size: 18,
          color: Theme.of(context).textTheme.displaySmall!.color,
          textAlign: TextAlign.center,
        ),
        const Spacer(),
      ],
    );
  }
}
