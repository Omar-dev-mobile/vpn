import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vpn/core/theme/assets.dart';
import 'package:vpn/core/theme/theme.dart';
import 'package:vpn/features/home/presentation/logic/home_cubit/home_cubit.dart';

class ButtonCenter extends StatelessWidget {
  const ButtonCenter({super.key});

  @override
  Widget build(BuildContext context) {
    final homeCubit = HomeCubit.get(context);

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: kPrimary.withOpacity(0.6), width: 2)),
          ),
          Container(
            height: 90,
            width: 90,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: kPrimary.withOpacity(0.4), width: 1)),
          ),
          GestureDetector(
            onTap: () {
              if (!homeCubit.isConnecting) {
                if (homeCubit.isOnline) {
                  if (homeCubit.isOnline && !homeCubit.inProgress) {
                    homeCubit.stopVpnConnecting(context);
                  }
                } else {
                  if (!homeCubit.isConnecting && !homeCubit.inProgress) {
                    homeCubit.getVpnConnecting(context);
                  }
                }
              }
            },
            child: SvgPicture.asset(Assets.homeIcon),
          ),
        ],
      ),
    );
  }
}
