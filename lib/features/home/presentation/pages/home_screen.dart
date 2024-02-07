import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vpn/core/customs/drawer_widget.dart';
import 'package:vpn/core/shared/usecases/system_info_service.dart';
import 'package:vpn/core/theme/assets.dart';
import 'package:vpn/features/home/presentation/bloc/home_cubit.dart';
import 'package:vpn/features/home/presentation/widgets/home_widget.dart';
import 'package:vpn/locator.dart';
import '../../../../core/customs/bottom_navigation_bar_widget.dart';
import '../../../../core/router/app_router.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: HomeCubit.get(context).scaffoldKey,
      floatingActionButton:
          KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
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
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      endDrawer: const DrawerWidget(),
      // resizeToAvoidBottomInset: true,
      // extendBody: true,
      body: const HomeWidget(),
    );
  }
}
