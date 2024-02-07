import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vpn/state.dart';
import 'package:vpn/core/constants.dart';
import 'package:vpn/core/shared/usecases/system_info_service.dart';
import 'package:vpn/core/theme/assets.dart';
import 'package:vpn/core/theme/theme.dart';
import 'package:vpn/features/home/presentation/bloc/home_cubit.dart';
import 'package:vpn/features/home/presentation/widgets/app_bar_header.dart';
import 'package:vpn/locator.dart';

import '../../../../core/customs/bottom_navigation_bar_widget.dart';
import '../../data/datasources/api_service_home.dart';
import 'info_vpn.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final homeCubit = HomeCubit.get(context);
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Stack(
                      children: [
                        BlocBuilder<HomeCubit, HomeState>(
                          builder: (context, state) {
                            return GestureDetector(
                              onTap: () {
                                homeCubit.toggleActiveVpn();
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
                              child: SvgPicture.asset(Assets.twitter)),
                        ),
                        Positioned(
                          child: Align(
                              alignment: Alignment.bottomLeft,
                              child: SvgPicture.asset(Assets.youTube)),
                        ),
                        Positioned(
                          child: Align(
                              alignment: Alignment.bottomRight,
                              child: SvgPicture.asset(Assets.google)),
                        ),
                      ],
                    ),
                    const Expanded(child: InfoVpnWidget())
                  ],
                ),
              ],
            ),
          ),
        ),
        const BottomNavigationBarWidget(),
      ],
    );
  }
}
