import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vpn/core/constants.dart';
import 'package:vpn/core/customs/common_text_widget.dart';
import 'package:vpn/core/theme.dart';
import 'package:vpn/features/home/presentation/bloc/home_cubit.dart';
import 'package:vpn/features/home/presentation/widgets/app_bar_header.dart';

import 'info_vpn.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final homeCubit = HomeCubit.get(context);
    return Container(
      height: screenUtil.screenHeight,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: kWhite,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(
            "assets/icons/Union.png",
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
              Stack(
                children: [
                  BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, state) {
                      return GestureDetector(
                        onTap: () {
                          homeCubit.toggleActiveVpn();
                        },
                        child: homeCubit.active
                            ? Image.asset('assets/images/active_color.png')
                            : Image.asset('assets/images/desactive_color.png'),
                      );
                    },
                  ),
                  Positioned(
                    top: screenUtil.setHeight(220),
                    left: screenUtil.setWidth(200),
                    child: Align(
                        alignment: Alignment.bottomLeft,
                        child: SvgPicture.asset('assets/icons/Facebook.svg')),
                  ),
                  Positioned(
                    top: screenUtil.setHeight(180),
                    child: Align(
                        alignment: Alignment.topRight,
                        child: SvgPicture.asset('assets/icons/Twitter.svg')),
                  ),
                  Positioned(
                    child: Align(
                        alignment: Alignment.bottomLeft,
                        child: SvgPicture.asset('assets/icons/YouTube.svg')),
                  ),
                  Positioned(
                    child: Align(
                        alignment: Alignment.bottomRight,
                        child: SvgPicture.asset('assets/icons/Google.svg')),
                  ),
                ],
              ),
              InfoVpnWidget(),
            ],
          ),
        ],
      ),
    );
  }
}
