import 'package:vpn/core/constants.dart';
import 'package:vpn/core/error/execute_and_handle_error.dart';
import 'package:vpn/core/shared/datasources/local/cache_gen_algorithm.dart';
import 'package:vpn/core/shared/datasources/remote/api_base.dart';
import 'package:vpn/core/shared/model/security_model.dart';
import 'package:vpn/locator.dart';
import '../../../../../core/shared/usecases/generate_keys.dart';

class ApiServiceInit extends ApiBase {
  Future<bool> initSecurityRequest() async {
    return executeAndHandleErrorServer<bool>(() async {
      var rsaKeyHelper =
          await locator<RsaKeyHelper>().generateAlgithmsForInitApp();
      final response = await post(
        BASE_URL,
        queryParameters: rsaKeyHelper,
      );

      if (response.statusCode == 200) {
        final data = {
          "work_status": response.json["work_status"],
          ...rsaKeyHelper
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
