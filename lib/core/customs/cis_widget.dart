import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CisWidget extends StatelessWidget {
  const CisWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: SizedBox(
        width: 33,
        height: 28,
        child: SvgPicture.asset(
          'assets/icons/CIS.svg',
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
