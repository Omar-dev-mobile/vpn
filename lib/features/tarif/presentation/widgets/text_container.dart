import 'package:flutter/material.dart';
import 'package:vpn/core/constants.dart';
import 'package:vpn/core/customs/common_text_widget.dart';
import 'package:vpn/core/theme/theme.dart';

class TextContainer extends StatelessWidget {
  const TextContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenUtil.setHeight(190),
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(20)),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: CommonTextWidget(
            text:
                'The payment will be charged from your iTunes account iTunes confirmation of purchase.',
            textAlign: TextAlign.center,
            size: 15,
            fontWeight: FontWeight.w400,
            color: Theme.of(context).textTheme.titleSmall?.color,
          ),
        ),
      ),
    );
  }
}
