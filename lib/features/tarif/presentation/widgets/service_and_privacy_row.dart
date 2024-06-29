
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:vpn/core/constants.dart';
import 'package:vpn/core/customs/common_text_widget.dart';
import 'package:vpn/core/router/app_router.dart';
import 'package:vpn/core/theme/theme.dart';
import 'package:vpn/translations/locate_keys.g.dart';

class ServiceAndPrivacyRow extends StatelessWidget {
  const ServiceAndPrivacyRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              context.pushRoute(
                  WebViewRoute(
                      url: termServiceUrl));
            },
            child: CommonTextWidget(
              text: LocaleKeys
                  .termsOfService
                  .tr(),
              color: kShadeOfGray,
              fontWeight: FontWeight.w400,
              size: screenUtil.setSp(15),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            height: 27,
            margin:
                const EdgeInsets.symmetric(
                    horizontal: 20),
            width: 2,
            color: lightGray,
          ),
          GestureDetector(
            onTap: () {
              context.pushRoute(
                  WebViewRoute(
                      url: policyUrl));
            },
            child: CommonTextWidget(
              text: LocaleKeys.privacyPolicy
                  .tr(),
              color: kShadeOfGray,
              fontWeight: FontWeight.w400,
              textAlign: TextAlign.center,
              size: screenUtil.setSp(15),
            ),
          ),
        ],
      ),
    );
  }
}
