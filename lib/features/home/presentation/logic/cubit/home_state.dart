part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class LoadingActiveVpnHomeState extends HomeState {}

class SuccessActiveVpnHomeState extends HomeState {}

class LoadingInitialStatusHomeState extends HomeState {}

class SuccessInitialStatusHomeState extends HomeState {}

class LoadingConnectVpnState extends HomeState {}

class SuccessConnectVpnState extends HomeState {}

class LoadingStopVpnState extends HomeState {}

class SuccessStoppedVpnState extends HomeState {}

class LoadingListenVpnState extends HomeState {}

class SuccessListenVpnState extends HomeState {}
