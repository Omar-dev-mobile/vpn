import 'package:vpn/core/shared/datasources/cache_helper.dart';
import 'package:vpn/core/shared/repositories/home_repository.dart';
import 'package:vpn/core/shared/usecases/system_info_service.dart';
import '../locator.dart';

class InitApp {
  static Future<void> initialize() async {
    await setupLocator();
    await locator<CacheHelper>().init();
    await locator<SystemInfoService>().getSystemInfo();
    await locator<InitRepository>().initSecurityRequest();
  }
}
