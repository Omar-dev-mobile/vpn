import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vpn/core/constants.dart';
import 'package:vpn/core/customs/app_bar_header.dart';
import 'package:vpn/core/customs/common_text_widget.dart';
import 'package:vpn/core/customs/drawer_widget.dart';
import 'package:vpn/core/customs/roundedButton.dart';
import 'package:vpn/core/shared/components/builder_bloc.dart';
import 'package:vpn/core/theme/theme.dart';
import 'package:vpn/features/select_country/presentation/cubit/country_cubit.dart';
import 'package:vpn/features/select_country/presentation/widgets/flag_row_widget.dart';
import 'package:vpn/locator.dart';

@RoutePage()
class SelectCountryScreen extends StatelessWidget {
  const SelectCountryScreen({super.key});
// BlocConsumer<CountryCubit, CountryState>(
//           listener: (context, state) {},
//           builder: (context, state) {
//             var countryCubit = CountryCubit.get(context);
//             return
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      body: BlocConsumer<CountryCubit, CountryState>(
        listener: (context, state) {},
        builder: (context, state) {
          var countryCubit = CountryCubit.get(context);
          return Column(
            children: [
              const AppBarHeader(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Builder(
                    builder: (context) {
                      if (state is CountriesLoadingState) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is CountriesErrorState) {
                        return Center(
                          child: CommonTextWidget(
                            text: state.error,
                            textAlign: TextAlign.center,
                            size: screenUtil.setSp(16),
                            fontWeight: FontWeight.w400,
                          ),
                        );
                      }
                      var countriesModel = countryCubit.countriesModel;
                      return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final vpnList =
                              countriesModel?.workStatus?.vpnList?[index];
                          return GestureDetector(
                            onTap: () {
                              countryCubit.selectVpn(vpnList);
                            },
                            child: FlagRowWidget(
                              ip: vpnList?.ip ?? "",
                              countryCode: vpnList?.countryId ?? "",
                              countryName: vpnList?.countryName ?? "",
                              isSelected:
                                  countryCubit.selectedVpn(vpnList?.ip ?? ""),
                              isStared: countryCubit
                                  .selectedFavoritesVpn(vpnList?.ip ?? ""),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Container(
                            height: 1,
                            color: kFlagDivider,
                          ),
                        ),
                        itemCount:
                            countriesModel?.workStatus?.vpnList?.length ?? 0,
                      );
                    },
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: RoundedButton(
                    name: 'Send', color: kSendButton, width: 130.0),
              ),
            ],
          );
        },
      ),
    );
  }
}
