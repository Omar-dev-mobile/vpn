import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:vpn/core/constants.dart';
import 'package:vpn/core/customs/app_bar_header.dart';
import 'package:vpn/core/customs/common_text_widget.dart';
import 'package:vpn/core/router/app_router.dart';
import 'package:vpn/core/theme/assets.dart';
import 'package:vpn/core/theme/theme.dart';
import 'package:vpn/core/customs/custom_switch_button.dart';
import 'package:vpn/translations/locate_keys.g.dart';

@RoutePage()
class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  _PrivacyPolicyScreenState createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  bool isLicenseAccepted = false;
  bool isAnonymousDataEnabled = false;

  void _checkConditions() {
    if (isLicenseAccepted && isAnonymousDataEnabled) {
      context.replaceRoute(const MainRoute());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers:[
SliverToBoxAdapter(
  child: Column(
                  children: [
                    const AppBarHeader(
                      topPadding: 20,
                      isClose: false,
                    ),
                    Image.asset(
                      Assets.privacy,
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.5,
                    ),
                    10.ph,
                  ],
                ),
              ),
              SliverFillRemaining(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Spacer(),
                      CommonTextWidget(
                        text: LocaleKeys.privacyScreenTitle.tr(),
                        fontWeight: FontWeight.w500,
                        size: 28,
                        color: Theme.of(context).textTheme.labelLarge?.color,
                      ),
                      10.ph,
                      CommonTextWidget(
                        text: LocaleKeys.privacyScreenText.tr(),
                        textAlign: TextAlign.center,
                        fontWeight: FontWeight.w400,
                        size: 15,
                        color: Theme.of(context).textTheme.headlineSmall?.color,
                      ),
                      32.ph,
                      Row(
                        children: [
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                text: LocaleKeys.collectData.tr(),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: isAnonymousDataEnabled
                                      ? Theme.of(context)
                                          .textTheme
                                          .labelMedium
                                          ?.color
                                      : kShadeOfGray,
                                ),
                                children: [
                                  TextSpan(
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        context.pushRoute(AppUsageRoute());
                                      },
                                    text: LocaleKeys.appUsageData.tr(),
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                  TextSpan(
                                    text: LocaleKeys.makeExperienceBetter.tr(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          AnimatedToggleSwitch(
                            isOn: isAnonymousDataEnabled,
                            onToggle: (value) {
                              setState(() {
                                isAnonymousDataEnabled = value;
                                _checkConditions();
                              });
                            },
                          ),
                        ],
                      ),
                      28.ph,
                      Row(
                        children: [
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                text: LocaleKeys.accept.tr(),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: isLicenseAccepted
                                      ? Theme.of(context)
                                          .textTheme
                                          .labelMedium
                                          ?.color
                                      : kShadeOfGray,
                                ),
                                children: [
                                  TextSpan(
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        context.pushRoute(
                                            WebViewRoute(url: termServiceUrl));
                                      },
                                    text: LocaleKeys.licenceAgreement.tr(),
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                  TextSpan(
                                    text: LocaleKeys.and.tr(),
                                  ),
                                  TextSpan(
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        context.pushRoute(
                                            WebViewRoute(url: policyUrl));
                                      },
                                    text: LocaleKeys.privacyPolicy2.tr(),
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                  TextSpan(
                                    text: LocaleKeys.vpnLine.tr(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          AnimatedToggleSwitch(
                            isOn: isLicenseAccepted,
                            onToggle: (value) {
                              setState(() {
                                isLicenseAccepted = value;
                                _checkConditions();
                              });
                            },
                          ),
                        ],
                      ),
                      50.ph,
                    ],
                  ),
                ),
              ),
          ] ,
        ),
      ),
    );
  }
}
