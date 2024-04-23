import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vpn/core/shared/datasources/local/cache_gen_algorithm.dart';
import 'package:vpn/features/profile/data/models/profile_model.dart';
import 'package:vpn/features/profile/domain/usecases/profile_usecases.dart';
import 'package:vpn/locator.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileUseCases profileUseCases;
  ProfileCubit(this.profileUseCases) : super(ProfileInitial());
  String workStatus = '';
  static ProfileCubit get(context) => BlocProvider.of(context);
  void getProfile() async {
    emit(ProfileLoadingState());
    var getSecurityDataAlgithms =
        await locator<CacheGenAlgorithm>().getSecurityDataAlgithms();
    workStatus = getSecurityDataAlgithms?.workStatus ?? '';
    final res = await profileUseCases.getProfile();
    emit(res.fold((l) => ProfileErrorState(l), (r) => ProfileSuccessState(r)));
  }
}
