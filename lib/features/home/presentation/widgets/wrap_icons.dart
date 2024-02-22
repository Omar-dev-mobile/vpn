import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vpn/core/theme/theme.dart';

class WrapIcons extends StatelessWidget {
  const WrapIcons({super.key, required this.icon});
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(23.5),
        color: kWhite,
        boxShadow: [
          BoxShadow(
            color: kBlack.withOpacity(0.1),
            offset: const Offset(0, 4),
            blurRadius: 21.5,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SvgPicture.asset(icon),
      ),
    );
  }
}
