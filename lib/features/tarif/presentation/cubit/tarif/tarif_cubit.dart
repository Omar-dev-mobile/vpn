import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vpn/features/tarif/data/models/tarif_model.dart';
import 'package:vpn/features/tarif/domain/usecases/traif_usecases.dart';

part 'tarif_state.dart';

class TarifCubit extends Cubit<TarifState> {
  TarifCubit(this._traifUsecases) : super(TarifInitial());

  final TraifUsecases _traifUsecases;
  static TarifCubit get(context) => BlocProvider.of(context);
  Future<void> getTrials() async {
    emit(TarifLoadingState());
    final res = await _traifUsecases.getTrials();
    emit(
      res.fold((failure) => TarifErrorState(error: failure),
          (data) => TarifSuccessState(tarifModel: data)),
    );
  }
}
