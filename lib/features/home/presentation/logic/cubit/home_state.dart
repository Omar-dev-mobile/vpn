part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class LoadingActiveVpnHomeState extends HomeState {}

class SuccessActiveVpnHomeState extends HomeState {}
