import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vpn/core/shared/components/system_info_service.dart';
import 'package:vpn/features/home/data/models/data_service_acc_model.dart';
import 'package:vpn/features/tarif/data/models/tarif_model.dart';
import 'package:vpn/features/tarif/domain/usecases/traif_usecases.dart';
import 'package:vpn/features/tarif/presentation/cubit/purchase/purchases_cubit.dart';
import 'package:vpn/locator.dart';

part 'tarif_state.dart';

class TarifCubit extends Cubit<TarifState> {
  TarifCubit(this._traifUsecases, this.systemInfoService)
      : super(TarifInitial());
  final SystemInfoService systemInfoService;
  final TraifUsecases _traifUsecases;
  static TarifCubit get(context) => BlocProvider.of(context);
  Future<void> getTrials() async {
    emit(TarifLoadingState());
    locator<PurchasesCubit>().initStoreInfo();
    final res = await _traifUsecases.getTarifs();
    emit(
      res.fold((failure) => TarifErrorState(error: failure),
          (data) => TarifSuccessState(tarifModel: data)),
    );
  }

  WorkStatusAcc? get vpnInfo => systemInfoService.vpnInfo;
}