import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vpn/core/customs/icon_mode.dart';
import 'package:vpn/core/router/app_router.dart';
import 'package:vpn/core/theme/assets.dart';
import 'package:vpn/core/theme/theme.dart';
import 'package:vpn/features/home/presentation/logic/main_cubit/main_cubit.dart';
import 'logo.dart';

class AppBarHeader extends StatelessWidget implements PreferredSizeWidget {
  const AppBarHeader({super.key, this.isClose = false, this.topPadding});
  final bool isClose;
  final double? topPadding;

  @override
  Size get preferredSize => const Size(1, 40);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: topPadding ?? 50, right: 20, left: 20),
      child: Row(
        children: [
          isClose
              ? IconButton(
                  onPressed: () async {
                    MainCubit.get(context).verifySubscription();

                    if (!(await context.maybePop())) {
                      context.replaceRoute(const MainRoute());
                    }
                  },
                  icon: SvgPicture.asset(
                    Assets.close,
                    height: 20,
                    width: 20,
                    color: kPrimary,
                  ),
                )
              : GestureDetector(
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
          const IconMode(),
        ],
      ),
    );
  }
}
