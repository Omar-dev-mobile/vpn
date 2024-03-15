import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vpn/core/constants.dart';
import 'package:vpn/core/customs/common_text_widget.dart';
import 'package:vpn/core/router/app_router.dart';
import 'package:vpn/core/shared/components/system_info_service.dart';
import 'package:vpn/core/shared/datasources/local/cache_helper.dart';
import 'package:vpn/core/theme/assets.dart';
import 'package:vpn/features/settings/presentation/cubit/setting_cubit.dart';
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
      onTap: () async {
        await showDialog(
            context: context,
            builder: (context) {
              return CupertinoAlertDialog(
                content: const Text(
                  "Are you sure you want to go out?",
                  style: TextStyle(fontSize: 16),
                ),
                actions: [
                  CupertinoDialogAction(
                    child: const Text('No'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  CupertinoDialogAction(
                    onPressed: () async {
                      var res = await SettingCubit.get(context).logout(context);
                      if (res) {
                        locator<CacheHelper>().removeUser().then((value) {
                          locator<SystemInfoService>().dispose();
                          context.pushRoute(const MainRoute());
                        });
                      }
                      Navigator.pop(context);
                    },
                    child: const Text('Yes'),
                  ),
                ],
              );
            });
      },
    );
  }
}
