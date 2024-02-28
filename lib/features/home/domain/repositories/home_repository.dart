import 'package:dartz/dartz.dart';
import 'package:vpn/features/home/data/models/data_service_acc_model.dart';

abstract class HomeRepository {
  Future<Either<String, DataServiceAccModel>> getDataServiceAcc();
}
