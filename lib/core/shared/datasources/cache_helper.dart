import 'package:shared_preferences/shared_preferences.dart';
import 'package:vpn/locator.dart';

class CacheHelper {
  static SharedPreferences? sharedPreferences;

  init() async {
    sharedPreferences = await SharedPreferences.getInstance();
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

  static setLastPurchaseToken(String lastPurchaseToken) {
    SharedPreferences prefs = locator<SharedPreferences>();
    prefs.setString("lastPurchaseToken", lastPurchaseToken);
  }

  static String? getLastPurchaseToken() {
    SharedPreferences prefs = locator<SharedPreferences>();
    return prefs.getString("lastPurchaseToken");
  }

  static setBottomSheetShown(bool isShown) {
    SharedPreferences prefs = locator<SharedPreferences>();
    prefs.setBool("isBottomSheetShown", isShown);
  }

  static bool? getBottomSheetShown() {
    SharedPreferences prefs = locator<SharedPreferences>();
    return prefs.getBool("isBottomSheetShown");
  }
}
