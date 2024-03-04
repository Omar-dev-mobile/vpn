import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vpn/core/constants.dart';
import 'package:vpn/core/customs/drawer_widget.dart';
import 'package:vpn/core/shared/logic/theme_mode/theme_mode_cubit.dart';
import 'package:vpn/core/theme/assets.dart';
import 'package:vpn/features/home/presentation/logic/home_cubit/home_cubit.dart';
import 'package:vpn/features/home/presentation/widgets/home_widget.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeCubit = HomeCubit.get(context);
    return Scaffold(
      drawer: const DrawerWidget(),
      floatingActionButton: KeyboardVisibilityBuilder(
        builder: (context, isKeyboardVisible) {
          return isKeyboardVisible
              ? const SizedBox.shrink()
              : Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: GestureDetector(
                    onTap: () {
                      if (homeCubit.isOnline) {
                        homeCubit.stopVpnConnecting(context);
                      } else {
                        homeCubit.getVpnConnecting(context);
                      }
                    },
                    child: SvgPicture.asset(Assets.homeIcon),
                  ),
                );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: BlocBuilder<ThemeModeCubit, ThemeModeState>(
        builder: (context, state) {
          var themeMode = ThemeModeCubit.get(context);
          return Container(
            height: screenUtil.screenHeight,
            width: screenUtil.screenWidth,
            decoration: BoxDecoration(
                image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(themeMode.themeMode == 'light'
                  ? Assets.navBarLight
                  : Assets.navBarDark),
            )),
            child: const HomeWidget(),
          );
        },
      ),
    );
  }
}
