part of 'profile_cubit.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileErrorState extends ProfileState {
  final String error;
  const ProfileErrorState(this.error);
}

class ProfileSuccessState extends ProfileState {
  final ProfileModel profileModel;
  const ProfileSuccessState(this.profileModel);
}
