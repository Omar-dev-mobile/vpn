part of 'purchases_cubit.dart';

class PurchasesStatus extends Equatable {
  const PurchasesStatus();

  @override
  List<Object> get props => [];
}

class PurchasesInitial extends PurchasesStatus {}

class ErrorPurchaseState extends PurchasesStatus {
  final String error;
  const ErrorPurchaseState({required this.error});
}

class LoadingInitStoreInfoState extends PurchasesStatus {}

class EndInitStoreInfoState extends PurchasesStatus {}

class LoadingPendingPurchaseState extends PurchasesStatus {}

class EndPendingPurchaseState extends PurchasesStatus {}

class LoadingGetProductsPurchaseState extends PurchasesStatus {}

class EndGetProductsPurchaseState extends PurchasesStatus {}

class SuccessPurchaseState extends PurchasesStatus {}
