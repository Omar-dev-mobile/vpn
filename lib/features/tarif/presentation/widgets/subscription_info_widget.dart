import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vpn/core/theme/assets.dart';
import 'package:vpn/features/tarif/presentation/widgets/info_list_widget.dart';
import 'package:vpn/features/tarif/presentation/widgets/subscription_description.dart';

class SubscriptionInfoWidget extends StatelessWidget {
  const SubscriptionInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Theme.of(context).cardColor,
            ),
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: Column(
              children: [
                SubscriptionDescription(),
                const SizedBox(height: 10),
                InfoListWidget(),
              ],
            ),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              SvgPicture.asset(Assets.circle),
              SvgPicture.asset(
                  isDarkMode ? Assets.warningDark : Assets.warningLight),
            ],
          ),
        ],
      ),
    );
  }
}
