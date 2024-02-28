import 'package:dartz/dartz.dart';
import 'package:vpn/features/home/data/models/data_service_acc_model.dart';
import 'package:vpn/features/home/domain/repositories/home_repository.dart';

class HomeUseCase {
  HomeRepository homeRepository;
  HomeUseCase(this.homeRepository);
  Future<Either<String, DataServiceAccModel>> getDataServiceAcc() {
    return homeRepository.getDataServiceAcc();
  }
}
