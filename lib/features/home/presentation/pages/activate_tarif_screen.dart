import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vpn/core/constants.dart';
import 'package:vpn/core/customs/common_text_widget.dart';
import 'package:vpn/core/customs/custom_button.dart';
import 'package:vpn/core/router/app_router.dart';
import 'package:vpn/core/theme/assets.dart';
import 'package:vpn/core/theme/theme.dart';
import 'package:vpn/features/home/presentation/bloc/home_cubit.dart';
import 'package:vpn/core/customs/app_bar_header.dart';

class ActivateTarifScreen extends StatelessWidget {
  const ActivateTarifScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        GestureDetector(
            onTap: () {
              context.pushRoute(const LoginRoute());
            },
            child: Image.asset(Assets.noActive)),
        Image.asset(Assets.union),
        const Align(alignment: Alignment.topCenter, child: AppBarHeader()),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CommonTextWidget(
                  text: "Need activate tarif to use VPN",
                  size: screenUtil.setSp(20),
                  color: kDarkBluishGrayColor,
                ),
                screenUtil.setHeight(50).ph,
                CustomButton(
                  title: "Activate tarif",
                  color: kPrimary,
                  onPressed: () {
                    context.pushRoute(const LoginRoute());
                  },
                ),
                screenUtil.setHeight(10).ph,
              ],
            ),
          ),
        ),
      ],
    );
  }
}
