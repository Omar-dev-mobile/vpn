import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vpn/core/shared/components/snack_bar.dart';
import 'package:vpn/features/settings/data/models/ask_question_model.dart';
import 'package:vpn/features/settings/domain/usecases/setting_usecases.dart';
import 'package:vpn/features/settings/presentation/cubit/setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  SettingCubit(this._settingUsecases) : super(AskQuestionInitial());

  final SettingUsecases _settingUsecases;

  static SettingCubit get(context) => BlocProvider.of(context);

  Future<void> leaveFeedback(AskQuestionModel model) async {
    emit(AskQuestionLoadingState());
    final res = await _settingUsecases.leaveFeedback(model);
    emit(
      res.fold((failure) => AskQuestionErrorState(error: failure),
          (data) => AskQuestionSuccessState()),
    );
  }

  Future<bool> logout(context, {bool? isDelete}) async {
    emit(LogoutSuccessState());
    final res = await _settingUsecases.logout(isDelete: isDelete ?? false);
    return res.fold((failure) {
      CustomSnackBar.badSnackBar(context, failure);
      return false;
    }, (data) {
      emit(LogoutSuccessState());
      return true;
    });
  }
}
