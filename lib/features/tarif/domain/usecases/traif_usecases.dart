import 'package:dartz/dartz.dart';
import 'package:vpn/features/tarif/data/models/purchase_model.dart';
import 'package:vpn/features/tarif/data/models/tarif_model.dart';
import 'package:vpn/features/tarif/domain/repositories/tarif_repository.dart';

class TraifUsecases {
  TarifRepository tarifRepository;
  TraifUsecases({required this.tarifRepository});

  Future<Either<String, TarifModel>> getTarifs(bool isRefresh) async {
    return tarifRepository.getTarifs(isRefresh);
  }

  Future<Either<String, PurchaseModel>> buyTarif(
      String transactionId, String productId) async {
    return tarifRepository.buyTarif(transactionId, productId);
  }

  Future<Either<String, String>> checkTrans(String transactionId) async {
    return tarifRepository.checkTrans(transactionId);
  }
}
