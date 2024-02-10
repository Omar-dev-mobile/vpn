import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:vpn/core/shared/datasources/local/cache_helper.dart';
import 'package:vpn/core/shared/usecases/init_usecases.dart';
import 'package:vpn/core/shared/usecases/system_info_service.dart';
import '../locator.dart';

class InitApp {
  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();

    await setupLocator();
    await locator<CacheHelper>().init();
    await locator<SystemInfoService>().getSystemInfo();
    await locator<InitUsecases>().initSecurityRequest();
  }
}
