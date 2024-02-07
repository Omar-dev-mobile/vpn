import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vpn/core/constants.dart';
import 'package:vpn/core/customs/common_text_widget.dart';
import 'package:vpn/core/theme/assets.dart';
import 'package:vpn/features/home/presentation/widgets/app_bar_header.dart';
import 'package:vpn/features/tarif/presentation/widgets/card_pay_widget.dart';
import 'package:vpn/features/tarif/presentation/widgets/card_tarif_widget.dart';

@RoutePage()
class TarifScreen extends StatelessWidget {
  const TarifScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppBarHeader(),
          screenUtil.setHeight(33).ph,
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: const BoxDecoration(),
                child: Stack(
                  children: [
                    SvgPicture.asset(Assets.bgTraif),
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonTextWidget(
                            text: 'Tarif',
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
                                plan: 'Week',
                                day: '30 days',
                                percent: index == 0 ? 0.7 : null,
                              );
                            },
                            itemCount: 3,
                            shrinkWrap: true,
                            separatorBuilder:
                                (BuildContext context, int index) => 30.ph,
                          ),
                          60.ph,
                        ],
                      ),
                    ),
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
