part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginWithAppleAuthEvent extends AuthEvent {}

class LoginWithGoogleAuthEvent extends AuthEvent {}
