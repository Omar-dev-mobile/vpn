import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vpn/features/profile/data/models/profile_model.dart';
import 'package:vpn/features/profile/domain/usecases/profile_usecases.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileUseCases profileUseCases;
  ProfileCubit(this.profileUseCases) : super(ProfileInitial());

  static ProfileCubit get(context) => BlocProvider.of(context);
  void getProfile() async {
    emit(ProfileLoadingState());
    final res = await profileUseCases.getProfile();
    emit(res.fold((l) => ProfileErrorState(l), (r) => ProfileSuccessState(r)));
  }
}
