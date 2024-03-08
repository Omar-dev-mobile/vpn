
import 'package:equatable/equatable.dart';

class AskQuestionState extends Equatable {
  const AskQuestionState();

  @override
  List<Object> get props => [];
}

class AskQuestionInitial extends AskQuestionState {}

class AskQuestionLoadingState extends AskQuestionState {}

class AskQuestionSuccessState extends AskQuestionState {}

class AskQuestionErrorState extends AskQuestionState {
  final String error;
  const AskQuestionErrorState({required this.error});
}
