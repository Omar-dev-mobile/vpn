import 'package:dartz/dartz.dart';
import 'package:vpn/features/tarif/data/models/tarif_model.dart';

abstract class TarifRepository {
  Future<Either<String, TarifModel>> getTrials();
}
