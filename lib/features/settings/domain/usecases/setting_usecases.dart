import 'package:dartz/dartz.dart';
import 'package:vpn/features/settings/data/models/ask_question_model.dart';
import 'package:vpn/features/settings/domain/repositories/setting_repository.dart';

class SettingUsecases {
  SettingRepository askQuestionRepository;
  SettingUsecases(this.askQuestionRepository);

  Future<Either<String, bool>> leaveFeedback(AskQuestionModel model) async {
    return askQuestionRepository.leaveFeedback(model);
  }

  Future<Either<String, bool>> logout({bool isDelete = false}) async {
    return askQuestionRepository.logout(isDelete: isDelete);
  }
}
