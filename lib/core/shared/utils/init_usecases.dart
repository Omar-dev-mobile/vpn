import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:vpn/core/error/execute_and_handle_error.dart';
import 'package:vpn/core/shared/datasources/local/cache_gen_algorithm.dart';
import 'package:vpn/core/shared/datasources/local/secure_storage.dart';
import 'package:vpn/core/shared/datasources/remote/api_service_init.dart';
import 'package:vpn/locator.dart';

class InitUsecases {
  ApiServiceInit apiServiceInit;
  InitUsecases({required this.apiServiceInit});
  Future<void> initSecurityRequest() async {
    //need run this function when user sign in
    final cacheHelper = locator<CacheGenAlgorithm>();

    if ((await cacheHelper.getSecurityDataAlgithms()) == null) {
      await requestPermission();
      locator<SecureStorage>().deleteAllSecureData();
      await executeAndHandleError<bool>(() async {
        final res = await apiServiceInit.initSecurityRequest();
        return res;
      });
    }
  }

  Future<void> requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  Future<void> initSecurityRequestAndUpdateKeys() async {
    await executeAndHandleError<bool>(() async {
      final res = await apiServiceInit.initSecurityRequest();
      return res;
    });
  }
}
