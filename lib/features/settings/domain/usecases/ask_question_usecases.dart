


import 'package:dartz/dartz.dart';
import 'package:vpn/features/settings/data/models/ask_question_model.dart';
import 'package:vpn/features/settings/domain/repositories/ask_question_repository.dart';

class AskQuestionUsecases{
  AskQuestionRepository askQuestionRepository;
  AskQuestionUsecases(this.askQuestionRepository);


  Future<Either<String, bool>> leaveFeedback(AskQuestionModel model) async {
    return askQuestionRepository.leaveFeedback(model);
  }

}