import 'package:vpn/core/error/execute_and_handle_error.dart';
import 'package:vpn/core/shared/datasources/local/cache_gen_algorithm.dart';
import 'package:vpn/core/shared/datasources/remote/api_service_init.dart';
import 'package:vpn/locator.dart';

class InitUsecases {
  ApiServiceInit apiServiceInit;
  InitUsecases({required this.apiServiceInit});
  Future<void> initSecurityRequest() async {
    //need run this function when user sign in
    final cacheHelper = locator<CacheGenAlgorithm>();
    if ((await cacheHelper.getSecurityDataAlgithms()) == null) {
      await executeAndHandleError<bool>(() async {
        final res = await apiServiceInit.initSecurityRequest();
        return res;
      });
    }
  }

  Future<void> initSecurityRequestAndUpdateKeys() async {
    await executeAndHandleError<bool>(() async {
      final res = await apiServiceInit.initSecurityRequest();
      return res;
    });
  }
}
