part of 'theme_mode_cubit.dart';

sealed class ThemeModeState extends Equatable {
  const ThemeModeState();

  @override
  List<Object> get props => [];
}

class ThemeModeStateInitial extends ThemeModeState {}

class LoadingThemeModeAppState extends ThemeModeState {}

class SuccessThemeModeAppState extends ThemeModeState {}
