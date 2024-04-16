import 'package:dartz/dartz.dart';
import 'package:vpn/core/error/execute_and_handle_error.dart';
import 'package:vpn/core/shared/components/system_info_service.dart';
import 'package:vpn/core/shared/datasources/local/cache_helper.dart';
import 'package:vpn/features/auth/data/datasources/api_service_auth.dart';
import 'package:vpn/features/auth/data/models/user_model.dart';
import 'package:vpn/features/auth/domain/repositories/auth_repository.dart';
import 'package:vpn/locator.dart';

class AuthImplRepository implements AuthRepository {
  ApiServiceAuth authService;
  CacheHelper cacheHelper;
  AuthImplRepository({
    required this.authService,
    required this.cacheHelper,
  });

  @override
  Future<Either<String, UserModel>> login(String appleID, bool isGoogleLogin) {
    return executeAndHandleError<UserModel>(() async {
      final res = await authService.login(appleID, isGoogleLogin);
      cacheHelper.saveUser(res);
      locator<SystemInfoService>().user = res;
      return res;
    });
  }
}
