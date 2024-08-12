import 'package:dartz/dartz.dart';
import 'package:vpn/features/settings/data/datasources/api_service_setting.dart';
import 'package:vpn/features/settings/data/models/ask_question_model.dart';
import 'package:vpn/features/settings/domain/repositories/setting_repository.dart';

import '../../../../core/error/execute_and_handle_error.dart';

class SettingRepositoryImpl extends SettingRepository {
  ApiServiceSetting apiServiceAskQuestion;

  SettingRepositoryImpl(this.apiServiceAskQuestion);
  @override
  Future<Either<String, bool>> leaveFeedback(AskQuestionModel model) {
    return executeAndHandleError<bool>(() async {
      final res = await apiServiceAskQuestion.leaveFeedback(model);
      return res;
    });
  }

  @override
  Future<Either<String, bool>> logout({bool isDelete = false}) {
    return executeAndHandleError<bool>(() async {
      final res = await apiServiceAskQuestion.logout(isDelete: isDelete);
      return res;
    });
  }
}
