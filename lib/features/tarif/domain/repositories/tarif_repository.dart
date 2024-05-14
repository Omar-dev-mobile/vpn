import 'package:dartz/dartz.dart';
import 'package:vpn/features/tarif/data/models/purchase_model.dart';
import 'package:vpn/features/tarif/data/models/tarif_model.dart';

abstract class TarifRepository {
  Future<Either<String, TarifModel>> getTarifs(bool isRefresh);
  Future<Either<String, PurchaseModel>> buyTarif(
      String transactionId, String productId);
  Future<Either<String, String>> checkTrans(String transactionId);
}
