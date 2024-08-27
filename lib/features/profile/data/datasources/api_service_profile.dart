import 'package:vpn/core/constants.dart';
import 'package:vpn/core/error/execute_and_handle_error.dart';
import 'package:vpn/core/native/check_mode.dart';
import 'package:vpn/core/shared/datasources/local/cache_gen_algorithm.dart';
import 'package:vpn/core/shared/datasources/remote/api_base.dart';
import 'package:vpn/core/shared/utils/generate_keys.dart';
import 'package:vpn/features/profile/data/models/profile_model.dart';
import 'package:vpn/locator.dart';

class ApiServiceProfile extends ApiBase {
  Future<ProfileModel> getProfile() async {
    return executeAndHandleErrorServer<ProfileModel>(() async {
      final cacheHelper =
          await locator<CacheGenAlgorithm>().getSecurityDataAlgithms();

      final rsaKeyHelper = locator<RsaKeyHelper>();
      final rnd = rsaKeyHelper.generateRandomUUID;

      final signature =
          await rsaKeyHelper.getSignature(rnd, cacheHelper?.udid ?? "");
      final body = rsaKeyHelper.buildQueryString({
        "oper": "get_user_info",
        "udid": cacheHelper?.udid ?? "",
        "rnd": rnd,
        "type_run": await isSandboxOrProduct(),
        "signature": signature,
      });
      final response = await post(BASE_URL, body: body);
      if (response.json.containsKey("error_status")) {
        throw "${response.json["error_status"]}";
      }
      final res = ProfileModel.fromJson(response.json);
      return res;
    });
  }
}
