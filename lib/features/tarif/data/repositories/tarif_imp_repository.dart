import 'package:dartz/dartz.dart';
import 'package:vpn/core/shared/datasources/local/cache_helper.dart';
import 'package:vpn/features/tarif/data/datasources/api_service_tarif.dart';
import 'package:vpn/features/tarif/data/models/purchase_model.dart';
import 'package:vpn/features/tarif/data/models/tarif_model.dart';
import 'package:vpn/features/tarif/domain/repositories/tarif_repository.dart';
import '../../../../core/error/execute_and_handle_error.dart';

class TarifImpRepository extends TarifRepository {
  ApiServiceTarif apiServiceTarif;
  CacheHelper cacheHelper;
  TarifImpRepository(this.apiServiceTarif, this.cacheHelper);

  @override
  Future<Either<String, TarifModel>> getTarifs(bool isRefresh) async {
    return executeAndHandleError<TarifModel>(() async {
      final tarifModel = await cacheHelper.getTarifModel();
      final currentTime = DateTime.now();
      if ((tarifModel != null &&
          tarifModel.dateSave != null &&
          currentTime.difference(tarifModel.dateSave!).inMinutes < 5 &&
          !isRefresh)) {
        return tarifModel;
      }
      final res = await apiServiceTarif.getTrials();
      cacheHelper.saveTarifModel(res..dateSave = DateTime.now());
      return res;
    });
  }

  @override
  Future<Either<String, PurchaseModel>> buyTarif(
      String transactionId, String productId) async {
    return executeAndHandleError<PurchaseModel>(() async {
      final res = await apiServiceTarif.buyTarif(transactionId, productId);
      return res;
    });
  }

  @override
  Future<Either<String, String>> checkTrans(String transactionId) async {
    return executeAndHandleError<String>(() async {
      final res = await apiServiceTarif.checkTrans(transactionId);
      return res;
    });
  }
}
