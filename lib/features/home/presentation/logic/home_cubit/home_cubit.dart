import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vpn/core/constants.dart';
import 'package:vpn/core/error/exceotion_native.dart';
import 'package:vpn/core/native/VPNIOSManager.dart';
import 'package:vpn/core/shared/components/snack_bar.dart';
import 'package:vpn/core/shared/components/system_info_service.dart';
import 'package:vpn/core/shared/usecases/network_info.dart';
import 'package:vpn/features/home/domain/usecases/home_usecase.dart';
import 'package:vpn/locator.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeUseCase _homeUseCase;
  HomeCubit(this._homeUseCase) : super(HomeInitial()) {
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
  SystemInfoService systemInfoService = locator<SystemInfoService>();
  final HandlerErrorNative _errorNative = locator<HandlerErrorNative>();

  String getStatusVpn() {
    switch (systemInfoService.connectionStatus?.status) {
      case StatusConnection.Online:
        return "Online";
      case StatusConnection.Stopped:
        return "Stopin";
      case StatusConnection.Connecting:
        return "Connecting";
      default:
        return "Offline";
    }
  }

  Future getVpnConnecting(context) async {
    emit(LoadingConnectVpnState());
    final res = await _errorNative.executeNativeHandleError(() async {
      await locator<VPNIOSManager>().configureVPN(
          username: 'usr9',
          serverAddress: '185.26.121.229',
          sharedSecret: 'ECHhFDpoN76jJ5VMc5Ko',
          password: 'aRMD2wYkN9MtzElPI');
    });
    await res.fold((l) async {
      CustomSnackBar.badSnackBar(context, l);
    }, (r) => null);
    emit(SuccessConnectVpnState());
  }

  Future stopVpnConnecting(context) async {
    emit(LoadingStopVpnState());
    await Future.delayed(const Duration(seconds: 2), () async {
      final res = await _errorNative.executeNativeHandleError(() async {
        await locator<VPNIOSManager>().stopTun();
      });
      res.fold((l) {
        CustomSnackBar.badSnackBar(context, l);
      }, (r) {
        CustomSnackBar.goodSnackBar(context, "Success stop vpn");
      });
    });
    emit(SuccessStoppedVpnState());
  }

  ConnectionStatus get statusConnection =>
      systemInfoService.connectionStatus ?? emptyConnectionStatus;

  bool get isOnline => statusConnection.status == StatusConnection.Online;
  bool get isOffline => statusConnection.status == StatusConnection.Offline;
  bool get isStopped => statusConnection.status == StatusConnection.Stopped;
  bool get isConnecting =>
      statusConnection.status == StatusConnection.Connecting;

  getInitStatus() async {
    emit(LoadingListenVpnState());
    final internet = await locator<NetworkChecker>().isConnected;
    if (!internet) {
      print("no internet");
      systemInfoService.connectionStatus = deInternetConnectionStatus;
    } else {
      systemInfoService.connectionStatus = await vpniosManager.getStatus();
    }
    emit(SuccessListenVpnState());
  }

  StreamSubscription<dynamic>? _vpnStatusSubscription;

  bool _active = true;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool get active => _active;

  void toggleActiveVpn() {
    emit(LoadingActiveVpnHomeState());
    _active = !_active;
    emit(SuccessActiveVpnHomeState());
  }
}
