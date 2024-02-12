part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginWithGoogleAndAppleAuthEvent extends AuthEvent {
  final String type;

  const LoginWithGoogleAndAppleAuthEvent({required this.type});
}
