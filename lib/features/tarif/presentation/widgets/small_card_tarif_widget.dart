import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:vpn/core/constants.dart';
import 'package:vpn/core/customs/common_text_widget.dart';
import 'package:vpn/core/theme/theme.dart';

class SmallCardTarifWidget extends StatelessWidget {
  const SmallCardTarifWidget({
    super.key,
    required this.prise,
    required this.plan,
    required this.tarifDays,
    required this.day,
    this.percent,
    this.productId = "",
    required this.index,
  });
  final String prise;
  final String plan;
  final String tarifDays;
  final String day;
  final String productId;
  final double? percent;

  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 25),
      decoration: ShapeDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: const Alignment(0, 2),
          colors: percent == null
              ? gradient['org.cnddrm.vplineapp.pay.sub.week']!
              : (gradient[productId] ??
                  gradient['org.cnddrm.vplineapp.pay.sub.week']!),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CommonTextWidget(
                text: '${prise} USD',
                color: kWhite.withOpacity(0.7),
                size: screenUtil.setSp(30),
                fontWeight: FontWeight.w300,
              ),
              Spacer(),
              CommonTextWidget(
                text: day,
                color: kWhite.withOpacity(0.7),
                fontFamily: 'Roboto',
                size: screenUtil.setSp(17),
                fontWeight: FontWeight.w300,
              ),
            ],
          ),
          if (percent != null) ...[
            const SizedBox(height: 10),
            LinearPercentIndicator(
              lineHeight: 10.0,
              barRadius: const Radius.circular(20),
              // percent: percent!
              percent: percent!,
              padding: const EdgeInsets.symmetric(horizontal: 0),
              backgroundColor: Theme.of(context).primaryColorLight,
              progressColor: Theme.of(context).indicatorColor,
            ),
          ],
          if (percent == null) ...[
            const SizedBox(height: 10),
            LinearPercentIndicator(
              lineHeight: 10.0,
              barRadius: const Radius.circular(20),
              // percent: percent!
              percent: 1,
              padding: const EdgeInsets.symmetric(horizontal: 0),
              backgroundColor: Theme.of(context).primaryColorLight,
              progressColor: kSendButton,
            ),
          ],
        ],
      ),
    );
  }
}
