import 'package:dartz/dartz.dart';
import 'package:vpn/core/error/execute_and_handle_error.dart';
import 'package:vpn/features/home/data/datasources/api_service_home.dart';
import 'package:vpn/features/home/data/models/data_service_acc_model.dart';
import 'package:vpn/features/home/domain/repositories/home_repository.dart';

class HomeImplRepository implements HomeRepository {
  HomeImplRepository(this.apiServiceHome);
  ApiServiceHome apiServiceHome;
  @override
  Future<Either<String, DataServiceAccModel>> getDataServiceAcc() async {
    return executeAndHandleError<DataServiceAccModel>(() async {
      final res = await apiServiceHome.getDataServiceAcc();
      return res;
    });
  }
}
