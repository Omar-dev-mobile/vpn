import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vpn/core/constants.dart';
import 'package:vpn/core/customs/delete_account.dart';
import 'package:vpn/core/customs/icon_mode.dart';
import 'package:vpn/core/customs/log_out.dart';
import 'package:vpn/core/router/app_router.dart';
import 'package:vpn/core/shared/components/system_info_service.dart';
import 'package:vpn/features/home/presentation/logic/main_cubit/main_cubit.dart';
import 'package:vpn/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:vpn/features/select_country/presentation/cubit/country_cubit.dart';
import 'package:vpn/features/tarif/presentation/cubit/tarif/tarif_cubit.dart';
import 'package:vpn/locator.dart';
import 'package:vpn/translations/locate_keys.g.dart';
import 'list_title_drawer_widget.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    String activeRouteName = AutoRouter.of(context).topRoute.name;
    final systemInfoService = SystemInfoService();

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
                const IconMode(),
              ],
            ),
            screenUtil.setHeight(25).ph,
            ListTitleDrawerWidget(
              title: LocaleKeys.home.tr(),
              onTap: () {
                if (activeRouteName != MainRoute.name &&
                    systemInfoService.isLogin) {
                  MainCubit.get(context).verifySubscription();
                }
                Navigator.pop(context);
                context.replaceRoute(const MainRoute());
              },
              isActive: activeRouteName == MainRoute.name,
            ),
            // if (systemInfoService.isLogin)
            BlocBuilder<MainCubit, MainState>(
              builder: (context, state) {
                return ListTitleDrawerWidget(
                  title: LocaleKeys.profile.tr(),
                  onTap: () {
                    // Navigator.pop(context);
                    locator<ProfileCubit>().getProfile(context);
                    context.replaceRoute(const ProfileRoute());
                  },
                  isActive: activeRouteName == ProfileRoute.name ||
                      activeRouteName == LoginRoute.name,
                );
              },
            ),
            // if (systemInfoService.isLogin)
            ListTitleDrawerWidget(
              title: LocaleKeys.selectCountry.tr(),
              onTap: () {
                if (activeRouteName != SelectCountryRoute.name) {
                  locator<CountryCubit>().getCountriesList();
                }
                Navigator.pop(context);
                context.replaceRoute(const SelectCountryRoute());
              },
              isActive: activeRouteName == SelectCountryRoute.name,
            ),
            // if (systemInfoService.isLogin)
            ListTitleDrawerWidget(
              title: LocaleKeys.plans.tr(),
              onTap: () {
                TarifCubit.get(context).getTrials();
                // Navigator.pop(context);
                context.replaceRoute(const TarifRoute());
              },
              isActive: activeRouteName == TarifRoute.name,
            ),
            ListTitleDrawerWidget(
              title: LocaleKeys.about.tr(),
              onTap: () {
                Navigator.pop(context);
                context.replaceRoute(const AboutRoute());
              },
              isActive: activeRouteName == AboutRoute.name,
            ),
            screenUtil.setHeight(30).ph,
            if (systemInfoService.isLogin) const LogOut(),
            if (systemInfoService.isLogin) const DeleteAccount(),
          ],
        ),
      ),
    );
  }
}
