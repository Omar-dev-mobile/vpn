import 'package:vpn/core/error/execute_and_handle_error.dart';
import 'package:vpn/core/shared/datasources/local/cache_gen_algorithm.dart';
import 'package:vpn/core/shared/datasources/remote/api_base.dart';
import 'package:vpn/core/shared/usecases/generate_keys.dart';
import 'package:vpn/features/tarif/data/models/tarif_model.dart';
import 'package:vpn/locator.dart';

class ApiServiceTarif extends ApiBase {
  Future<TarifModel> getTrials() async {
    return executeAndHandleErrorServer<TarifModel>(() async {
      final cacheHelper =
          await locator<CacheGenAlgorithm>().getSecurityDataAlgithms();
      final rsaKeyHelper = locator<RsaKeyHelper>();
      final rnd = rsaKeyHelper.generateRandomUUID;

      final signature =
          await rsaKeyHelper.getSignature(rnd, cacheHelper?.udid ?? "");

      final response = await post(
        'https://vp-line.aysec.org/ios.php',
        queryParameters: {
          "oper": "get_tarif_list",
          "udid": cacheHelper?.udid ?? "",
          "rnd": rnd,
          "signature": signature,
        },
      );
      print(response.json);
      return TarifModel.fromJson(response.json);
    });
  }
}
