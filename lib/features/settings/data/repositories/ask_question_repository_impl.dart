

import 'package:dartz/dartz.dart';
import 'package:vpn/features/settings/data/datasources/api_service_ask_question.dart';
import 'package:vpn/features/settings/data/models/ask_question_model.dart';
import 'package:vpn/features/settings/domain/repositories/ask_question_repository.dart';

import '../../../../core/error/execute_and_handle_error.dart';

class AskQuestionRepositoryImpl extends AskQuestionRepository{
  ApiServiceAskQuestion apiServiceAskQuestion;

  AskQuestionRepositoryImpl(this.apiServiceAskQuestion);
  @override
  Future<Either<String, bool>> leaveFeedback(AskQuestionModel model) {
    return executeAndHandleError<bool>(() async {
      final res = await apiServiceAskQuestion.leaveFeedback(model);
      print("res $res");
      return res;
    });

  }

}