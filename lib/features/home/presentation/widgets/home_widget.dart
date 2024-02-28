import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:vpn/core/constants.dart';
import 'package:vpn/core/native/VPNIOSManager.dart';
import 'package:vpn/core/shared/components/snack_bar.dart';
import 'package:vpn/core/shared/usecases/network_info.dart';
import 'package:vpn/core/theme/assets.dart';
import 'package:vpn/core/customs/app_bar_header.dart';
import 'package:vpn/features/home/data/datasources/api_service_home.dart';
import 'package:vpn/features/home/presentation/logic/home_cubit/home_cubit.dart';
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
  @override
  void initState() {
    super.initState();
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
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      Assets.union,
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    // const AppBarHeader(),
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
                                  // ApiServiceHome().getDataServiceAcc();
                                  if (!homeCubit.isConnecting) {
                                    await homeCubit.getVpnConnecting(context);
                                  }
                                },
                                child: Image.asset(
                                  Assets.offline,
                                ),
                              ),
                            if (homeCubit.isConnecting)
                              Lottie.asset(
                                Assets.connecting,
                                animate: homeCubit.isConnecting,
                                reverse: state is LoadingStopVpnState,
                              ),
                            if (homeCubit.isStopped)
                              GestureDetector(
                                onTap: () async {
                                  if (!homeCubit.isConnecting) {
                                    await homeCubit.getVpnConnecting(context);
                                  }
                                },
                                child: Lottie.asset(
                                  Assets.disconnecting,
                                  repeat: false,
                                ),
                              ),
                          ],
                        );
                      },
                    ),
                    const Spacer(),
                    const InfoVpnWidget(),
                    screenUtil.setHeight(40).ph,
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
