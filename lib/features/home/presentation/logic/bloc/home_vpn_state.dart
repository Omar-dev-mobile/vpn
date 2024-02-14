part of 'home_vpn_bloc.dart';

abstract class HomeVpnState {}

class HomeVpnInitial extends HomeVpnState {}

class HomeLoadingVpnState extends HomeVpnState {}

class HomeErrorVpnState extends HomeVpnState {
  final String error;
  HomeErrorVpnState({required this.error});
}

class HomeSuccessVpnState extends HomeVpnState {
  final StatusConnection status;
  HomeSuccessVpnState({required this.status});
}
