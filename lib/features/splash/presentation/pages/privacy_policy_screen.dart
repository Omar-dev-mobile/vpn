import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:vpn/core/constants.dart';
import 'package:vpn/core/customs/app_bar_header.dart';
import 'package:vpn/core/customs/common_text_widget.dart';
import 'package:vpn/core/theme/assets.dart';
import 'package:vpn/core/theme/theme.dart';
import 'package:vpn/core/customs/custom_switch_button.dart';

@RoutePage()
class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  _PrivacyPolicyScreenState createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  bool isLicenseAccepted = false;
  bool isAnonymousDataEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  CommonTextWidget(
                    text: 'Privacy Policy',
                    fontWeight: FontWeight.w500,
                    size: 28,
                    color: Theme.of(context).textTheme.labelLarge?.color,
                  ),
                  10.ph,
                  CommonTextWidget(
                    text:
                        'The payment will be charged from your iTunes account iTunes confirmation of purchase. The payment will be charged from your iTunes account iTunes confirmation of purchase.',
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
                            text: 'I accept the ',
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
                                text: 'License Agreement',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              TextSpan(
                                text: ' and the ',
                              ),
                              TextSpan(
                                text: 'Privacy Policy',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              TextSpan(
                                text: ' AdGuard VPN',
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
                            text: 'Send anonymous',
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
                                text: ' data about the use of the application',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              TextSpan(
                                text: ' to help make AdGuard VPN better ',
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
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
