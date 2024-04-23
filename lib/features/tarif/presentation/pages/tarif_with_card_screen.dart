import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:vpn/core/constants.dart';
import 'package:vpn/core/customs/common_text_widget.dart';
import 'package:vpn/core/customs/app_bar_header.dart';
import 'package:vpn/features/tarif/presentation/widgets/card_pay_widget.dart';
import 'package:vpn/features/tarif/presentation/widgets/card_tarif_widget.dart';
import 'package:vpn/translations/locate_keys.g.dart';

@RoutePage()
class TarifWithCardScreen extends StatelessWidget {
  const TarifWithCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppBarHeader(),
          screenUtil.setHeight(33).ph,
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonTextWidget(
                      text: LocaleKeys.plan.tr(),
                      color: Theme.of(context).disabledColor,
                      size: screenUtil.setSp(35),
                      fontWeight: FontWeight.w500,
                    ),
                    ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return CardTarifWidget(
                          prise: '5',
                          index: index,
                          tarifDays: "",
                          plan: 'Week',
                          day: '30 days',
                          percent: index == 0 ? 0.7 : null,
                        );
                      },
                      itemCount: 2,
                      shrinkWrap: true,
                      separatorBuilder: (BuildContext context, int index) =>
                          30.ph,
                    ),
                    20.ph,
                    const CardPayWidget(),
                    60.ph,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
