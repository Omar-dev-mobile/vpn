import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vpn/flutter_vpn.dart';
import 'package:lottie/lottie.dart';
import 'package:vpn/blocs_observer.dart';
import 'package:vpn/core/shared/components/notification_service.dart';
import 'package:vpn/core/shared/components/system_info_service.dart';
import 'package:vpn/core/shared/datasources/local/cache_helper.dart';
import 'package:vpn/core/shared/usecases/init_usecases.dart';
import 'package:vpn/core/theme/assets.dart';
import '../firebase_options.dart';
import '../locator.dart';

class InitApp {
  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    HttpOverrides.global = MyHttpOverrides();
    await setupLocator();
    Bloc.observer = BlocsObserver();
    await locator<CacheHelper>().init();
    await locator<SystemInfoService>().getSystemInfo();
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);
    await locator<InitUsecases>().initSecurityRequest();
    await FlutterVpn.prepare();
    final notification = locator<NotificationService>();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');
      if (message.notification != null) {
        notification.showNotification(message);
        print(
            'Message also contained a notification: ${message.notification!}');
      }
    });

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    initAnimation();
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
