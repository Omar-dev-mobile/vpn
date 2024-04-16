import 'package:dartz/dartz.dart';
import 'package:vpn/features/auth/data/models/user_model.dart';
import 'package:vpn/features/auth/domain/repositories/auth_repository.dart';

class AuthUseCase {
  final AuthRepository _authRepository;

  AuthUseCase(this._authRepository);

  Future<Either<String, UserModel>> call(
      String appleID, bool isGoogleLogin) async {
    return await _authRepository.login(appleID, isGoogleLogin);
  }
}
