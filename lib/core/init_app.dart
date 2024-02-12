import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vpn/blocs_observer.dart';
import 'package:vpn/core/shared/components/system_info_service.dart';
import 'package:vpn/core/shared/datasources/local/cache_helper.dart';
import 'package:vpn/core/shared/usecases/init_usecases.dart';
import '../locator.dart';

class InitApp {
  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    await setupLocator();
    Bloc.observer = BlocsObserver();
    await locator<CacheHelper>().init();
    await locator<SystemInfoService>().getSystemInfo();
    await locator<InitUsecases>().initSecurityRequest();
  }
}
