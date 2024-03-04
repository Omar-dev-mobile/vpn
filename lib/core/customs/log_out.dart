import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vpn/core/constants.dart';
import 'package:vpn/core/customs/common_text_widget.dart';
import 'package:vpn/core/router/app_router.dart';
import 'package:vpn/core/shared/components/system_info_service.dart';
import 'package:vpn/core/shared/datasources/local/cache_helper.dart';
import 'package:vpn/core/theme/assets.dart';
import 'package:vpn/locator.dart';

class LogOut extends StatelessWidget {
  const LogOut({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          SvgPicture.asset(Assets.logout),
          14.pw,
          CommonTextWidget(
            text: 'Log out'.toUpperCase(),
            size: screenUtil.setSp(18),
            color: Theme.of(context).textTheme.labelLarge!.color,
            fontWeight: FontWeight.w300,
          ),
        ],
      ),
      onTap: () {
        locator<CacheHelper>().removeUser().then((value) {
          locator<SystemInfoService>().isLogin = false;
          locator<SystemInfoService>().user = null;
          context.pushRoute(const HomeRoute());
        });
      },
    );
  }
}
