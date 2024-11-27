import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
<<<<<<< HEAD
=======
import 'package:package_info_plus/package_info_plus.dart';
>>>>>>> new_version
import 'package:rxdart/subjects.dart';
import 'package:vpn/core/native/VPNIOSManager.dart';
import 'package:vpn/core/shared/datasources/local/cache_helper.dart';
import 'package:vpn/features/auth/data/models/user_model.dart';
import 'package:vpn/features/home/data/models/data_service_acc_model.dart';
import 'package:vpn/features/select_country/data/models/countries_model.dart';
import 'package:vpn/locator.dart';

class SystemInfoService {
  // Singleton setup
  static final SystemInfoService _singleton = SystemInfoService._internal();
  factory SystemInfoService() {
    return _singleton;
  }
  SystemInfoService._internal();

  // SystemInfoService

  final BehaviorSubject<UserModel?> _userSubject =
      BehaviorSubject<UserModel?>.seeded(null);

  final BehaviorSubject<ConnectionStatus?> _connectionStatusSubject =
      BehaviorSubject<ConnectionStatus?>.seeded(null);

  final BehaviorSubject<bool> _isLoginSubject =
      BehaviorSubject<bool>.seeded(false);

  final BehaviorSubject<String?> _themeModeSubject =
      BehaviorSubject<String?>.seeded(null);

  final BehaviorSubject<VpnListModel?> _vpnServerSubject =
      BehaviorSubject<VpnListModel?>.seeded(null);

  final BehaviorSubject<WorkStatusAcc?> _vpnInfoSubject =
      BehaviorSubject<WorkStatusAcc?>.seeded(null);

  UserModel? get user => _userSubject.value;
  VpnListModel? get vpnServer => _vpnServerSubject.value;
  WorkStatusAcc? get vpnInfo => _vpnInfoSubject.value;

  ConnectionStatus? get connectionStatus => _connectionStatusSubject.value;
  String? get themeMode => _themeModeSubject.value;

  bool get isLogin => _isLoginSubject.value;

  set user(UserModel? value) => _userSubject.add(value);
  set isLogin(bool value) => _isLoginSubject.add(value);
  set vpnServer(VpnListModel? value) => _vpnServerSubject.add(value);
  set vpnInfo(WorkStatusAcc? value) => _vpnInfoSubject.add(value);
  set connectionStatus(ConnectionStatus? value) =>
      _connectionStatusSubject.add(value);

  set themeMode(String? value) => _themeModeSubject.add(value);

  String _lang = '';
  String _hardModel = '';
  String _hardOS = '';
  String _hardName = '';
  String _hardLModel = '';
  String _hardFModel = '';
<<<<<<< HEAD
=======
  String _appVersion = '';
>>>>>>> new_version

  String get getLang => _lang;
  String get getHardModel => _hardModel;
  String get getHardOS => _hardOS;
  String get getHardName => _hardName;
  String get getHardLModel => _hardLModel;
  String get getHardFModel => _hardFModel;
<<<<<<< HEAD
=======
  String get appVersion => _appVersion;
>>>>>>> new_version

  Future<void> getSystemInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    final language = getLocaleName;
<<<<<<< HEAD
=======
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

>>>>>>> new_version
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      _lang = language;
      _hardModel = androidInfo.model;
      _hardOS = androidInfo.version.release;
      _hardName = androidInfo.device;
      _hardLModel = androidInfo.product;
      _hardFModel = androidInfo.hardware;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
<<<<<<< HEAD
=======

>>>>>>> new_version
      _lang = language;
      _hardModel = iosInfo.model;
      _hardOS = iosInfo.systemVersion;
      _hardName = iosInfo.name;
      _hardLModel = iosInfo.localizedModel;
      _hardFModel = iosInfo.identifierForVendor ?? "";
    }
    user = await locator<CacheHelper>().getUser();
<<<<<<< HEAD
    isLogin = user != null;
    vpnServer = await locator<CacheHelper>().getVpnServer();
    print("vpnServer${vpnServer?.toJson()}");
=======
    _appVersion = packageInfo.version;
    isLogin = user != null;
    vpnServer = await locator<CacheHelper>().getVpnServer();
    print("vpnServer$_appVersion");
>>>>>>> new_version
    themeMode = await locator<CacheHelper>().getThemeMode();
  }

  String get getLocaleName {
    try {
      final localeStr = Platform.localeName;
      final loc = localeStr.split('_')[0];
      return loc;
    } catch (e) {
      return "en";
    }
  }

  void dispose() {
    user = null;
    connectionStatus = null;
    isLogin = false;
    themeMode = null;
    vpnServer = null;
    vpnInfo = null;
  }
}
