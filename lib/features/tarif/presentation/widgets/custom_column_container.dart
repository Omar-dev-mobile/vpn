import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:vpn/core/constants.dart';
import 'package:vpn/core/theme/assets.dart';
import 'package:vpn/features/tarif/presentation/widgets/custom_container.dart';
import 'package:vpn/translations/locate_keys.g.dart';

class CustomColumnContainer extends StatelessWidget {
  const CustomColumnContainer({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomContainer(
                icon: isDarkMode ? Assets.allDevices3 : Assets.allDevices2,
                text: LocaleKeys.allDevices.tr()),
            7.pw,
            CustomContainer(
                icon: Assets.highSpeed2, text: LocaleKeys.highSpeed.tr())
          ],
        ),
        7.ph,
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          runAlignment: WrapAlignment.center,
          alignment: WrapAlignment.center,

          runSpacing: 7,
          spacing: 7, // Adjust spacing between items in the Wrap

          children: [
            IntrinsicWidth(
                child: CustomContainer(
                    icon: isDarkMode ? Assets.moneyBack3 : Assets.moneyBack2,
                    text: LocaleKeys.moneyBack.tr())),
            IntrinsicWidth(
                child: CustomContainer(
                    icon: Assets.trafic2, text: LocaleKeys.trafic.tr())),
            IntrinsicWidth(
                child: CustomContainer(
                    icon: isDarkMode ? Assets.openWorld3 : Assets.openWorld2,
                    text: LocaleKeys.openWorld.tr())),
          ],
        ),
      ],
    );
  }
}
