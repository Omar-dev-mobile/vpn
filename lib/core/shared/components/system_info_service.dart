import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:rxdart/subjects.dart';
import 'package:vpn/core/shared/datasources/local/cache_helper.dart';
import 'package:vpn/features/auth/data/models/user_model.dart';
import 'package:vpn/locator.dart';

class SystemInfoService {
  // Singleton setup
  static final SystemInfoService _singleton = SystemInfoService._internal();
  factory SystemInfoService() {
    return _singleton;
  }
  SystemInfoService._internal();

  static BehaviorSubject<UserModel?> userSubject =
      BehaviorSubject<UserModel?>.seeded(null);

  static BehaviorSubject<bool> isLoginSubject =
      BehaviorSubject<bool>.seeded(false);

  UserModel? get user => userSubject.value;

  bool get isLogin => isLoginSubject.value || user != null;

  set user(UserModel? value) => userSubject.add(value);
  set isLogin(bool value) => isLoginSubject.add(value);

  String _lang = '';
  String _hardModel = '';
  String _hardOS = '';
  String _hardName = '';
  String _hardLModel = '';
  String _hardFModel = '';

  String get getLang => _lang;
  String get getHardModel => _hardModel;
  String get getHardOS => _hardOS;
  String get getHardName => _hardName;
  String get getHardLModel => _hardLModel;
  String get getHardFModel => _hardFModel;

  Future<void> getSystemInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    final language = getLocaleName;
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
      _lang = language;
      _hardModel = iosInfo.model;
      _hardOS = iosInfo.systemVersion;
      _hardName = iosInfo.name;
      _hardLModel = iosInfo.localizedModel;
      _hardFModel = iosInfo.identifierForVendor ?? "";
    }
    user = await locator<CacheHelper>().getUser();
    isLogin = user != null;
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
}