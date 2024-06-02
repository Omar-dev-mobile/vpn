import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_builder/responsive_builder.dart';
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
      return OrientationLayoutBuilder(
        portrait: (context) => buildDesktop(context, state, homeCubit),
        landscape: (context) => buildMobile(context, state, homeCubit),
        mode: OrientationLayoutBuilderMode.portrait,
      );
    });
  }

  Widget buildDesktop(
      BuildContext context, HomeState state, HomeCubit homeCubit) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Builder(builder: (context) {
          return buildAnimation(
              homeCubit.statusConnection.status, true, state, homeCubit);
        }),
        Padding(
          padding: const EdgeInsets.only(bottom: 45),
          child: InkWellCircleCustom(
            onTap: () => onTap(context, state),
            child: Container(
              width:
                  screenUtil.screenWidth * (screenUtil.screenHeight * 0.00045),
              height:
                  screenUtil.screenWidth * (screenUtil.screenHeight * 0.00045),
              decoration: const BoxDecoration(
                // color: kBGDark,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildMobile(BuildContext context, state, HomeCubit homeCubit) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Builder(builder: (context) {
          return buildAnimation(
              homeCubit.statusConnection.status, false, state, homeCubit);
        }),
        Padding(
          padding: const EdgeInsets.only(bottom: 0),
          child: InkWellCircleCustom(
            onTap: () => onTap(context, state),
            child: Container(
              width: screenUtil.screenWidth / 2.1,
              height: screenUtil.screenWidth / 2.1,
              decoration: const BoxDecoration(
                // color: kBGDark,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildAnimation(
      StatusConnection? status, bool isDesktop, state, HomeCubit homeCubit) {
    final size = isDesktop
        ? screenUtil.screenWidth * (screenUtil.screenHeight * 0.001)
        : null;
    return switch (status) {
      StatusConnection.Online => Lottie.asset(
          Assets.stopeToVpn,
          repeat: state is LoadingStopVpnState,
          reverse: state is LoadingStopVpnState,
          width: size,
          height: size,
        ),
      StatusConnection.Stopped => LottieWidget(
          asset: Assets.disconnecting,
          width: size,
          height: size,
          repeat: false,
        ),
      StatusConnection.Connecting => LottieWidget(
          asset: Assets.connecting,
          reverse: state is LoadingStopVpnState,
          animate: homeCubit.isConnecting,
          width: size,
          height: size,
        ),
      StatusConnection.Offline => Padding(
          padding: const EdgeInsets.only(bottom: 50),
          child: Image.asset(
            Assets.offline,
            width: size,
            height: size,
          ),
        ),
      null => Image.asset(
          Assets.notActive,
          width: size,
          height: size,
        ),
    };
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
