import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vpn/core/theme/assets.dart';
import 'package:vpn/core/theme/theme.dart';

import '../../../../core/constants.dart';


class IconWidget extends StatelessWidget {
  Widget icon;
  IconWidget({required this.icon,super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width:screenUtil.setWidth(40),
      height:screenUtil.setHeight(40),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: kPrimary,
      ),
      child: icon,
    );
  }
}
