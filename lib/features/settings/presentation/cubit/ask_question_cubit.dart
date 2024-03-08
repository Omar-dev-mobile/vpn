

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vpn/features/settings/data/models/ask_question_model.dart';
import 'package:vpn/features/settings/domain/usecases/ask_question_usecases.dart';
import 'package:vpn/features/settings/presentation/cubit/ask_question_state.dart';

class AskQuestionCubit extends Cubit<AskQuestionState> {
  AskQuestionCubit(this._askQuestionUsecases) : super(AskQuestionInitial());


  final AskQuestionUsecases _askQuestionUsecases;

  static AskQuestionCubit get(context) => BlocProvider.of(context);

  Future<void> leaveFeedback(AskQuestionModel model) async{
    emit(AskQuestionLoadingState());
    final res = await _askQuestionUsecases.leaveFeedback(model);
    emit(
      res.fold((failure) => AskQuestionErrorState(error: failure),
              (data) => AskQuestionSuccessState()),
    );
  }


}