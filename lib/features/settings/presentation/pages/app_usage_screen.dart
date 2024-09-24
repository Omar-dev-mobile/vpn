import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:vpn/core/customs/custom_button.dart';
import 'package:vpn/features/settings/presentation/widgets/app_usage_widget.dart';
import 'package:vpn/translations/locate_keys.g.dart';
import '../../../../core/constants.dart';
import 'package:vpn/core/customs/common_text_widget.dart';

import '../../../../core/theme/theme.dart';

@RoutePage()
class AppUsageScreen extends StatelessWidget {
  const AppUsageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  screenUtil.setHeight(55).ph,
                  CommonTextWidget(
                    text: 'App usage data',
                    color: Colors.white,
                    size: screenUtil.setSp(28),
                    fontWeight: FontWeight.w500,
                  ),
                  screenUtil.setHeight(15).ph,
                  AppUsageWidget(
                    number: '1',
                    text:
                        'We keep your User email, registration date. They are used for signing in and to keep records of the accounts set to auto-renew.',
                  ),
                  screenUtil.setHeight(25).ph,
                  AppUsageWidget(
                    number: '2',
                    text:
                        'We keep records of your Subscription status, payment methods, allocated packages, subscription duration and transaction IDs. This data is collected to provide basic app functionality and troubleshooting steps (e.9 refunds). We do NOT store your credit card or payment information.',
                  ),
                  screenUtil.setHeight(25).ph,
                  AppUsageWidget(
                    number: '3',
                    text:
                        'We keep information about your Device, ie. version of an operating System, hardware model and your IP address. This data is, necessary to optimize the Network Connection and ensure high quality Technical Support',
                  ),
                  screenUtil.setHeight(25).ph,
                  AppUsageWidget(
                    number: '4',
                    text:
                        'We keep information about the consumed traffic Volume and total usage time of the VPN app to properly distribute the load on Servers.',
                  ),
                  screenUtil.setHeight(10).ph,
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Checkbox(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0)),
                    side: BorderSide(color: kShadeOfGray, width: 1),
                    fillColor: WidgetStatePropertyAll(Colors.white),
                    value: false,
                    onChanged: (value) {},
                  ),
                  CommonTextWidget(
                    text: LocaleKeys.rememberTheChoice.tr(),
                    color: kWhite,
                    size: screenUtil.setSp(12),
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
            ),
            screenUtil.setHeight(25).ph,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: [
                  Expanded(
                      child: CustomButton(
                    title: LocaleKeys.iAgree.tr(),
                    color: kGreenColor,
                    radius: 20,
                    size: screenUtil.setSp(24),
                    fontWeight: FontWeight.w400,
                  )),
                  Expanded(
                    child: CustomButton(
                      title: LocaleKeys.iDisagree.tr(),
                      color: Colors.transparent,
                      textColor: kDarkRed,
                      radius: 20,
                      size: screenUtil.setSp(24),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            screenUtil.setHeight(35).ph,
          ],
        ),
      ),
    );
  }
}
