import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vpn/core/theme/assets.dart';
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
          SvgPicture.asset(Assets.sun),
        ],
      ),
    );
  }
}
