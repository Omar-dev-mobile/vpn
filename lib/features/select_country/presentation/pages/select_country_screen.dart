import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:flutter/widgets.dart';
=======
>>>>>>> new_version
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vpn/core/customs/app_bar_header.dart';
import 'package:vpn/core/customs/custom_error.dart';
import 'package:vpn/core/customs/drawer_widget.dart';
import 'package:vpn/core/router/app_router.dart';
import 'package:vpn/core/theme/theme.dart';
import 'package:vpn/features/select_country/presentation/cubit/country_cubit.dart';
import 'package:vpn/features/select_country/presentation/widgets/flag_row_widget.dart';
import 'package:vpn/features/select_country/presentation/widgets/progress_indicator_country.dart';

@RoutePage()
class SelectCountryScreen extends StatelessWidget {
  const SelectCountryScreen({super.key});
<<<<<<< HEAD
  @override
  Widget build(BuildContext context) {
    var countryCubit = CountryCubit.get(context);
=======

  @override
  Widget build(BuildContext context) {
    var countryCubit = CountryCubit.get(context);

>>>>>>> new_version
    return RefreshIndicator(
      onRefresh: () async {
        await countryCubit.getCountriesList(isRefresh: true);
      },
      child: Scaffold(
        drawer: const DrawerWidget(),
        body: BlocConsumer<CountryCubit, CountryState>(
          listener: (context, state) {
            if (state is CountriesSelectVpnEndState) {
              context.replaceRoute(const MainRoute());
            }
          },
          builder: (context, state) {
            return Column(
              children: [
<<<<<<< HEAD
                const AppBarHeader(
                  isClose: true,
                ),
=======
                const AppBarHeader(isClose: true),
>>>>>>> new_version
                ProgressIndicatorCountry(
                    progressing: state is CountriesSelectVpnLoadingState),
                Expanded(
                  child: Builder(
                    builder: (context) {
                      if (state is CountriesLoadingState) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is CountriesErrorState) {
                        return CustomError(
                          error: state.error,
                          onPressed: () {
<<<<<<< HEAD
                            CountryCubit.get(context).getCountriesList();
                          },
                        );
                      }
                      var countriesModel = countryCubit.countriesModel;
                      return ListView.separated(
                        shrinkWrap: true,
                        // physics: const NeverScrollableScrollPhysics(),
=======
                            countryCubit.getCountriesList();
                          },
                        );
                      }

                      var countriesModel = countryCubit.countriesModel;
                      return ListView.separated(
                        shrinkWrap: true,
>>>>>>> new_version
                        itemBuilder: (context, index) {
                          final vpnList =
                              countriesModel?.workStatus?.vpnList?[index];
                          return InkWell(
                            onTap: () {
                              if (state is! CountriesSelectVpnLoadingState &&
                                  countryCubit
                                          .systemInfoService.vpnServer?.id !=
                                      vpnList?.id) {
                                countryCubit.selectVpn(vpnList, context);
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 20),
                              child: FlagRowWidget(
                                ip: vpnList?.ip ?? "",
                                countryCode: vpnList?.countryId ?? "",
                                countryName: vpnList?.countryName ?? "",
                                isSelected:
                                    countryCubit.selectedVpn(vpnList?.ip ?? ""),
                                isStared: countryCubit
                                    .selectedFavoritesVpn(vpnList?.ip ?? ""),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => Container(
                          height: 1,
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          color: kFlagDivider,
                        ),
                        itemCount:
                            countriesModel?.workStatus?.vpnList?.length ?? 0,
                      );
                    },
                  ),
                ),
<<<<<<< HEAD
                // const Padding(
                //   padding: EdgeInsets.only(bottom: 20),
                //   child: RoundedButton(
                //       name: 'Send', color: kSendButton, width: 130.0),
                // ),
=======
>>>>>>> new_version
              ],
            );
          },
        ),
      ),
    );
  }
}
