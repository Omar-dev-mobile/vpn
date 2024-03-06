import 'package:flutter/material.dart';
import 'package:vpn/core/customs/custom_button.dart';
import 'package:vpn/core/theme/theme.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton(
      {required this.name,
      required this.color,
      required this.colorRounded,
      required this.width,
        this.onPressed,
      super.key});
  final Function()? onPressed;
  final String name;
  final Color color;
  final Color colorRounded;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          width: width + 110,
          height: 130,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: colorRounded.withOpacity(0.2))),
        ),
        Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Container(
              width: width + 30,
              height: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: colorRounded.withOpacity(0.5),
                ),
              ),
            ),
            SizedBox(
                width: width,
                child: CustomButton(
                  onPressed: onPressed,
                  title: name,
                  color: color,
                  radius: 20,
                  textColor: kWhite,
                  fontWeight: FontWeight.w400,
                  size: 24,
                )),
          ],
        ),
      ],
    );
  }
}
