
import 'package:dartz/dartz.dart';
import 'package:vpn/features/settings/data/models/ask_question_model.dart';


abstract class AskQuestionRepository{
  Future<Either<String , bool>> leaveFeedback(AskQuestionModel model);
}