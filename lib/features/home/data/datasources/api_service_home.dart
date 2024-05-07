import 'dart:convert';

import 'package:vpn/core/constants.dart';
import 'package:vpn/core/error/execute_and_handle_error.dart';
import 'package:vpn/core/shared/datasources/local/cache_gen_algorithm.dart';
import 'package:vpn/core/shared/datasources/local/cache_helper.dart';
import 'package:vpn/core/shared/datasources/remote/api_base.dart';
import 'package:vpn/core/shared/usecases/generate_keys.dart';
import 'package:vpn/features/home/data/models/data_service_acc_model.dart';
import 'package:vpn/locator.dart';

class ApiServiceHome extends ApiBase {
  Future<DataServiceAccModel> getDataServiceAcc() async {
    return executeAndHandleErrorServer<DataServiceAccModel>(() async {
      final idServer = await locator<CacheHelper>().getVpnServer();
      final cacheGenAlgorithm =
          await locator<CacheGenAlgorithm>().getSecurityDataAlgithms();
      final rsaKeyHelper = locator<RsaKeyHelper>();
      final rnd = rsaKeyHelper.generateRandomUUID;
      final signature =
          await rsaKeyHelper.getSignature(rnd, cacheGenAlgorithm?.udid ?? "");
      final body = rsaKeyHelper.buildQueryString({
        "oper": "acc",
        "udid": cacheGenAlgorithm?.udid ?? "",
        "rnd": rnd,
        "id_server": idServer?.id?.toString() ?? "1",
        "signature": signature,
      });
      final response = await post(BASE_URL, body: body);
      if (response.json.containsKey("error_status")) {
        throw "${response.json["error_status"]}";
      }
      return DataServiceAccModel.fromJson(response.json);
    });
  }
}
