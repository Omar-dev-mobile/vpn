import 'package:flutter/material.dart';
import 'package:vpn/core/customs/common_text_widget.dart';
import 'package:vpn/core/theme/theme.dart';

import '../../../../core/constants.dart';

class InfoVpnWidget extends StatelessWidget {
  const InfoVpnWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Column(
            children: [
              CommonTextWidget(
                text: '34',
                size: screenUtil.setSp(28),
                color: primaryColor,
              ),
              CommonTextWidget(
                text: 'Device',
                size: screenUtil.setSp(16),
                color: kShadeOfGray,
              ),
            ],
          ),
          const Spacer(),
          Column(
            children: [
              CommonTextWidget(
                text: 'Online',
                size: screenUtil.setSp(35),
                color: primaryColor,
              ),
              CommonTextWidget(
                text: '15:04:00',
                size: screenUtil.setSp(18),
                color: kBlack,
                fontWeight: FontWeight.w400,
              ),
              CommonTextWidget(
                text: '194.58.161.89',
                size: screenUtil.setSp(16),
                color: kShadeOfGray,
              ),
            ],
          ),
          const Spacer(),
          Column(
            children: [
              CommonTextWidget(
                text: '5,5',
                size: screenUtil.setSp(28),
                color: primaryColor,
              ),
              CommonTextWidget(
                text: 'MBps',
                size: screenUtil.setSp(16),
                color: kShadeOfGray,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
