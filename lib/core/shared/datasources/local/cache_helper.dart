import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:vpn/core/shared/extensions/extension.dart';
import 'package:vpn/features/auth/data/models/user_model.dart';
import 'package:vpn/features/select_country/data/models/countries_model.dart';
import 'package:vpn/features/select_country/domain/entities/countries_entity.dart';
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

  Future saveVersionVpn(dynamic version) async {
    await saveData(key: 'version_vpn', value: version);
  }

  Future<dynamic> getVersionVpn() async {
    dynamic jsonString = await getData('version_vpn');
    if (jsonString != null) {
      return "$jsonString".safeParseToInt();
    } else {
      return 0;
    }
  }

  Future saveVpnServer(VpnList vpnList) async {
    String jsonString = json.encode(vpnList.toJson());
    await saveData(key: 'vpn_server', value: jsonString);
  }

  Future<VpnList?> getVpnServer() async {
    String? jsonString = await getData('vpn_server');
    if (jsonString != null) {
      jsonString = jsonString.trim();
      var res = VpnList.fromJson(json.decode(jsonString));
      return res;
    } else {
      return null;
    }
  }

  Future saveCountriesModel(CountriesModel countriesModel) async {
    String jsonString = json.encode(countriesModel.toJson());
    await saveData(key: 'countries_model', value: jsonString);
  }

  Future<CountriesModel?> getCountriesModel() async {
    String? jsonString = await getData('countries_model');
    if (jsonString != null) {
      var res = CountriesModel.fromJson(json.decode(jsonString));
      return res;
    } else {
      return null;
    }
  }

  Future saveCountriesFavorite(List<String> favorite) async {
    String jsonString = json.encode(favorite);
    await saveData(key: 'save_countries_favorite', value: jsonString);
  }

  Future<List<String>?> getCountriesFavorite() async {
    String? jsonString = await getData('save_countries_favorite');
    if (jsonString != null) {
      var res = List<String>.from(json.decode(jsonString));
      return res;
    } else {
      return null;
    }
  }
}
