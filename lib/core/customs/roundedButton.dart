import 'package:flutter/material.dart';
import 'package:vpn/core/customs/custom_button.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton(
      {required this.name,
      required this.color,
      required this.width,
      super.key});
  final String name;
  final Color color;
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
              border: Border.all(color: color.withOpacity(0.2))),
        ),
        Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Container(
              width: width + 50,
              height: 90,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: color.withOpacity(0.5))),
            ),
            SizedBox(
                width: width,
                child: CustomButton(
                  title: name,
                  color: color,
                  radius: 20,
                  fontWeight: FontWeight.w400,
                  size: 24,
                )),
          ],
        ),
      ],
    );
  }
}
