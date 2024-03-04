import 'package:dartz/dartz.dart';
import 'package:vpn/core/error/execute_and_handle_error.dart';
import 'package:vpn/features/profile/data/datasources/api_service_profile.dart';
import 'package:vpn/features/profile/data/models/profile_model.dart';
import 'package:vpn/features/profile/domain/repositories/profile_repository.dart';

class ProfileImpRepository extends ProfileRepository {
  ApiServiceProfile authService;
  ProfileImpRepository(this.authService);
  @override
  Future<Either<String, ProfileModel>> getProfile() {
    return executeAndHandleError<ProfileModel>(() async {
      final res = await authService.getProfile();
      return res;
    });
  }
}
