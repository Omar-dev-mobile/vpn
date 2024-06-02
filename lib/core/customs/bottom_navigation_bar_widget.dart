import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flag/flag_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vpn/core/customs/cis_widget.dart';
import 'package:vpn/core/router/app_router.dart';
import 'package:vpn/core/theme/assets.dart';
import 'package:vpn/features/home/presentation/widgets/nav_bar_widget.dart';
import 'package:vpn/features/select_country/presentation/cubit/country_cubit.dart';
import 'package:vpn/features/tarif/presentation/cubit/tarif/tarif_cubit.dart';
import 'package:vpn/translations/locate_keys.g.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var countryCubit = CountryCubit.get(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: Row(
        children: [
          BlocBuilder<CountryCubit, CountryState>(
            builder: (context, state) {
              var vpnServer = countryCubit.systemInfoService.vpnServer;
              return NavBarWidget(
                title: vpnServer?.name ?? "",
                icons: vpnServer != null &&
                        (vpnServer.countryId?.isNotEmpty ?? false)
                    ? (vpnServer.countryId ?? "de").toLowerCase() == 'country'
                        ? const CisWidget()
                        : Flag.fromString(
                            vpnServer.countryId ?? "de",
                            height: 32,
                            width: 32,
                            borderRadius: 10,
                          )
                    : const SizedBox(),
                onTap: () {
                  countryCubit.getCountriesList();
                  context.pushRoute(const SelectCountryRoute());
                },
              );
            },
          ),
          const Spacer(),
          NavBarWidget(
            title: LocaleKeys.plan.tr(),
            icons: SvgPicture.asset(Assets.person),
            onTap: () {
              TarifCubit.get(context).getTrials();
              context.replaceRoute(const TarifRoute());
            },
          ),
        ],
      ),
    );
  }
}
