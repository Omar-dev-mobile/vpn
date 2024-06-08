import 'package:vpn/core/constants.dart';
import 'package:vpn/core/error/execute_and_handle_error.dart';
import 'package:vpn/core/shared/datasources/local/cache_gen_algorithm.dart';
import 'package:vpn/core/shared/datasources/remote/api_base.dart';
import 'package:vpn/core/shared/model/security_model.dart';
import 'package:vpn/core/shared/utils/generate_keys.dart';
import 'package:vpn/locator.dart';

class ApiServiceInit extends ApiBase {
  Future<bool> initSecurityRequest() async {
    return executeAndHandleErrorServer<bool>(() async {
      var rsaKeyHelper = locator<RsaKeyHelper>();
      var generateAlgorithmsForInitApp =
          await rsaKeyHelper.generateAlgorithmsForInitApp();

      final response = await post(BASE_URL,
          body: rsaKeyHelper.buildQueryString(generateAlgorithmsForInitApp));

      if (response.statusCode == 200) {
        final data = {
          "work_status": response.json["work_status"],
          ...generateAlgorithmsForInitApp,
        };
        final securityModel = SecurityModel.fromJson(data);
        locator<CacheGenAlgorithm>().saveSecurityDataAlgithms(securityModel);

        return true;
      } else {
        return false;
      }
    });
  }
}
