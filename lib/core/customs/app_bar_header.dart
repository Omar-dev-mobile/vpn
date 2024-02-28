import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vpn/core/shared/logic/theme_mode/theme_mode_cubit.dart';
import 'package:vpn/core/theme/assets.dart';
import 'logo.dart';

class AppBarHeader extends StatelessWidget implements PreferredSizeWidget {
  const AppBarHeader({super.key});
  @override
  Size get preferredSize => const Size(1, 40);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50, right: 20, left: 20),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              try {
                Scaffold.of(context).openDrawer();
              } catch (e) {
                print(e);
              }
            },
            child: SvgPicture.asset(
              Assets.nav,
            ),
          ),
          const Spacer(),
          const Logo(),
          const Spacer(),
          GestureDetector(
            onTap: () {
              ThemeModeCubit.get(context).toggleMode();
            },
            child: SvgPicture.asset(
              Assets.sun,
              colorFilter: ColorFilter.mode(
                  Theme.of(context).textTheme.displaySmall!.color ??
                      Colors.white,
                  BlendMode.srcIn),
            ),
          ),
        ],
      ),
    );
  }
}
