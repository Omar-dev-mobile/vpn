import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vpn/core/customs/custom_button.dart';
import 'package:vpn/core/customs/roundedButton.dart';
import 'package:vpn/core/router/app_router.dart';
import 'package:vpn/core/shared/components/system_info_service.dart';
import 'package:vpn/core/theme/assets.dart';
import 'package:vpn/features/settings/presentation/widgets/icon_widget.dart';
import 'package:vpn/locator.dart';
import 'package:vpn/translations/locate_keys.g.dart';

import '../../../../core/constants.dart';
import '../../../../core/customs/app_bar_header.dart';
import '../../../../core/customs/drawer_widget.dart';
import 'package:vpn/core/customs/common_text_widget.dart';

import '../../../../core/theme/theme.dart';

@RoutePage()
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AppBarHeader(),
            screenUtil.setHeight(33).ph,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CommonTextWidget(
                        text: LocaleKeys.about.tr(),
                        color: Theme.of(context).textTheme.bodyLarge!.color,
                        size: screenUtil.setSp(35),
                        fontWeight: FontWeight.w500,
                      ),
                      15.pw,
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: kDarkGreen),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 20),
                        child: CommonTextWidget(
                          text: 'v ${locator<SystemInfoService>().appVersion}',
                          color: kDarkTealColor,
                          size: screenUtil.setSp(18),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  screenUtil.setHeight(20).ph,
                  CommonTextWidget(
                    text: LocaleKeys.description.tr(),
                    color: Theme.of(context).textTheme.titleMedium!.color,
                    size: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  screenUtil.setHeight(10).ph,
                  CommonTextWidget(
                    text: LocaleKeys
                        .lineVpnProtectsYourOnlinePrivacyWithStateOfTheArtEncryption
                        .tr(),
                    color: Theme.of(context).textTheme.displaySmall!.color,
                    fontWeight: FontWeight.w400,
                    size: 16,
                    height: 2,
                  ),
                  screenUtil.setHeight(10).ph,
                  IconWidget(
                      onTap: () async {
                        final Uri emailLaunchUri = Uri(
                          scheme: 'mailto',
                          path: 'support@candodream.com',
                          query: encodeQueryParameters(<String, String>{
                            'subject': LocaleKeys.VPNLineQuestion.tr(),
                          }),
                        );

                        await launchUrl(emailLaunchUri);
                      },
                      icon: SvgPicture.asset(Assets.mail, fit: BoxFit.none)),
                  screenUtil.setHeight(25).ph,
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: FittedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (Platform.isWindows || Platform.isMacOS) {
                                  launchUrl(Uri.parse(termServiceUrl));
                                  return;
                                }
                                context.pushRoute(
                                    WebViewRoute(url: termServiceUrl));
                              },
                              child: CommonTextWidget(
                                text: LocaleKeys.termsOfService.tr(),
                                color: kShadeOfGray,
                                fontWeight: FontWeight.w400,
                                size: 15,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Container(
                              height: 27,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              width: 2,
                              color: kShadeOfGray,
                            ),
                            GestureDetector(
                              onTap: () {
                                if (Platform.isWindows || Platform.isMacOS) {
                                  launchUrl(Uri.parse(policyUrl));
                                  return;
                                }
                                context.pushRoute(WebViewRoute(url: policyUrl));
                              },
                              child: CommonTextWidget(
                                text: LocaleKeys.privacyPolicy.tr(),
                                color: kShadeOfGray,
                                fontWeight: FontWeight.w400,
                                textAlign: TextAlign.center,
                                size: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  screenUtil.setHeight(30).ph,
                  CustomButton(
                    title: LocaleKeys.askAQuestion.tr(),
                    color: kPrimary,
                    radius: 64,
                    size: 20,
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 16),
                    fontWeight: FontWeight.w500,
                    onPressed: () {
                      context.pushRoute(AskQuestionRoute());
                    },
                  ),
                  screenUtil.setHeight(60).ph,
                ],
              ),
            ),
            screenUtil.setHeight(90).ph,
            RoundedButton(
              name: LocaleKeys.askAQuestion.tr(),
              colorRounded: kPrimary,
              color: kPrimary,
              width: screenUtil.screenWidth * 0.8,
              onPressed: () {
                context.pushRoute(AskQuestionRoute());
              },
            ),
            screenUtil.setHeight(20).ph,
          ],
        ),
      ),
    );
  }
}
