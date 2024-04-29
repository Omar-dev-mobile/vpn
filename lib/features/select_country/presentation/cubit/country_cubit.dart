import 'package:auto_route/auto_route.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vpn/core/customs/custom_dialog.dart';
import 'package:vpn/core/router/app_router.dart';
import 'package:vpn/core/shared/components/system_info_service.dart';
import 'package:vpn/core/shared/datasources/local/cache_helper.dart';
import 'package:vpn/core/shared/extensions/extension.dart';
import 'package:vpn/features/home/presentation/logic/home_cubit/home_cubit.dart';
import 'package:vpn/features/home/presentation/logic/main_cubit/main_cubit.dart';
import 'package:vpn/features/select_country/data/models/countries_model.dart';
import 'package:vpn/features/select_country/domain/usecases/country_usecases.dart';
import 'package:vpn/features/tarif/presentation/cubit/tarif/tarif_cubit.dart';
import 'package:vpn/locator.dart';

part 'country_state.dart';

class CountryCubit extends Cubit<CountryState> {
  CountryCubit(this.countryUseCases) : super(CountryInitial());
  CountryUseCases countryUseCases;

  static CountryCubit get(context) => BlocProvider.of(context);
  final systemInfoService = locator<SystemInfoService>();
  final cacheHelper = locator<CacheHelper>();
  CountriesModel? countriesModel;

  Future getCountriesList() async {
    emit(CountriesLoadingState());
    favorites.addAll((await cacheHelper.getCountriesFavorite()) ?? []);
    favorites.unique();
    final res = await countryUseCases.getCountriesList();
    emit(
      res.fold((failure) => CountriesErrorState(failure), (data) {
        countriesModel = data;
        return const CountriesSuccessState();
      }),
    );
  }

  bool selectedVpn(String ip) => systemInfoService.vpnServer?.ip == ip;

  Future selectVpn(VpnListModel? vpnList, BuildContext context) async {
    var mainCubit = MainCubit.get(context);
    if (mainCubit.errorMessage.isNotEmpty) {
      await customDialog(context, mainCubit.errorMessage, () async {
        Navigator.pop(context);
        TarifCubit.get(context).getTrials();
        context.pushRoute(const TarifRoute());
      });
      return;
    }
    if (vpnList != null) {
      emit(CountriesSelectVpnLoadingState());
      await cacheHelper.saveVpnServer(vpnList).then((value) {});
      systemInfoService.vpnServer = vpnList;
      var mainCubit = MainCubit.get(context);
      await mainCubit.getDataServiceAcc().then((value) {
        var homeCubit = HomeCubit.get(context);
        if (homeCubit.isOnline) {
          homeCubit.stopVpnConnecting(context, showDialog: false).then((value) {
            homeCubit.getVpnConnecting(context);
          });
        }
      });
      emit(CountriesSelectVpnEndState());
    }
  }

  List<String> favorites = [];
  bool selectedFavoritesVpn(String ip) => favorites
      .firstWhere((element) => element == ip, orElse: () => "")
      .isNotEmpty;

  void selectFavoritesVpn(String ip) {
    emit(CountriesChangeLoadingState());
    var newFavorites = [...favorites, ip];
    newFavorites.unique();
    cacheHelper.saveCountriesFavorite(newFavorites);
    favorites.add(ip);
    emit(CountriesChangeSuccessState());
  }

  void removeFavoriteVpn(String ip) {
    emit(CountriesChangeLoadingState());
    favorites.remove(ip);

    print("objec$favorites");
    cacheHelper.saveCountriesFavorite(favorites);
    emit(CountriesChangeSuccessState());
  }
}
