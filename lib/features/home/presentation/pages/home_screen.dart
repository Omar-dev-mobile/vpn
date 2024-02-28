import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vpn/core/constants.dart';
import 'package:vpn/core/customs/drawer_widget.dart';
import 'package:vpn/core/shared/components/system_info_service.dart';
import 'package:vpn/core/shared/logic/theme_mode/theme_mode_cubit.dart';
import 'package:vpn/core/theme/assets.dart';
import 'package:vpn/features/home/presentation/logic/home_cubit/home_cubit.dart';
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
    print("HomeScreen");
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
      body: isLogin
          ? BlocBuilder<ThemeModeCubit, ThemeModeState>(
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
            )
          : ActivateTarifScreen(
              textButton: "Activate tarif",
              title: "Need activate tarif to use VPN",
              onPressed: () {},
            ),
    );
  }
}
