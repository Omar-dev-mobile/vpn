import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:vpn/core/constants.dart';
import 'package:vpn/core/customs/common_text_widget.dart';
import 'package:vpn/translations/locate_keys.g.dart';

class TextContainer extends StatelessWidget {
  const TextContainer({super.key});

  List<String> get items => [
        LocaleKeys.AutoRenewal.tr(),
        LocaleKeys.paymentWillBeCharged.tr(),
        LocaleKeys.subscriptionWillAutomatically.tr(),
        LocaleKeys.accountWillBeCharged.tr(),
      ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenUtil.setHeight(190),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Expanded(
            child: PageView.builder(
              padEnds: false,
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: CommonTextWidget(
                      text: items[index],
                      textAlign: TextAlign.center,
                      size: 15,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).textTheme.titleSmall?.color,
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
