import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:vpn/core/constants.dart';
import 'package:vpn/core/customs/common_text_widget.dart';
import 'package:vpn/translations/locate_keys.g.dart';

@RoutePage()
class AppUsageScreen extends StatelessWidget {
  const AppUsageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: CommonTextWidget(
          text: LocaleKeys.appUsageData.tr(),
          size: 20,
          fontWeight: FontWeight.bold,
                            color: Theme.of(context).textTheme.titleMedium?.color,

        ), // Ensure this key is translated
      ),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                10.ph,
                CommonTextWidget(
                  text: LocaleKeys.appUsage1.tr(),
                  size: 16,
                  color: Theme.of(context).textTheme.titleMedium?.color,
                ),
                10.ph,
                CommonTextWidget(
                  text: LocaleKeys.appUsage2.tr(),
                  size: 16,
                  color: Theme.of(context).textTheme.titleMedium?.color,
                ),
                10.ph,
                CommonTextWidget(
                  text: LocaleKeys.appUsage3.tr(),
                  size: 16,
                  color: Theme.of(context).textTheme.titleMedium?.color,
                ),
                10.ph,
                CommonTextWidget(
                  text: LocaleKeys.appUsage4.tr(),
                  size: 16,
                  color: Theme.of(context).textTheme.titleMedium?.color,
                ),
                10.ph,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
