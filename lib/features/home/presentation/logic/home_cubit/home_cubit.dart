import 'dart:async';
<<<<<<< HEAD

=======
>>>>>>> new_version
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vpn/core/constants.dart';
import 'package:vpn/core/error/exceotion_native.dart';
import 'package:vpn/core/native/VPNIOSManager.dart';
import 'package:vpn/core/shared/components/snack_bar.dart';
import 'package:vpn/core/shared/components/system_info_service.dart';
<<<<<<< HEAD
import 'package:vpn/core/shared/utils/network_info.dart';
import 'package:vpn/locator.dart';
import 'package:vpn/translations/locate_keys.g.dart';
=======
import 'package:vpn/core/shared/datasources/local/cache_helper.dart';
import 'package:vpn/features/settings/presentation/pages/app_usage_screen.dart';
import 'package:vpn/locator.dart';
import 'package:vpn/translations/locate_keys.g.dart';

>>>>>>> new_version
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial()) {
<<<<<<< HEAD
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
=======
    _initialize();
  }

  final VPNIOSManager _vpniosManager = locator<VPNIOSManager>();
  final SystemInfoService systemInfoService = SystemInfoService();
  final HandlerErrorNative _handlerErrorNative = locator<HandlerErrorNative>();
  StreamSubscription<dynamic>? _vpnStatusSubscription;
  bool inProgress = false;

  static HomeCubit get(context) => BlocProvider.of(context);

  void _initialize() {
    emit(LoadingInitialStatusHomeState());
    _getInitStatus();
    _subscribeToVpnStatus();
    emit(SuccessInitialStatusHomeState());
  }

  void _subscribeToVpnStatus() {
    _vpnStatusSubscription =
        _vpniosManager.vpnStatusStream().listen((event) async {
      emit(LoadingListenVpnState());
      systemInfoService.connectionStatus = event;
      emit(SuccessListenVpnState());
    });
>>>>>>> new_version
  }

  @override
  Future<void> close() {
    _vpnStatusSubscription?.cancel();
    return super.close();
  }

<<<<<<< HEAD
  static HomeCubit get(context) => BlocProvider.of(context);
  VPNIOSManager vpniosManager = locator<VPNIOSManager>();
  SystemInfoService systemInfoService = SystemInfoService();
  final HandlerErrorNative _handlerErrorNative = locator<HandlerErrorNative>();
  StreamSubscription<dynamic>? _vpnStatusSubscription;
=======
>>>>>>> new_version
  ConnectionStatus get statusConnection =>
      systemInfoService.connectionStatus ?? emptyConnectionStatus;

  bool get isOnline => statusConnection.status == StatusConnection.Online;
  bool get isOffline => statusConnection.status == StatusConnection.Offline;
  bool get isStopped => statusConnection.status == StatusConnection.Stopped;
  bool get isConnecting =>
      statusConnection.status == StatusConnection.Connecting;
<<<<<<< HEAD
  bool inProgress = false;
  String getStatusVpn() {
    switch (systemInfoService.connectionStatus?.status) {
=======

  String getStatusVpn() {
    switch (statusConnection.status) {
>>>>>>> new_version
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

<<<<<<< HEAD
  Future getVpnConnecting(context) async {
    emit(LoadingConnectVpnState());
    inProgress = true;
    final res = await _handlerErrorNative.executeNativeHandleError(() async {
      locator<VPNIOSManager>().configureVPN(
=======
  Future<void> getVpnConnecting(BuildContext context) async {
    bool? vpnChoice = await locator<CacheHelper>().getVpnAgreementChoice();
    if (vpnChoice == null || vpnChoice == false) {
      showAppUsageModal(context, confirmVpnConnecting);
    } else {
      confirmVpnConnecting(context);
    }
  }

  Future<void> confirmVpnConnecting(BuildContext context) async {
    emit(LoadingConnectVpnState());
    inProgress = true;

    final result = await _handlerErrorNative.executeNativeHandleError(() async {
      await _vpniosManager.configureVPN(
>>>>>>> new_version
        username: systemInfoService.vpnInfo?.u ?? "",
        serverAddress: systemInfoService.vpnInfo?.s ?? "",
        sharedSecret: systemInfoService.vpnInfo?.k ?? "",
        password: systemInfoService.vpnInfo?.p ?? "",
      );
    });
<<<<<<< HEAD
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
=======

    await result.fold(
      (failure) => CustomSnackBar.badSnackBar(context, failure),
      (_) => null,
    );

    emit(SuccessConnectVpnState());
    await _simulateProgress();
  }

  Future<void> stopVpnConnecting(BuildContext context,
      {bool showDialog = true}) async {
    emit(LoadingStopVpnState());
    inProgress = true;

    await Future.delayed(const Duration(seconds: 2), () async {
      final result =
          await _handlerErrorNative.executeNativeHandleError(() async {
        await _vpniosManager.stopTun();
      });

      result.fold(
        (failure) => CustomSnackBar.badSnackBar(context, failure),
        (_) {
          if (showDialog) {
            CustomSnackBar.goodSnackBar(
                context, LocaleKeys.vPNHasBeenDisconnected.tr());
          }
        },
      );
    });

    emit(SuccessStoppedVpnState());
    await _simulateProgress();
  }

  Future<void> _getInitStatus() async {
    emit(LoadingListenVpnState());
    systemInfoService.connectionStatus = await _vpniosManager.getStatus();
    emit(SuccessListenVpnState());
  }

  Future<void> _simulateProgress() async {
    await Future.delayed(const Duration(seconds: 4));
    inProgress = false;
    emit(ProgressVpnHomeState());
  }
>>>>>>> new_version
}
