part of 'tarif_cubit.dart';

class TarifState extends Equatable {
  const TarifState();

  @override
  List<Object> get props => [];
}

class TarifInitial extends TarifState {}

class TarifLoadingState extends TarifState {}

class TarifSuccessState extends TarifState {
  final TarifModel tarifModel;
  const TarifSuccessState({required this.tarifModel});
}

class TarifErrorState extends TarifState {
  final String error;
  const TarifErrorState({required this.error});
}
