import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vpn/flutter_vpn.dart';
import 'package:flutter_vpn/state.dart';
import 'package:lottie/lottie.dart';
import 'package:vpn/blocs_observer.dart';
import 'package:vpn/core/shared/components/system_info_service.dart';
import 'package:vpn/core/shared/datasources/local/cache_helper.dart';
import 'package:vpn/core/shared/usecases/init_usecases.dart';
import 'package:vpn/core/theme/assets.dart';
import '../locator.dart';

class InitApp {
  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    HttpOverrides.global = MyHttpOverrides();
    await setupLocator();
    Bloc.observer = BlocsObserver();
    await locator<CacheHelper>().init();
    await locator<SystemInfoService>().getSystemInfo();
    await locator<InitUsecases>().initSecurityRequest();
    await FlutterVpn.prepare();
    initAnimation();
    // FlutterVpn.connectIkev2EAP(
    //   server: "128.140.61.187",
    //   password: "N2gzEt5RoovqxtgfsAmw",
    //   username: "usr5",
    //   name: "usr5",
    // );
    // FlutterVpn.currentState.then((value) {
    //   print("connect $value");
    // });
  }

  static void initAnimation() {
    AssetLottie(Assets.connecting).load();
    AssetLottie(Assets.stopeToVpn).load();
    AssetLottie(Assets.disconnecting).load();
  }
}

//best way for ssl certification problem on all http requests
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    try {
      return super.createHttpClient(context)
        ..badCertificateCallback =
            (X509Certificate cert, String host, int port) {
          return true;
        };
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }
}
