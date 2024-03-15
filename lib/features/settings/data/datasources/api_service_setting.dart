import 'package:vpn/core/shared/components/system_info_service.dart';
import 'package:vpn/core/shared/datasources/remote/api_base.dart';
import 'package:vpn/features/settings/data/models/ask_question_model.dart';

import '../../../../core/constants.dart';
import '../../../../core/error/execute_and_handle_error.dart';
import '../../../../core/shared/datasources/local/cache_gen_algorithm.dart';
import '../../../../core/shared/usecases/generate_keys.dart';
import '../../../../locator.dart';

class ApiServiceSetting extends ApiBase {
  Future<bool> leaveFeedback(AskQuestionModel model) async {
    return executeAndHandleErrorServer<bool>(() async {
      final cacheHelper =
          await locator<CacheGenAlgorithm>().getSecurityDataAlgithms();
      final rsaKeyHelper = locator<RsaKeyHelper>();
      final rnd = rsaKeyHelper.generateRandomUUID;
      final signature = await rsaKeyHelper.getSignature(
          "$rnd${model.email}", cacheHelper?.udid ?? "");
      final queryParams = rsaKeyHelper.buildQueryString({
        "oper": "back_user",
        "udid": cacheHelper?.udid ?? "",
        "rnd": rnd,
        "username": model.name,
        "email": model.email,
        "message": model.message,
        "signature": signature,
      });
      final response = await post('$BASE_URL?$queryParams');
      if (response.json.containsKey("error_status")) {
        throw "${response.json["error_status"]}";
      }
      return true;
    });
  }

  Future<bool> logout() async {
    return executeAndHandleErrorServer<bool>(() async {
      final cacheHelper =
          await locator<CacheGenAlgorithm>().getSecurityDataAlgithms();
      final rsaKeyHelper = locator<RsaKeyHelper>();
      final rnd = rsaKeyHelper.generateRandomUUID;
      final userApiKey =
          locator<SystemInfoService>().user?.workStatus?.userInfo?.userApiKey ??
              "";
      final signature = await rsaKeyHelper.getSignature(
          rnd + userApiKey, cacheHelper?.udid ?? "");
      final queryParams = rsaKeyHelper.buildQueryString({
        "oper": "logout",
        "udid": cacheHelper?.udid ?? "",
        "rnd": rnd,
        "token": userApiKey,
        "signature": signature,
      });
      final response = await post('$BASE_URL?$queryParams');
      if (response.json.containsKey("error_status")) {
        throw "${response.json["error_status"]}";
      }
      return true;
    });
  }
}
