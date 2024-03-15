import 'package:equatable/equatable.dart';

class SettingState extends Equatable {
  const SettingState();

  @override
  List<Object> get props => [];
}

class AskQuestionInitial extends SettingState {}

class AskQuestionLoadingState extends SettingState {}

class AskQuestionSuccessState extends SettingState {}

class AskQuestionErrorState extends SettingState {
  final String error;
  const AskQuestionErrorState({required this.error});
}

class LogoutSuccessState extends SettingState {}

class LogoutLoadingState extends SettingState {}

class LogoutErrorState extends SettingState {
  final String error;
  const LogoutErrorState({required this.error});
}
