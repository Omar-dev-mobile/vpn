import 'package:vpn/core/error/execute_and_handle_error.dart';
import 'package:vpn/core/shared/datasources/api_base.dart';
import '../../../../core/shared/usecases/generate_keys.dart';

class ApiServiceInit extends ApiBase {
  Future<bool> initRequest() async {
    return executeAndHandleErrorServer<bool>(() async {
      var rsaKeyHelper = await RsaKeyHelper().generateAlgithmsForInitApp();
      print(rsaKeyHelper);
      final response = await post(
        'https://vp-line.aysec.org/ios.php',
        queryParameters: rsaKeyHelper,
      );
      print(response.json);

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    });
  }
}
