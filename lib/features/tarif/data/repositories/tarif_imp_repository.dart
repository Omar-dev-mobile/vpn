import 'package:dartz/dartz.dart';
import 'package:vpn/features/tarif/data/datasources/api_service_tarif.dart';
import 'package:vpn/features/tarif/data/models/tarif_model.dart';
import 'package:vpn/features/tarif/domain/repositories/tarif_repository.dart';
import '../../../../core/error/execute_and_handle_error.dart';

class TarifImpRepository extends TarifRepository {
  ApiServiceTarif apiServiceTarif;
  TarifImpRepository(this.apiServiceTarif);

  @override
  Future<Either<String, TarifModel>> getTrials() async {
    return executeAndHandleError<TarifModel>(() async {
      final res = await apiServiceTarif.getTrials();
      print("res $res");
      return res;
    });
  }
}
