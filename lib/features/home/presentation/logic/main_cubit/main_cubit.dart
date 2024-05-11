import 'package:auto_route/auto_route.dart';
import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vpn/core/router/app_router.dart';
import 'package:vpn/core/shared/components/system_info_service.dart';
import 'package:vpn/core/shared/datasources/local/cache_helper.dart';
import 'package:vpn/features/home/data/models/data_service_acc_model.dart';
import 'package:vpn/features/home/domain/usecases/home_usecase.dart';
import 'package:vpn/features/home/presentation/pages/activate_tarif_screen.dart';
import 'package:vpn/features/home/presentation/pages/home_screen.dart';
import 'package:vpn/features/select_country/data/models/countries_model.dart';
import 'package:vpn/features/tarif/presentation/cubit/tarif/tarif_cubit.dart';
import 'package:vpn/translations/locate_keys.g.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit(this._homeUseCase, this.cacheHelper) : super(MainInitial());
  final HomeUseCase _homeUseCase;
  final SystemInfoService _systemInfoService = SystemInfoService();
  final CacheHelper cacheHelper;

  static MainCubit get(context) => BlocProvider.of(context);

  String errorMessage = '';
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
      if (errorMessage != mess) {
        errorMessage = mess;
        _systemInfoService.vpnInfo = data.workStatus;
        VpnListModel vpnList =
            VpnListModel.fromJson(data.workStatus?.vpnInfo?.toJson() ?? {});
        await cacheHelper.saveVpnServer(vpnList);
        _systemInfoService.vpnServer = vpnList;
        errorMessage = data.workStatus?.errorMessage ?? "";
        emit(LoadingGetDataServiceAccState());
        emit(SuccessGetDataServiceAccState(data));
      }
    });
  }

  Widget getWidgetMain(
      DataServiceAccModel dataServiceAccModel, BuildContext context) {
    switch (dataServiceAccModel.workStatus?.errorAction) {
      case null || "":
        _systemInfoService.isLogin = true;
        return const HomeScreen();
      case "login":
        _systemInfoService.isLogin = false;
        return ActivateTarifScreen(
          textButton: LocaleKeys.signIn.tr(),
          title: dataServiceAccModel.workStatus?.errorMessage ?? "",
          onPressed: () async {
            context.pushRoute(const LoginRoute());
            // FlutterVpn.disconnect();
            // FlutterVpn.connectIkev2EAP(
            //     server: "128.140.61.187",
            //     password: "N2gzEt5RoovqxtgfsAmw",
            //     username: "usr5",
            //     name: "usr5",
            //     port: 500);
            // await FlutterVpn.connectIkev2EAP(
            //   server: "95.217.4.112",
            //   password: "dcisf09re23we",
            //   username: "user1",
            //   name: "user1",
            // );
            // username=user1
            // password=dcisf09re23we
            // IP=95.217.4.112
            // port=500 или 4500
            // var newState = await FlutterVpn.charonErrorState;
            // print("objectobjectobjectobjectobjectobject$newState");
          },
        );
      case "activate_tarif":
        _systemInfoService.isLogin = true;
        cacheHelper.saveBaySubscription(
            dataServiceAccModel.workStatus?.userInfo?.tarifInfo?.productId ??
                "");
        return ActivateTarifScreen(
          textButton: LocaleKeys.activatePlan.tr(),
          title: dataServiceAccModel.workStatus?.errorMessage ?? "",
          onPressed: () {
            TarifCubit.get(context).getTrials();
            context.pushRoute(const TarifRoute());
          },
        );
      default:
        return Container();
    }
  }
}
