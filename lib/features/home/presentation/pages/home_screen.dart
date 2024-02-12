import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vpn/core/customs/drawer_widget.dart';
import 'package:vpn/core/shared/components/system_info_service.dart';
import 'package:vpn/core/theme/assets.dart';
import 'package:vpn/features/home/presentation/pages/activate_tarif_screen.dart';
import 'package:vpn/features/home/presentation/widgets/home_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:vpn/locator.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isLogin = locator<SystemInfoService>().isLogin;
    return Scaffold(
      floatingActionButton: isLogin
          ? KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
              return isKeyboardVisible
                  ? const SizedBox.shrink()
                  : Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: GestureDetector(
                        onTap: () {
                          // tabsRouter.setActiveIndex(2);
                        },
                        child: SvgPicture.asset(Assets.homeIcon),
                      ),
                    );
            })
          : const SizedBox.shrink(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      drawer: const DrawerWidget(),
      body: isLogin ? const HomeWidget() : const ActivateTarifScreen(),
    );
  }
}
