import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vpn/core/constants.dart';
import 'package:vpn/core/theme/assets.dart';
import 'package:vpn/features/home/presentation/logic/cubit/home_cubit.dart';
import 'package:vpn/features/home/presentation/widgets/wrap_icons.dart';

class StopInHome extends StatelessWidget {
  const StopInHome({super.key});

  @override
  Widget build(BuildContext context) {
    final homeCubit = HomeCubit.get(context);
    return Stack(
      children: [
        GestureDetector(
          onTap: () async {
            homeCubit.stopVpnConnecting(context);
          },
          child: Image.asset(Assets.online),
        ),
        Positioned(
          child: Padding(
            padding: EdgeInsets.only(
              left: screenUtil.setWidth(80),
              top: screenUtil.setHeight(60),
            ),
            child: const WrapIcons(
              icon: Assets.facebook,
            ),
          ),
        ),
        Positioned(
          top: screenUtil.setHeight(180),
          left: screenUtil.setWidth(60),
          child: const WrapIcons(
            icon: Assets.twitter,
          ),
        ),
        Positioned(
          child: Padding(
            padding: EdgeInsets.only(
                right: screenUtil.setWidth(60), top: screenUtil.setHeight(220)),
            child: const Align(
              alignment: Alignment.bottomRight,
              child: WrapIcons(
                icon: Assets.youTube,
              ),
            ),
          ),
        ),
        Positioned(
          child: Padding(
            padding: EdgeInsets.only(
                right: screenUtil.setWidth(60), top: screenUtil.setHeight(50)),
            child: const Align(
              alignment: Alignment.bottomRight,
              child: WrapIcons(
                icon: Assets.google,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
