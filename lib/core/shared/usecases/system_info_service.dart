import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class SystemInfoService {
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
    final language = getlocaleName;
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
  }

  String get getlocaleName {
    try {
      final localeStr = Platform.localeName;
      final loc = localeStr.split('_')[0];
      return loc;
    } catch (e) {
      return "en";
    }
  }

  // Singleton setup
  static final SystemInfoService _singleton = SystemInfoService._internal();

  factory SystemInfoService() {
    return _singleton;
  }
  SystemInfoService._internal() {
    print("SystemInfoService initialized");
  }
}
