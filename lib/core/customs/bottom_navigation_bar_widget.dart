import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vpn/core/constants.dart';
import 'package:vpn/core/router/app_router.dart';
import 'package:vpn/core/theme/assets.dart';
import 'package:vpn/core/theme/theme.dart';
import 'package:vpn/features/home/presentation/widgets/nav_bar_widget.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: SvgPicture.asset(
            Assets.navBar,
            width: screenUtil.screenWidth,
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 30, top: 20),
            child: NavBarWidget(
              title: 'Russia',
              icons: Assets.ru,
              onTap: () {},
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 30, top: 20),
            child: NavBarWidget(
              title: 'Tarif',
              icons: Assets.person,
              onTap: () {
                context.pushRoute(const TarifRoute());
              },
            ),
          ),
        ),
      ],
    );
  }
}
