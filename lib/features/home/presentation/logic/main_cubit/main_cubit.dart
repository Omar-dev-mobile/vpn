import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vpn/core/shared/components/system_info_service.dart';
import 'package:vpn/core/shared/datasources/local/cache_helper.dart';
import 'package:vpn/features/home/data/models/data_service_acc_model.dart';
import 'package:vpn/features/home/domain/usecases/home_usecase.dart';
import 'package:vpn/features/home/presentation/pages/home_screen.dart';
import 'package:vpn/features/select_country/data/models/countries_model.dart';
import 'package:vpn/features/tarif/presentation/cubit/tarif/tarif_cubit.dart';
import 'package:vpn/features/tarif/presentation/pages/tarif_screen.dart';
part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit(this._homeUseCase, this.cacheHelper) : super(MainInitial());
  final HomeUseCase _homeUseCase;
  final SystemInfoService _systemInfoService = SystemInfoService();
  final CacheHelper cacheHelper;

  static MainCubit get(context) => BlocProvider.of(context);

  String errorMessage = "";
  Future getDataServiceAcc() async {
    emit(LoadingGetDataServiceAccState());
    final res = await _homeUseCase.getDataServiceAcc();
    emit(await res.fold((l) {
      _systemInfoService.isLogin = false;
      return ErrorGetDataServiceAccState(l);
    }, (data) async {
      _systemInfoService.vpnInfo = data.workStatus;
      VpnListModel vpnList =
          VpnListModel.fromJson(data.workStatus?.vpnInfo?.toJson() ?? {});
      await cacheHelper.saveVpnServer(vpnList);
      _systemInfoService.vpnServer = vpnList;
      errorMessage = data.workStatus?.errorMessage ?? "";
      return SuccessGetDataServiceAccState(data);
    }));
  }

  Future verifySubscription() async {
    final res = await _homeUseCase.getDataServiceAcc();
    res.fold((l) {}, (data) async {
      final mess = data.workStatus?.errorMessage ?? "";
      errorMessage = mess;
      _systemInfoService.vpnInfo = data.workStatus;
      VpnListModel vpnList =
          VpnListModel.fromJson(data.workStatus?.vpnInfo?.toJson() ?? {});
      await cacheHelper.saveVpnServer(vpnList);
      _systemInfoService.vpnServer = vpnList;
      errorMessage = data.workStatus?.errorMessage ?? "";
      emit(LoadingGetDataServiceAccState());
      emit(SuccessGetDataServiceAccState(data));
    });
  }

  Widget getWidgetMain(
      DataServiceAccModel dataServiceAccModel, BuildContext context) {
    switch (dataServiceAccModel.workStatus?.errorAction) {
      case null || "":
        _systemInfoService.isLogin = true;
        cacheHelper.saveBaySubscription(
            dataServiceAccModel.workStatus?.userInfo?.tarifInfo?.productId ??
                "");
        return const HomeScreen();
      case "login" || "activate_tarif":
        _systemInfoService.isLogin = false;
        cacheHelper.saveBaySubscription("");
        TarifCubit.get(context).getTrials();
        return const TarifScreen();
      default:
        return Container();
    }
  }
}
