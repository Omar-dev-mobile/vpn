import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vpn/core/constants.dart';
import 'package:vpn/core/customs/log_out.dart';
import 'package:vpn/core/router/app_router.dart';
import 'package:vpn/core/shared/components/system_info_service.dart';
import 'package:vpn/core/shared/logic/theme_mode/theme_mode_cubit.dart';
import 'package:vpn/core/theme/assets.dart';
import 'package:vpn/features/home/presentation/logic/main_cubit/main_cubit.dart';
import 'package:vpn/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:vpn/features/select_country/presentation/cubit/country_cubit.dart';
import 'package:vpn/locator.dart';
import 'package:vpn/translations/locate_keys.g.dart';

import 'list_title_drawer_widget.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    String activeRouteName = AutoRouter.of(context).topRoute.name;
    final systemInfoService = locator<SystemInfoService>();
    print(activeRouteName);
    return Drawer(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      width: double.infinity,
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Scaffold.of(context).closeDrawer();
                  },
                  icon: Icon(
                    Icons.clear,
                    color: primaryColor,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    ThemeModeCubit.get(context).toggleMode();
                  },
                  child: SvgPicture.asset(Assets.sun),
                ),
              ],
            ),
            screenUtil.setHeight(25).ph,
            ListTitleDrawerWidget(
              title: LocaleKeys.home
                  .tr(), //MainCubit.get(context).getDataServiceAcc();
              onTap: () {
                if (activeRouteName != MainRoute.name) {
                  MainCubit.get(context).getDataServiceAcc();
                }
                context.pushRoute(const MainRoute());
              },
              isActive: activeRouteName == MainRoute.name,
            ),
            if (systemInfoService.isLogin)
              ListTitleDrawerWidget(
                title: LocaleKeys.profile.tr(),
                onTap: () {
                  locator<ProfileCubit>().getProfile();
                  context.pushRoute(const ProfileRoute());
                },
                isActive: activeRouteName == ProfileRoute.name,
              ),
            if (systemInfoService.isLogin)
              ListTitleDrawerWidget(
                title: LocaleKeys.selectCountry.tr(),
                onTap: () {
                  if (activeRouteName != SelectCountryRoute.name) {
                    locator<CountryCubit>().getCountriesList();
                  }
                  context.pushRoute(const SelectCountryRoute());
                },
                isActive: activeRouteName == SelectCountryRoute.name,
              ),
            if (systemInfoService.isLogin)
              ListTitleDrawerWidget(
                title: LocaleKeys.plans.tr(),
                onTap: () {
                  context.pushRoute(const TarifRoute());
                },
                isActive: activeRouteName == TarifRoute.name,
              ),
            ListTitleDrawerWidget(
              title: LocaleKeys.about.tr(),
              onTap: () {
                context.pushRoute(const AboutRoute());
              },
              isActive: activeRouteName == AboutRoute.name,
            ),
            screenUtil.setHeight(30).ph,
            if (systemInfoService.isLogin) const LogOut(),
          ],
        ),
      ),
    );
  }
}
