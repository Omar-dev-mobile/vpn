import 'package:dartz/dartz.dart';
import 'package:vpn/features/auth/data/models/user_model.dart';

abstract class AuthRepository {
  Future<Either<String, UserModel>> login(String appleID, bool isGoogleLogin);
}
