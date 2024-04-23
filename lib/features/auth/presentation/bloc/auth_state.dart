part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoadingGoogleState extends AuthState {}

class AuthLoadingAppleState extends AuthState {}

class AuthErrorState extends AuthState {
  final String error;
  const AuthErrorState({required this.error});
}

class AuthSuccessState extends AuthState {}

class StopAuthState extends AuthState {}
