import 'package:vpn/core/constants.dart';
import 'package:vpn/core/error/execute_and_handle_error.dart';
import 'package:vpn/core/shared/datasources/local/cache_gen_algorithm.dart';
import 'package:vpn/core/shared/datasources/remote/api_base.dart';
import 'package:vpn/core/shared/utils/generate_keys.dart';
import 'package:vpn/features/auth/data/models/auth_model.dart';
import 'package:vpn/features/auth/data/models/user_model.dart';
import 'package:vpn/locator.dart';

class ApiServiceAuth extends ApiBase {
  Future<UserModel> login(AuthModel authModel) async {
    return executeAndHandleErrorServer<UserModel>(() async {
      final cacheHelper =
          await locator<CacheGenAlgorithm>().getSecurityDataAlgithms();
      final rsaKeyHelper = locator<RsaKeyHelper>();
      final rnd = rsaKeyHelper.generateRandomUUID;
      final signature = await rsaKeyHelper.getSignature(
          "$rnd${authModel.login}", cacheHelper?.udid ?? "");
      final response = await post(
        BASE_URL,
        body: {
          "oper": authModel.isGoogleLogin ? "login_google" : "login_apple_id",
          "udid": cacheHelper?.udid ?? "",
          "rnd": rnd,
          "email": authModel.email,
          "login": authModel.login,
          "signature": signature,
        },
      );
      return UserModel.fromJson(response.json);
    });
  }
}
