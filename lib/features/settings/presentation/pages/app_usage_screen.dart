import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:vpn/core/customs/custom_button.dart';
import 'package:vpn/core/shared/datasources/local/cache_helper.dart';
import 'package:vpn/features/settings/presentation/widgets/app_usage_widget.dart';
import 'package:vpn/translations/locate_keys.g.dart';
import 'package:vpn/core/constants.dart';
import 'package:vpn/core/customs/common_text_widget.dart';
import 'package:vpn/core/theme/theme.dart';

@RoutePage()
class AppUsageScreen extends StatefulWidget {
  final Function onAgree;

  const AppUsageScreen({super.key, required this.onAgree});

  @override
  State<AppUsageScreen> createState() => _AppUsageScreenState();
}

class _AppUsageScreenState extends State<AppUsageScreen> {
  bool? _isChecked = false; // Track checkbox status

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight.withOpacity(0.3),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  screenUtil.setHeight(40).ph,
                  CommonTextWidget(
                    text: capitalizeFirstChar(LocaleKeys.appUsageData.tr()),
                    color: Colors.white,
                    size: screenUtil.setSp(25),
                    fontWeight: FontWeight.w500,
                  ),
                  screenUtil.setHeight(10).ph,
                  AppUsageWidget(
                    number: '1',
                    text: LocaleKeys.appUsage1.tr(),
                  ),
                  screenUtil.setHeight(20).ph,
                  AppUsageWidget(
                    number: '2',
                    text: LocaleKeys.appUsage2.tr(),
                  ),
                  screenUtil.setHeight(20).ph,
                  AppUsageWidget(
                    number: '3',
                    text: LocaleKeys.appUsage3.tr(),
                  ),
                  screenUtil.setHeight(20).ph,
                  AppUsageWidget(
                    number: '4',
                    text: LocaleKeys.appUsage4.tr(),
                  ),
                  screenUtil.setHeight(10).ph,
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Checkbox(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0)),
                    side: BorderSide(color: kShadeOfGray, width: 1),
                    fillColor: WidgetStatePropertyAll(Colors.white),
                    checkColor: kBlack,
                    value: _isChecked,
                    onChanged: (value) {
                      setState(() {
                        print(value);
                        _isChecked = value;
                      });
                    },
                  ),
                  CommonTextWidget(
                    text: LocaleKeys.rememberTheChoice.tr(),
                    color: kWhite,
                    size: screenUtil.setSp(12),
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
            ),
            screenUtil.setHeight(10).ph,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      title: LocaleKeys.iAgree.tr(),
                      color: kGreenColor,
                      radius: 20,
                      size: screenUtil.setSp(20),
                      fontWeight: FontWeight.w400,
                      onPressed: () async {
                        await CacheHelper().saveVpnAgreementChoice(_isChecked);
                        widget.onAgree();
                      },
                    ),
                  ),
                  Expanded(
                    child: CustomButton(
                      title: LocaleKeys.iDisagree.tr(),
                      color: Colors.transparent,
                      textColor: kDarkRed,
                      radius: 20,
                      size: screenUtil.setSp(20),
                      fontWeight: FontWeight.w400,
                      onPressed: () async {
                        await CacheHelper().saveVpnAgreementChoice(false);
                        Navigator.of(context).pop(); // Close the dialog
                      },
                    ),
                  ),
                ],
              ),
            ),
            screenUtil.setHeight(35).ph,
          ],
        ),
      ),
    );
  }
}

void showAppUsageModal(BuildContext context, Function confirmVpnConnecting) {
  showGeneralDialog(
    context: context,
    transitionDuration: const Duration(milliseconds: 100),
    pageBuilder: (context, animation, secondaryAnimation) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
        child: Material(
            color: Colors.transparent,
            child: AppUsageScreen(
              onAgree: () {
                confirmVpnConnecting(context);
                Navigator.of(context).pop(); // Close the dialog
              },
            )),
      );
    },
  );
}

String capitalizeFirstChar(String text) {
  if (text.isEmpty) return text;
  return text[0].toUpperCase() + text.substring(1);
}
