import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:vpn/core/shared/model/security_model.dart';

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

  Future<bool> clearData() async {
    return await sharedPreferences!.clear();
  }

  Future saveSecurityDataAlgithms(SecurityModel securityModel) async {
    String jsonString = json.encode(securityModel.toJson());
    await saveData(key: 'security', value: jsonString);
  }

  Future<SecurityModel?> getSecurityDataAlgithms() async {
    String? jsonString = await getData('security');
    if (jsonString != null) {
      var res = SecurityModel.fromJson(json.decode(jsonString));
      return res;
    } else {
      return null;
    }
  }
}
