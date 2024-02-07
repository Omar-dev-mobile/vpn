import 'package:vpn/core/error/execute_and_handle_error.dart';
import 'package:vpn/core/shared/datasources/api_service_init.dart';
import 'package:vpn/core/shared/datasources/cache_helper.dart';
import 'package:vpn/locator.dart';

class InitRepository {
  ApiServiceInit apiServiceInit;
  InitRepository({required this.apiServiceInit});
  Future<void> initSecurityRequest() async {
    final cacheHelper = locator<CacheHelper>();
    if ((await cacheHelper.getSecurityDataAlgithms()) == null) {
      await executeAndHandleError<bool>(() async {
        final res = await apiServiceInit.initSecurityRequest();
        return res;
      });
    }
  }
}
