import 'package:flutter/material.dart';
import 'package:vpn/core/constants.dart';
import 'package:vpn/core/theme/theme.dart';

import 'common_text_widget.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  final Function()? onPressed;
  final String title;
  final Color color;
  final bool isLoading;
  final Color textColor;
  Color? colorBorderSide;
  final Widget? widget;
  final double size;
  final double radius;
  final FontWeight fontWeight;
  final EdgeInsets padding;

  CustomButton({
    super.key,
    this.onPressed,
    required this.title,
    this.color = kWhite,
    this.isLoading = false,
    this.textColor = kWhite,
    this.colorBorderSide,
    this.padding = const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
    this.widget,
    this.size = 20,
    this.radius = 12,
    this.fontWeight = FontWeight.normal,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          elevation: 0,
          minimumSize: const Size.fromHeight(40),
          backgroundColor: color,
          disabledBackgroundColor: color,
          shape: RoundedRectangleBorder(
              side: colorBorderSide != null
                  ? BorderSide(width: 1, color: colorBorderSide!)
                  : BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(radius))),
          padding: padding,
          textStyle: const TextStyle(fontSize: 24)),
      child: FittedBox(
        child: isLoading
            ? const SizedBox(
                height: 30.0,
                width: 30.0,
                child: CircularProgressIndicator(
                  color: kWhite,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget != null) ...[
                    widget ?? const SizedBox(),
                    10.pw,
                  ],
                  CommonTextWidget(
                    text: title,
                    size: size,
                    color: textColor,
                    fontWeight: fontWeight,
                  )
                ],
              ),
      ),
    );
  }
}
