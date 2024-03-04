import 'package:dartz/dartz.dart';
import 'package:vpn/features/profile/data/models/profile_model.dart';

abstract class ProfileRepository {
  Future<Either<String, ProfileModel>> getProfile();
}
