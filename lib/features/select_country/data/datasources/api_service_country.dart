import 'package:vpn/core/constants.dart';
import 'package:vpn/core/error/execute_and_handle_error.dart';
<<<<<<< HEAD
=======
import 'package:vpn/core/native/check_mode.dart';
>>>>>>> new_version
import 'package:vpn/core/shared/datasources/local/cache_gen_algorithm.dart';
import 'package:vpn/core/shared/datasources/remote/api_base.dart';
import 'package:vpn/core/shared/utils/generate_keys.dart';
import 'package:vpn/features/select_country/data/models/countries_model.dart';
import 'package:vpn/locator.dart';

class ApiServiceCountry extends ApiBase {
  Future<CountriesModel> getCountriesList(int vers) async {
    return executeAndHandleErrorServer<CountriesModel>(() async {
      final cacheHelper =
          await locator<CacheGenAlgorithm>().getSecurityDataAlgithms();

      final rsaKeyHelper = locator<RsaKeyHelper>();
      final rnd = rsaKeyHelper.generateRandomUUID;

      final signature = await rsaKeyHelper.getSignature(
          "$rnd${vers.toString()}", cacheHelper?.udid ?? "");
      final body = rsaKeyHelper.buildQueryString({
        "oper": "get_vpn_list",
        "udid": cacheHelper?.udid ?? "",
        "rnd": rnd,
        "vers": vers.toString(),
        "signature": signature,
<<<<<<< HEAD
=======
        "type_run": await isSandboxOrProduct()
>>>>>>> new_version
      });
      final response = await post(BASE_URL, body: body);
      if (response.json.containsKey("error_status")) {
        throw "${response.json["error_status"]}";
      }
      final res = CountriesModel.fromJson(response.json);
      return res;
    });
  }
}
