import 'package:auto_route/auto_route.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vpn/flutter_vpn.dart';
import 'package:flutter_vpn/state.dart';
import 'package:vpn/core/router/app_router.dart';
import 'package:vpn/core/shared/components/system_info_service.dart';
import 'package:vpn/features/home/data/models/data_service_acc_model.dart';
import 'package:vpn/features/home/domain/usecases/home_usecase.dart';
import 'package:vpn/features/home/presentation/pages/activate_tarif_screen.dart';
import 'package:vpn/features/home/presentation/pages/home_screen.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit(this._homeUseCase, this._systemInfoService) : super(MainInitial());
  final HomeUseCase _homeUseCase;
  final SystemInfoService _systemInfoService;

  static MainCubit get(context) => BlocProvider.of(context);
  Future getDataServiceAcc() async {
    emit(LoadingGetDataServiceAccState());
    final res = await _homeUseCase.getDataServiceAcc();
    emit(res.fold((l) {
      _systemInfoService.isLogin = false;
      return ErrorGetDataServiceAccState(l);
    }, (data) {
      _systemInfoService.vpnInfo = data.workStatus;
      return SuccessGetDataServiceAccState(data);
    }));
  }

  Widget getWidgetMain(
      DataServiceAccModel dataServiceAccModel, BuildContext context) {
    switch (dataServiceAccModel.workStatus!.errorAction) {
      case null:
        _systemInfoService.isLogin = true;
        return const HomeScreen();
      case "login":
        _systemInfoService.isLogin = false;
        return ActivateTarifScreen(
          textButton: "Sing in",
          title: dataServiceAccModel.workStatus?.errorMessage ?? "",
          onPressed: () async {
            // context.pushRoute(const LoginRoute());
            FlutterVpn.disconnect();
            // FlutterVpn.connectIkev2EAP(
            //     server: "128.140.61.187",
            //     password: "N2gzEt5RoovqxtgfsAmw",
            //     username: "usr5",
            //     name: "usr5",
            //     port: 500);
            await FlutterVpn.connectIkev2EAP(
              server: "95.217.4.112",
              password: "dcisf09re23we",
              username: "user1",
              name: "user1",
            );
            // username=user1
            // password=dcisf09re23we
            // IP=95.217.4.112
            // port=500 или 4500
            var newState = await FlutterVpn.charonErrorState;
            print("objectobjectobjectobjectobjectobject$newState");
          },
        );
      case "activate_tarif":
        return ActivateTarifScreen(
          textButton: "Activate tarif",
          title: dataServiceAccModel.workStatus?.errorMessage ?? "",
          onPressed: () {
            context.pushRoute(const TarifRoute());
          },
        );
      default:
        return Container();
    }
  }
}
