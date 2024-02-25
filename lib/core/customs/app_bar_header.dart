import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vpn/core/shared/logic/theme_mode/theme_mode_cubit.dart';
import 'package:vpn/core/theme/assets.dart';
import 'package:vpn/locator.dart';
import 'logo.dart';

class AppBarHeader extends StatelessWidget {
  const AppBarHeader({super.key});

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
            child: SvgPicture.asset(Assets.nav),
          ),
          const Spacer(),
          const Logo(),
          const Spacer(),
          GestureDetector(
            onTap: () {
              ThemeModeCubit.get(context).toggleMode();
            },
            child: SvgPicture.asset(Assets.sun),
          ),
        ],
      ),
    );
  }
}
