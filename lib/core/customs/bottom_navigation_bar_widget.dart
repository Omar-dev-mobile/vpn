import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flag/flag_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vpn/core/constants.dart';
import 'package:vpn/core/router/app_router.dart';
import 'package:vpn/core/shared/components/system_info_service.dart';
import 'package:vpn/core/theme/assets.dart';
import 'package:vpn/features/home/presentation/widgets/nav_bar_widget.dart';
import 'package:vpn/features/select_country/presentation/cubit/country_cubit.dart';
import 'package:vpn/locator.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: SvgPicture.asset(
            Assets.navBar,
            width: screenUtil.screenWidth,
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 30, top: 20),
            child: BlocBuilder<CountryCubit, CountryState>(
              builder: (context, state) {
                var vpnServer = locator<SystemInfoService>().vpnServer;
                return NavBarWidget(
                  title: vpnServer?.countryName ?? "",
                  icons: vpnServer != null
                      ? Flag.fromString(
                          vpnServer.countryId ?? "",
                          height: 32,
                          width: 32,
                          borderRadius: 10,
                        )
                      : const SizedBox(),
                  onTap: () {
                    locator<CountryCubit>().getCountriesList();
                    context.pushRoute(const SelectCountryRoute());
                  },
                );
              },
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 30, top: 20),
            child: NavBarWidget(
              title: 'Tarif',
              icons: SvgPicture.asset(Assets.person),
              onTap: () {
                context.pushRoute(const TarifRoute());
              },
            ),
          ),
        ),
      ],
    );
  }
}
