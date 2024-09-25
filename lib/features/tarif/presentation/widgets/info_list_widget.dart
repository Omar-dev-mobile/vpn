
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:vpn/features/tarif/presentation/widgets/info_row_widget.dart';
import 'package:vpn/translations/locate_keys.g.dart';

class InfoListWidget extends StatelessWidget {
  const InfoListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      LocaleKeys.autoRenewableSubscription.tr(),
      LocaleKeys.week1MonthAnd3MonthDurations.tr(),
      LocaleKeys.yourSubscriptionWillBeChargedToYourITunesAccountAtConfirmationOfPurchase.tr(),
      LocaleKeys.currentSubscriptionMayNotBeCancelledDuringTheActiveSubscriptionPeriod.tr(),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items.map((text) => InfoRowWidget(text:  text)).toList(),
      ),
    );
  }
}