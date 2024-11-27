import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:vpn/core/customs/common_text_widget.dart';
import 'package:vpn/translations/locate_keys.g.dart';

class SubscriptionDescription extends StatelessWidget {
  const SubscriptionDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: CommonTextWidget(
        text: LocaleKeys
            .youMayPurchaseAutoRenewingsubscriptionThroughInAppPurchase
            .tr(),
        size: 14,
        fontWeight: FontWeight.w500,
        textAlign: TextAlign.center,
        color: Theme.of(context).textTheme.bodyLarge?.color,
      ),
    );
  }
}
