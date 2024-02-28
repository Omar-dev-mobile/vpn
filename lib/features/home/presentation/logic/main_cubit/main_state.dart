part of 'main_cubit.dart';

sealed class MainState extends Equatable {
  const MainState();

  @override
  List<Object> get props => [];
}

final class MainInitial extends MainState {}

class LoadingGetDataServiceAccState extends MainState {}

class SuccessGetDataServiceAccState extends MainState {
  final DataServiceAccModel dataServiceAccModel;
  const SuccessGetDataServiceAccState(this.dataServiceAccModel);
}

class ErrorGetDataServiceAccState extends MainState {
  final String error;
  const ErrorGetDataServiceAccState(this.error);
}
