import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vpn/core/constants.dart';
import 'package:vpn/core/customs/common_text_widget.dart';
import 'package:vpn/core/native/VPNIOSManager.dart';
import 'package:vpn/core/shared/components/builder_bloc.dart';
import 'package:vpn/core/theme/assets.dart';
import 'package:vpn/core/theme/theme.dart';
import 'package:vpn/core/customs/app_bar_header.dart';
import 'package:vpn/features/home/presentation/logic/bloc/home_vpn_bloc.dart';
import 'package:vpn/features/home/presentation/logic/cubit/home_cubit.dart';
import 'package:vpn/locator.dart';

import '../../../../core/customs/bottom_navigation_bar_widget.dart';
import 'info_vpn.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final homeCubit = HomeCubit.get(context);
    return BlocBuilder<HomeVpnBloc, HomeVpnState>(
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
                child: Stack(
                  children: [
                    const AppBarHeader(),
                    BuilderBloc<HomeSuccessVpnState, HomeErrorVpnState>(
                      state: state,
                      child: Builder(
                        builder: (context) {
                          var status = (state as HomeSuccessVpnState);
                          print(status.status);
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Spacer(),
                              Stack(
                                children: [
                                  BlocBuilder<HomeCubit, HomeState>(
                                    builder: (context, state) {
                                      return GestureDetector(
                                        onTap: () async {
                                          // print((await VPNIOSManager.getStatus()).status);
                                          if (status.status ==
                                              StatusConnection.Online) {
                                            await locator<VPNIOSManager>()
                                                .stopTun();
                                          } else {
                                            await locator<VPNIOSManager>()
                                                .configureVPN(
                                                    username: 'usr9',
                                                    serverAddress:
                                                        '128.140.61.187',
                                                    sharedSecret:
                                                        'N2gzEt5RoovqxtgfsAmw',
                                                    password:
                                                        'aRMD2wYkN9MtzElPI');
                                          }
                                          // print((await VPNIOSManager.getStatus()).status);

                                          // await Future.delayed(
                                          //     const Duration(minutes: 1));
                                          // await VPNIOSManager.stopTun();
                                          // print((await VPNIOSManager.getStatus()).status);
                                          // context.read<AuthBloc>().add(
                                          //     const LoginWithGoogleAndAppleAuthEvent(
                                          //         type: 'apple'));

                                          // homeCubit.toggleActiveVpn();
                                        },
                                        child: homeCubit.active
                                            ? Image.asset(
                                                'assets/images/active_color.png')
                                            : Image.asset(
                                                'assets/images/desactive_color.png'),
                                      );
                                    },
                                  ),
                                  Positioned(
                                    top: screenUtil.setHeight(220),
                                    left: screenUtil.setWidth(200),
                                    child: Align(
                                      alignment: Alignment.bottomLeft,
                                      child: SvgPicture.asset(Assets.facebook),
                                    ),
                                  ),
                                  Positioned(
                                    top: screenUtil.setHeight(180),
                                    child: Align(
                                        alignment: Alignment.topRight,
                                        child:
                                            SvgPicture.asset(Assets.twitter)),
                                  ),
                                  Positioned(
                                    child: Align(
                                        alignment: Alignment.bottomLeft,
                                        child:
                                            SvgPicture.asset(Assets.youTube)),
                                  ),
                                  Positioned(
                                    child: Align(
                                        alignment: Alignment.bottomRight,
                                        child: SvgPicture.asset(Assets.google)),
                                  ),
                                ],
                              ),
                              CommonTextWidget(text: "${status.status}"),
                              const Expanded(child: InfoVpnWidget())
                            ],
                          );
                        },
                      ),
                    ),
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
