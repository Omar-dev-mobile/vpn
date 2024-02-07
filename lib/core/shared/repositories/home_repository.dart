import 'package:vpn/core/error/execute_and_handle_error.dart';
import 'package:vpn/core/shared/datasources/api_service_init.dart';

class InitRepository {
  ApiServiceInit apiServiceInit;
  InitRepository({required this.apiServiceInit});
  Future<void> initRequest() async {
    await executeAndHandleError<bool>(() async {
      final res = await apiServiceInit.initRequest();
      return res;
    });
  }
}
