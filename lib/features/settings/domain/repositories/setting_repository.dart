import 'package:dartz/dartz.dart';
import 'package:vpn/features/settings/data/models/ask_question_model.dart';

abstract class SettingRepository {
  Future<Either<String, bool>> leaveFeedback(AskQuestionModel model);
  Future<Either<String, bool>> logout();
}
