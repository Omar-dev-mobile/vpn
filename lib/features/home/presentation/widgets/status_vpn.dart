import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:vpn/core/constants.dart';
import 'package:vpn/core/customs/ink_well_circle_custom.dart';
import 'package:vpn/core/customs/lottie_widget.dart';
import 'package:vpn/core/native/VPNIOSManager.dart';
import 'package:vpn/core/shared/components/snack_bar.dart';
import 'package:vpn/core/theme/assets.dart';
import 'package:vpn/features/home/presentation/logic/home_cubit/home_cubit.dart';
import 'package:vpn/translations/locate_keys.g.dart';

class StatusVpn extends StatelessWidget {
  const StatusVpn({super.key});

  @override
  Widget build(BuildContext context) {
    final homeCubit = HomeCubit.get(context);
    return BlocConsumer<HomeCubit, HomeState>(listener: (context, state) {
      if (homeCubit.statusConnection.status == StatusConnection.Online &&
          state is SuccessListenVpnState &&
          homeCubit.inProgress) {
        CustomSnackBar.goodSnackBar(context,
            LocaleKeys.vPNConnectionHasBeenSuccessfullyEstablished.tr());
      }
    }, builder: (context, state) {
      return Stack(
        alignment: Alignment.center,
        children: [
          Builder(builder: (context) {
            switch (homeCubit.statusConnection.status) {
              case StatusConnection.Online:
                return LottieWidget(
                  asset: Assets.stopeToVpn,
                  repeat: state is LoadingStopVpnState,
                  reverse: state is LoadingStopVpnState,
                );
              case StatusConnection.Stopped:
                return LottieWidget(
                  asset: Assets.disconnecting,
                  repeat: false,
                );
              case StatusConnection.Connecting:
                return LottieWidget(
                  asset: Assets.connecting,
                  reverse: state is LoadingStopVpnState,
                  animate: homeCubit.isConnecting,
                );
              case StatusConnection.Offline:
                return Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: Image.asset(
                    Assets.offline,
                    width: Platform.isMacOS ? 370 : null,
                    height: Platform.isMacOS ? 370 : null,
                  ),
                );
              default:
                return Image.asset(
                  Assets.notActive,
                );
            }
          }),
          Padding(
            padding: const EdgeInsets.only(bottom: 55),
            child: InkWellCircleCustom(
              onTap: () => onTap(context, state),
              child: Container(
                width: Platform.isMacOS ? 170 : screenUtil.screenWidth / 2.1,
                height: Platform.isMacOS ? 170 : screenUtil.screenWidth / 2.1,
                decoration: const BoxDecoration(
                  // color: kBGDark,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ],
      );
    });
  }

  void onTap(context, HomeState state) async {
    final homeCubit = HomeCubit.get(context);
    switch (homeCubit.statusConnection.status) {
      case StatusConnection.Online:
        if (homeCubit.isOnline && !homeCubit.inProgress) {
          await homeCubit.stopVpnConnecting(context);
        }
        break;
      case StatusConnection.Stopped:
        if (!homeCubit.isConnecting && !homeCubit.inProgress) {
          await homeCubit.getVpnConnecting(context);
        }
        break;
      case StatusConnection.Connecting:
        break;
      case StatusConnection.Offline:
        if (!homeCubit.isConnecting && !homeCubit.inProgress) {
          await homeCubit.getVpnConnecting(context);
        }
        break;
      default:
        break;
    }
  }
}
