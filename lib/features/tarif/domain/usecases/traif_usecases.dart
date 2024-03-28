import 'package:dartz/dartz.dart';
import 'package:vpn/features/tarif/data/models/tarif_model.dart';
import 'package:vpn/features/tarif/domain/repositories/tarif_repository.dart';

class TraifUsecases {
  TarifRepository tarifRepository;
  TraifUsecases({required this.tarifRepository});

  Future<Either<String, TarifModel>> getTarifs() async {
    return tarifRepository.getTarifs();
  }

  Future<Either<String, bool>> buyTarif(
      String transactionId, String productId) async {
    return tarifRepository.buyTarif(transactionId, productId);
  }
}
