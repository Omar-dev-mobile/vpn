import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:vpn/features/auth/data/models/user_model.dart';
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
    try {
      if (value is String) {
        return await sharedPreferences!.setString(key, value);
      }
      if (value is int) return await sharedPreferences!.setInt(key, value);
      if (value is bool) return await sharedPreferences!.setBool(key, value);

      return await sharedPreferences!.setDouble(key, value);
    } catch (e) {
      rethrow;
    }
  }

  dynamic getData(
    String key,
  ) {
    try {
      return sharedPreferences!.get(key);
    } catch (e) {
      return null;
    }
  }

  Future<bool> removeData({
    required String key,
  }) async {
    try {
      return await sharedPreferences!.remove(key);
    } catch (e) {
      rethrow;
    }
  }

  Future clearData() async {
    try {
      await sharedPreferences?.clear();
    } catch (e) {
      rethrow;
    }
  }

  Future saveToket(String token) async {
    await saveData(key: 'token', value: token);
  }

  Future<String> getToken() async {
    String? jsonString = await getData('token');
    if (jsonString != null) {
      return jsonString;
    } else {
      return "";
    }
  }

  Future saveUser(UserModel userModel) async {
    String jsonString = json.encode(userModel.toJson());
    print(userModel.workStatus?.toJson());
    await saveData(key: 'user', value: jsonString);
  }

  Future<UserModel?> getUser() async {
    String? jsonString = await getData('user');
    if (jsonString != null) {
      var res = UserModel.fromJson(json.decode(jsonString));
      return res;
    } else {
      return null;
    }
  }

  Future removeUser() async {
    await removeData(key: 'user');
  }
}
