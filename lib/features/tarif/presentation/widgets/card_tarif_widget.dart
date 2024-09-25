import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:vpn/core/constants.dart';
import 'package:vpn/core/customs/common_text_widget.dart';
import 'package:vpn/core/theme/assets.dart';
import 'package:vpn/core/theme/theme.dart';
import 'package:vpn/translations/locate_keys.g.dart';

class CardTarifWidget extends StatelessWidget {
  const CardTarifWidget({
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
    print(productId);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      decoration: ShapeDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: const Alignment(0, 2),
          colors: (gradient[productId] ??
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(Assets.tarifLogo),
              10.pw,
              CommonTextWidget(
                text: '\$$prise',
                color: kWhite.withOpacity(0.7),
                size: screenUtil.setSp(30),
                fontWeight: FontWeight.w300,
              ),
            ],
          ),
          const Spacer(),
          if (percent != null)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  CommonTextWidget(
                    text: tarifDays,
                    color: kWhite.withOpacity(0.7),
                    size: 25,
                    fontWeight: FontWeight.w300,
                  ),
                  const Spacer(),
                  CommonTextWidget(
                    text: day,
                    color: kSilver,
                    size: screenUtil.setSp(12),
                    fontWeight: FontWeight.w300,
                  ),
                ],
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.only(top: 22),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonTextWidget(
                        text: plan,
                        fontFamily: 'Roboto',
                        color: kWhite.withOpacity(0.7),
                        size: 25,
                        fontWeight: FontWeight.w300,
                      ),
                      CommonTextWidget(
                        text: day,
                        color: kWhite.withOpacity(0.7),
                        fontFamily: 'Roboto',
                        size: screenUtil.setSp(17),
                        fontWeight: FontWeight.w300,
                      ),
                    ],
                  ),
                  const Spacer(),
                  CommonTextWidget(
                    text: LocaleKeys.startSubscription.tr(),
                    fontFamily: 'Roboto',
                    color: kSilver,
                    size: screenUtil.setSp(17),
                    fontWeight: FontWeight.w300,
                  ),
                ],
              ),
            ),
          if (percent != null) ...[
            const SizedBox(height: 10),
            LinearPercentIndicator(
              lineHeight: 14.0,
              barRadius: const Radius.circular(20),
              percent: percent!,
              padding: const EdgeInsets.symmetric(horizontal: 0),
              backgroundColor: Theme.of(context).primaryColorLight,
              progressColor: Theme.of(context).indicatorColor,
            ),
          ],
        ],
      ),
    );
  }

  Widget buildDesktop(BuildContext context) => Container(
        height: screenUtil.setHeight(210),
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        decoration: ShapeDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: const Alignment(0.1, 1.4),
            colors: index == 0
                ? [kDarkTealColor, kDarkTealColor]
                : (gradient[productId] ?? gradient[kProductIds[0]]!),
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(Assets.tarifLogo),
                10.pw,
                CommonTextWidget(
                  text: '\$$prise',
                  color: kWhite.withOpacity(0.7),
                  size: 40,
                  fontWeight: FontWeight.w300,
                ),
              ],
            ),
            if (percent != null)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    CommonTextWidget(
                      text: tarifDays,
                      color: kWhite.withOpacity(0.7),
                      size: 35,
                      fontWeight: FontWeight.w300,
                    ),
                    const Spacer(),
                    CommonTextWidget(
                      text: day,
                      color: kSilver,
                      size: 20,
                      fontWeight: FontWeight.w300,
                    ),
                  ],
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonTextWidget(
                          text: plan,
                          fontFamily: 'Roboto',
                          color: kWhite.withOpacity(0.7),
                          size: 35,
                          fontWeight: FontWeight.w300,
                        ),
                        CommonTextWidget(
                          text: day,
                          color: kWhite.withOpacity(0.7),
                          fontFamily: 'Roboto',
                          size: 20,
                          fontWeight: FontWeight.w300,
                        ),
                      ],
                    ),
                    const Spacer(),
                    CommonTextWidget(
                      text: LocaleKeys.buy.tr(),
                      fontFamily: 'Roboto',
                      color: kSilver,
                      size: screenUtil.setSp(12),
                      fontWeight: FontWeight.w300,
                    ),
                  ],
                ),
              ),
            if (percent != null) ...[
              const SizedBox(height: 10),
              LinearPercentIndicator(
                lineHeight: 14.0,
                barRadius: const Radius.circular(20),
                percent: percent!,
                padding: const EdgeInsets.symmetric(horizontal: 0),
                backgroundColor: Theme.of(context).primaryColorLight,
                progressColor: Theme.of(context).indicatorColor,
              ),
            ]
          ],
        ),
      );

  Widget buildMobile(BuildContext context) => Container(
        height: screenUtil.setHeight(160),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        decoration: ShapeDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: const Alignment(0.1, 1.4),
            colors: index == 0
                ? [kDarkTealColor, kDarkTealColor]
                : (gradient[productId] ?? gradient['7']!),
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(Assets.tarifLogo),
                10.pw,
                CommonTextWidget(
                  text: '\$$prise',
                  color: kWhite.withOpacity(0.7),
                  size: screenUtil.setSp(30),
                  fontWeight: FontWeight.w300,
                ),
              ],
            ),
            if (percent != null)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    CommonTextWidget(
                      text: tarifDays,
                      color: kWhite.withOpacity(0.7),
                      size: screenUtil.setSp(25),
                      fontWeight: FontWeight.w300,
                    ),
                    const Spacer(),
                    CommonTextWidget(
                      text: day,
                      color: kSilver,
                      size: screenUtil.setSp(12),
                      fontWeight: FontWeight.w300,
                    ),
                  ],
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.only(top: 22),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonTextWidget(
                          text: plan,
                          fontFamily: 'Roboto',
                          color: kWhite.withOpacity(0.7),
                          size: screenUtil.setSp(25),
                          fontWeight: FontWeight.w300,
                        ),
                        CommonTextWidget(
                          text: day,
                          color: kWhite.withOpacity(0.7),
                          fontFamily: 'Roboto',
                          size: screenUtil.setSp(17),
                          fontWeight: FontWeight.w300,
                        ),
                      ],
                    ),
                    const Spacer(),
                    CommonTextWidget(
                      text: LocaleKeys.buy.tr(),
                      fontFamily: 'Roboto',
                      color: kSilver,
                      size: screenUtil.setSp(12),
                      fontWeight: FontWeight.w300,
                    ),
                  ],
                ),
              ),
            if (percent != null) ...[
              const SizedBox(height: 10),
              LinearPercentIndicator(
                lineHeight: 14.0,
                barRadius: const Radius.circular(20),
                percent: percent!,
                padding: const EdgeInsets.symmetric(horizontal: 0),
                backgroundColor: Theme.of(context).primaryColorLight,
                progressColor: Theme.of(context).indicatorColor,
              ),
            ]
          ],
        ),
      );
}
