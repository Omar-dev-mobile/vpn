import 'package:shared_preferences/shared_preferences.dart';
import 'package:vpn/core/shared/usecases/generate_keys.dart';

class CacheHelper {
  static SharedPreferences? sharedPreferences;
  RsaKeyHelper? rsaKeyHelper;

  init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    rsaKeyHelper = RsaKeyHelper();
  }

  Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) return await sharedPreferences!.setString(key, value);
    if (value is int) return await sharedPreferences!.setInt(key, value);
    if (value is bool) return await sharedPreferences!.setBool(key, value);

    return await sharedPreferences!.setDouble(key, value);
  }

  dynamic getData(
    String key,
  ) {
    return sharedPreferences!.get(key);
  }

  Future<bool> removeData({
    required String key,
  }) async {
    return await sharedPreferences!.remove(key);
  }

  Future<bool> clearData() async {
    return await sharedPreferences!.clear();
  }
}
