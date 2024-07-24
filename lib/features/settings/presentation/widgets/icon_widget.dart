import 'package:flutter/material.dart';
import 'package:vpn/core/theme/theme.dart';

class IconWidget extends StatelessWidget {
  final Widget icon;
  final Function()? onTap;
  const IconWidget({required this.icon, super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: kPrimary,
        ),
        child: icon,
      ),
    );
  }
}
