import 'dart:developer';
import 'package:vpn/core/constants.dart';
import 'package:vpn/core/error/execute_and_handle_error.dart';
import 'package:vpn/core/native/check_mode.dart';
import 'package:vpn/core/shared/datasources/local/cache_gen_algorithm.dart';
import 'package:vpn/core/shared/datasources/remote/api_base.dart';
import 'package:vpn/core/shared/utils/generate_keys.dart';
import 'package:vpn/features/tarif/data/models/purchase_model.dart';
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
      final body = rsaKeyHelper.buildQueryString({
        "oper": "get_tarif_list",
        "udid": cacheHelper?.udid ?? "",
        "rnd": rnd,
        "signature": signature,
        "type_run": await isSandboxOrProduct()
      });
      final response = await post(BASE_URL, body: body);
      if (response.json.containsKey("error_status")) {
        throw "${response.json["error_status"]}";
      }
      final res = TarifModel.fromJson(response.json);
      return res;
    });
  }

  Future<PurchaseModel> buyTarif(String transactionId, String productId) async {
    return executeAndHandleErrorServer<PurchaseModel>(() async {
      final cacheHelper =
          await locator<CacheGenAlgorithm>().getSecurityDataAlgithms();
      final rsaKeyHelper = locator<RsaKeyHelper>();
      final rnd = rsaKeyHelper.generateRandomUUID;
      final signature = await rsaKeyHelper.getSignature(
          rnd + transactionId, cacheHelper?.udid ?? "");
      final body = rsaKeyHelper.buildQueryString({
        "oper": "init_buy",
        "udid": cacheHelper?.udid ?? "",
        "rnd": rnd,
        "transaction_id": transactionId,
        "product_id": productId,
        "signature": signature,
        "type_run": await isSandboxOrProduct(),
      });
      final response = await post(BASE_URL, body: body);
      if (response.json.containsKey("error_status")) {
        throw "${response.json["error_status"]}";
      }
      return PurchaseModel.fromJson(response.json);
    });
  }

  Future<String> checkTrans(String transactionId) {
    return executeAndHandleErrorServer<String>(() async {
      final cacheHelper =
          await locator<CacheGenAlgorithm>().getSecurityDataAlgithms();
      final rsaKeyHelper = locator<RsaKeyHelper>();
      final rnd = rsaKeyHelper.generateRandomUUID;
      final signature = await rsaKeyHelper.getSignature(
          rnd + transactionId, cacheHelper?.udid ?? "");
      final body = rsaKeyHelper.buildQueryString({
        "oper": "check_trans",
        "udid": cacheHelper?.udid ?? "",
        "rnd": rnd,
        "transaction_id": transactionId,
        "signature": signature,
        "type_run": await isSandboxOrProduct()
      });
      final response = await post(BASE_URL, body: body);
      log(response.json.toString());
      if (response.json.containsKey("error_status")) {
        throw "${response.json["error_status"]}";
      }
      return response.json['work_status']['result'].toString();
    });
  }
}
