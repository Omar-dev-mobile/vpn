import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vpn/core/constants.dart';
import 'package:vpn/core/customs/common_text_widget.dart';
import 'package:vpn/core/router/app_router.dart';
import 'package:vpn/core/shared/components/system_info_service.dart';
import 'package:vpn/core/shared/datasources/local/cache_helper.dart';
import 'package:vpn/core/shared/logic/theme_mode/theme_mode_cubit.dart';
import 'package:vpn/core/theme/assets.dart';
import 'package:vpn/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:vpn/features/select_country/presentation/cubit/country_cubit.dart';
import 'package:vpn/locator.dart';

import 'list_title_drawer_widget.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    String activeRouteName = AutoRouter.of(context).topRoute.name;
    final SystemInfoService systemInfoService = SystemInfoService();
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
                    context.popRoute();
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
              title: 'Home',
              onTap: () {
                context.pushRoute(const MainRoute());
              },
              isActive: activeRouteName == HomeRoute.name,
            ),
            if (systemInfoService.isLogin)
              ListTitleDrawerWidget(
                title: 'Profile',
                onTap: () {
                  locator<ProfileCubit>().getProfile();
                  context.pushRoute(const ProfileRoute());
                },
              ),
            if (systemInfoService.isLogin)
              ListTitleDrawerWidget(
                title: 'Select country',
                onTap: () {
                  locator<CountryCubit>().getCountriesList();
                  context.pushRoute(const SelectCountryRoute());
                },
                isActive: activeRouteName == SelectCountryRoute.name,
              ),
            if (systemInfoService.isLogin)
              ListTitleDrawerWidget(
                title: 'Tarifs',
                onTap: () {
                  context.pushRoute(const TarifRoute());
                },
                isActive: activeRouteName == TarifRoute.name,
              ),
            ListTitleDrawerWidget(
              title: 'Safety',
              onTap: () {},
            ),
            ListTitleDrawerWidget(
              title: 'About',
              onTap: () {
                context.pushRoute(const AboutRoute());

              },
            ),
            screenUtil.setHeight(30).ph,
            if (systemInfoService.isLogin)
              ListTile(
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
              ),
          ],
        ),
      ),
    );
  }
}
