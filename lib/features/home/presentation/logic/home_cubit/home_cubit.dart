import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vpn/core/constants.dart';
import 'package:vpn/core/error/exceotion_native.dart';
import 'package:vpn/core/native/VPNIOSManager.dart';
import 'package:vpn/core/shared/components/snack_bar.dart';
import 'package:vpn/core/shared/components/system_info_service.dart';
import 'package:vpn/core/shared/datasources/local/cache_helper.dart';
import 'package:vpn/features/settings/presentation/pages/app_usage_screen.dart';
import 'package:vpn/locator.dart';
import 'package:vpn/translations/locate_keys.g.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial()) {
    emit(LoadingInitialStatusHomeState());
    getInitStatus();
    _vpnStatusSubscription =
        locator<VPNIOSManager>().vpnStatusStream().listen((event) async {
      emit(LoadingListenVpnState());
      print("event ${event.status}");
      systemInfoService.connectionStatus = event;
      emit(SuccessListenVpnState());
    });
    emit(SuccessInitialStatusHomeState());
  }

  @override
  Future<void> close() {
    _vpnStatusSubscription?.cancel();
    return super.close();
  }

  static HomeCubit get(context) => BlocProvider.of(context);
  VPNIOSManager vpniosManager = locator<VPNIOSManager>();
  SystemInfoService systemInfoService = SystemInfoService();
  final HandlerErrorNative _handlerErrorNative = locator<HandlerErrorNative>();
  StreamSubscription<dynamic>? _vpnStatusSubscription;
  ConnectionStatus get statusConnection =>
      systemInfoService.connectionStatus ?? emptyConnectionStatus;

  bool get isOnline => statusConnection.status == StatusConnection.Online;
  bool get isOffline => statusConnection.status == StatusConnection.Offline;
  bool get isStopped => statusConnection.status == StatusConnection.Stopped;
  bool get isConnecting =>
      statusConnection.status == StatusConnection.Connecting;
  bool inProgress = false;
  String getStatusVpn() {
    switch (systemInfoService.connectionStatus?.status) {
      case StatusConnection.Online:
        return LocaleKeys.online.tr();
      case StatusConnection.Stopped:
        return LocaleKeys.disconnected.tr();
      case StatusConnection.Connecting:
        return LocaleKeys.connecting.tr();
      default:
        return LocaleKeys.offline.tr();
    }
  }

  Future getVpnConnecting(context) async {
    bool? vpnChoice = await locator<CacheHelper>().getVpnAgreementChoice();
    if (vpnChoice == null || vpnChoice == false) {
      showAppUsageModal(context, confirmVpnConnecting);
    } else {
      confirmVpnConnecting(context);
    }
  }

  Future confirmVpnConnecting(context) async {
    emit(LoadingConnectVpnState());
    inProgress = true;
    final res = await _handlerErrorNative.executeNativeHandleError(() async {
      locator<VPNIOSManager>().configureVPN(
        username: systemInfoService.vpnInfo?.u ?? "",
        serverAddress: systemInfoService.vpnInfo?.s ?? "",
        sharedSecret: systemInfoService.vpnInfo?.k ?? "",
        password: systemInfoService.vpnInfo?.p ?? "",
      );
    });
    await res.fold((l) => CustomSnackBar.badSnackBar(context, l), (r) => null);
    emit(SuccessConnectVpnState());
    // when completed status to connect
    await Future.delayed(const Duration(seconds: 4)).then((value) {
      inProgress = false;
      emit(ProgressVpnHomeState());
    });
  }

  Future stopVpnConnecting(context, {bool showDialog = true}) async {
    emit(LoadingStopVpnState());
    inProgress = true;
    await Future.delayed(const Duration(seconds: 2), () async {
      final res = await _handlerErrorNative.executeNativeHandleError(() async {
        await locator<VPNIOSManager>().stopTun();
      });
      res.fold((l) {
        CustomSnackBar.badSnackBar(context, l);
      }, (r) {
        if (showDialog) {
          CustomSnackBar.goodSnackBar(
              context, LocaleKeys.vPNHasBeenDisconnected.tr());
        }
      });
    });
    emit(SuccessStoppedVpnState());
    // when completed status to disconnect
    await Future.delayed(const Duration(seconds: 4)).then((value) {
      inProgress = false;
      emit(ProgressVpnHomeState());
    });
  }

  getInitStatus() async {
    emit(LoadingListenVpnState());
    systemInfoService.connectionStatus = await vpniosManager.getStatus();
    emit(SuccessListenVpnState());
  }
}
