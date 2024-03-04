import 'package:dartz/dartz.dart';
import 'package:vpn/features/profile/data/models/profile_model.dart';
import 'package:vpn/features/profile/domain/repositories/profile_repository.dart';

class ProfileUseCases {
  ProfileRepository profileRepository;
  ProfileUseCases(this.profileRepository);

  Future<Either<String, ProfileModel>> getProfile() async {
    return profileRepository.getProfile();
  }
}
