import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:vpn/core/native/VPNIOSManager.dart';
import 'package:vpn/core/shared/components/snack_bar.dart';
import 'package:vpn/core/theme/assets.dart';
import 'package:vpn/features/home/presentation/logic/home_cubit/home_cubit.dart';

class StatusVpn extends StatelessWidget {
  const StatusVpn({super.key});

  @override
  Widget build(BuildContext context) {
    final homeCubit = HomeCubit.get(context);
    return BlocConsumer<HomeCubit, HomeState>(listener: (context, state) {
      if (homeCubit.statusConnection.status == StatusConnection.Online &&
          state is SuccessListenVpnState) {
        CustomSnackBar.goodSnackBar(context, "Success connect vpn");
      }
    }, builder: (context, state) {
      switch (homeCubit.statusConnection.status) {
        case StatusConnection.Online:
          return GestureDetector(
            onTap: () async {
              await homeCubit.stopVpnConnecting(context);
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
              if (!homeCubit.isConnecting) {
                await homeCubit.getVpnConnecting(context);
              }
            },
            child: Lottie.asset(
              Assets.disconnecting,
              repeat: false,
            ),
          );
        case StatusConnection.Connecting:
          return Lottie.asset(
            Assets.connecting,
            animate: homeCubit.isConnecting,
            reverse: state is LoadingStopVpnState,
          );
        case StatusConnection.Offline:
          return GestureDetector(
            onTap: () async {
              if (!homeCubit.isConnecting) {
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
