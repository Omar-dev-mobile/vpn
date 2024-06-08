import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vpn/core/constants.dart';
import 'package:vpn/core/customs/common_text_widget.dart';
import 'package:vpn/core/customs/custom_dialog.dart';
import 'package:vpn/core/router/app_router.dart';
import 'package:vpn/core/shared/components/system_info_service.dart';
import 'package:vpn/core/shared/datasources/local/cache_helper.dart';
import 'package:vpn/core/theme/assets.dart';
import 'package:vpn/features/home/presentation/logic/home_cubit/home_cubit.dart';
import 'package:vpn/features/home/presentation/logic/main_cubit/main_cubit.dart';
import 'package:vpn/features/settings/presentation/cubit/setting_cubit.dart';
import 'package:vpn/locator.dart';
import 'package:vpn/translations/locate_keys.g.dart';

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
            text: LocaleKeys.logOut.tr().toUpperCase(),
            size: 18,
            color: Theme.of(context).textTheme.labelLarge!.color,
            fontWeight: FontWeight.w300,
          ),
        ],
      ),
      onTap: () async {
        await customDialog(context, LocaleKeys.areYouSureYouWantToLogOut.tr(),
            () async {
          Navigator.pop(context);
          var res = await SettingCubit.get(context).logout(context);
          if (res) {
            locator<CacheHelper>().removeUser().then((value) async {
              final homeCubit = HomeCubit.get(context);
              if (homeCubit.isOnline && !homeCubit.inProgress) {
                homeCubit.stopVpnConnecting(context, showDialog: false);
              }
              locator<CacheHelper>().clearData();
              locator<SystemInfoService>().dispose();
              MainCubit.get(context).getDataServiceAcc();
              AutoRouter.of(context)
                  .pushAndPopUntil(const MainRoute(), predicate: (_) => false);
            });
          }
        });
      },
    );
  }
}
