import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
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
          state is SuccessListenVpnState) {
        CustomSnackBar.goodSnackBar(context,
            LocaleKeys.vPNConnectionHasBeenSuccessfullyEstablished.tr());
      }
    }, builder: (context, state) {
      switch (homeCubit.statusConnection.status) {
        case StatusConnection.Online:
          return GestureDetector(
            onTap: () async {
              if (homeCubit.isOnline && !homeCubit.inProgress) {
                await homeCubit.stopVpnConnecting(context);
              }
            },
            child: Lottie.asset(
              Assets.stopeToVpn,
              repeat: state is LoadingStopVpnState,
              reverse: state is LoadingStopVpnState,
            ),
          );
        case StatusConnection.Stopped:
          return GestureDetector(
            onTap: () async {
              if (!homeCubit.isConnecting && !homeCubit.inProgress) {
                await homeCubit.getVpnConnecting(context);
              }
            },
            child: LottieWidget(
              asset: Assets.disconnecting,
              repeat: false,
            ),
          );
        case StatusConnection.Connecting:
          return LottieWidget(
            asset: Assets.connecting,
            reverse: state is LoadingStopVpnState,
            animate: homeCubit.isConnecting,
          );
        case StatusConnection.Offline:
          return GestureDetector(
            onTap: () async {
              if (!homeCubit.isConnecting && !homeCubit.inProgress) {
                await homeCubit.getVpnConnecting(context);
              }
            },
            child: Image.asset(
              Assets.offline,
            ),
          );
        default:
          return Image.asset(
            Assets.notActive,
          );
      }
    });
  }
}
