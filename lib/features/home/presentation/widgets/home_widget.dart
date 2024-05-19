import 'package:flutter/material.dart';
import 'package:vpn/core/constants.dart';
import 'package:vpn/core/theme/assets.dart';
import 'package:vpn/core/customs/app_bar_header.dart';
import 'package:vpn/features/home/presentation/widgets/status_vpn.dart';
import '../../../../core/customs/bottom_navigation_bar_widget.dart';
import 'info_vpn.dart';
import 'package:responsive_builder/responsive_builder.dart';

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
            child: OrientationLayoutBuilder(
              portrait: (context) => buildDesktop(context),
              landscape: (context) => buildMobile(context),
              mode: OrientationLayoutBuilderMode.portrait,
            ),
          ),
        ),
        const BottomNavigationBarWidget(),
      ],
    );
  }

  Widget buildMobile(BuildContext context) {
    return Column(
      children: [
        const AppBarHeader(),
        screenUtil.setHeight(85).ph,
        const StatusVpn(),
        const Spacer(),
        const InfoVpnWidget(),
        screenUtil.setHeight(30).ph,
      ],
    );
  }

  Widget buildDesktop(BuildContext context) {
    return SizedBox(
      height: screenUtil.screenHeight / 0.5,
      child: const Column(
        children: [
          AppBarHeader(),
          Spacer(),
          StatusVpn(),
          // Spacer(),
          InfoVpnWidget(),
          Spacer(),
        ],
      ),
    );
  }
}
