part of 'splash_cubit.dart';

@immutable
abstract class SplashState {}

class SplashInitial extends SplashState {}
class SplashImageChanged extends SplashState {
  final String activeImage;

  SplashImageChanged(this.activeImage);
}
