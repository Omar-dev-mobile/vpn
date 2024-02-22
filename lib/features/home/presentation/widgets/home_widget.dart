import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:lottie/lottie.dart';
import 'package:vpn/core/constants.dart';
import 'package:vpn/core/customs/lottie_widget.dart';
import 'package:vpn/core/native/VPNIOSManager.dart';
import 'package:vpn/core/shared/components/snack_bar.dart';
import 'package:vpn/core/shared/components/system_info_service.dart';
import 'package:vpn/core/shared/usecases/network_info.dart';
import 'package:vpn/core/theme/assets.dart';
import 'package:vpn/core/theme/theme.dart';
import 'package:vpn/core/customs/app_bar_header.dart';
import 'package:vpn/features/home/presentation/logic/cubit/home_cubit.dart';
import 'package:vpn/features/home/presentation/widgets/stopin_home.dart';
import 'package:vpn/locator.dart';

import '../../../../core/customs/bottom_navigation_bar_widget.dart';
import 'info_vpn.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> with TickerProviderStateMixin {
  var crash = false;
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final homeCubit = HomeCubit.get(context);
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (homeCubit.statusConnection.status == StatusConnection.Online &&
            state is SuccessListenVpnState) {
          CustomSnackBar.goodSnackBar(context, "Success connect vpn");
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            Expanded(
              child: Container(
                height: screenUtil.screenHeight,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: kWhite,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      Assets.union,
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    const AppBarHeader(),
                    const Spacer(),
                    StreamBuilder(
                      stream: locator<NetworkChecker>()
                          .connectionChecker
                          .onStatusChange,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        return Column(
                          children: [
                            screenUtil.setHeight(60).ph,
                            if (homeCubit.isOnline)
                              GestureDetector(
                                onTap: () async {
                                  await homeCubit.stopVpnConnecting(context);
                                },
                                child: Lottie.asset(
                                  Assets.stopeToVpn,
                                  repeat: state is LoadingConnectVpnState ||
                                      state is LoadingStopVpnState,
                                  reverse: state is LoadingStopVpnState,
                                ),
                              ),
                            if (homeCubit.isOffline)
                              GestureDetector(
                                onTap: () async {
                                  await homeCubit.getVpnConnecting(context);
                                },
                                child: Image.asset(
                                  Assets.offline,
                                ),
                              ),
                            // if (homeCubit.isOffline ||
                            //     InternetConnectionStatus.disconnected ==
                            //         snapshot.data)
                            //   Image.asset(
                            //     Assets.offline,
                            //   ),
                            if (homeCubit.isConnecting || homeCubit.isStopped)
                              GestureDetector(
                                onTap: () async {
                                  if (state is! LoadingConnectVpnState) {
                                    await homeCubit.getVpnConnecting(context);
                                  }
                                },
                                child: Lottie.asset(
                                  Assets.connecting,
                                  animate: homeCubit.isConnecting,
                                ),
                              ),
                          ],
                        );
                      },
                    ),
                    const Spacer(),
                    const InfoVpnWidget(),
                    screenUtil.setHeight(30).ph,
                  ],
                ),
              ),
            ),
            const BottomNavigationBarWidget(),
          ],
        );
      },
    );
  }
}
