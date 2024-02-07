import 'package:vpn/core/error/execute_and_handle_error.dart';
import 'package:vpn/core/shared/datasources/api_base.dart';
import 'package:vpn/core/shared/datasources/cache_helper.dart';
import 'package:vpn/core/shared/model/security_model.dart';
import 'package:vpn/locator.dart';
import '../../../../core/shared/usecases/generate_keys.dart';

class ApiServiceInit extends ApiBase {
  Future<bool> initSecurityRequest() async {
    return executeAndHandleErrorServer<bool>(() async {
      var rsaKeyHelper = await RsaKeyHelper().generateAlgithmsForInitApp();
      print(rsaKeyHelper);
      final response = await post(
        'https://vp-line.aysec.org/ios.php',
        queryParameters: rsaKeyHelper,
      );
      print(response.json);

      if (response.statusCode == 200) {
        final cacheHelper = locator<CacheHelper>();
        final data = {
          "work_status": response.json["work_status"],
          ...rsaKeyHelper
        };
        final securityModel = SecurityModel.fromJson(data);
        cacheHelper.saveSecurityDataAlgithms(securityModel);
        print((await cacheHelper.getSecurityDataAlgithms())?.workStatus);
        return true;
      } else {
        return false;
      }
    });
  }
}
