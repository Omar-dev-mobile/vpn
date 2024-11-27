import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:vpn/core/shared/extensions/extension.dart';
import 'package:vpn/features/auth/data/models/user_model.dart';
import 'package:vpn/features/select_country/data/models/countries_model.dart';
import 'package:vpn/features/tarif/data/models/tarif_model.dart';

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
      print("error clear data");
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
    try {
      await saveData(key: 'version_vpn', value: version);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getVersionVpn() async {
    try {
      dynamic jsonString = await getData('version_vpn');
      if (jsonString != null) {
        return "$jsonString".safeParseToInt();
      } else {
        return 0;
      }
    } catch (e) {
      return null;
    }
  }
  Future<void> saveVpnAgreementChoice(bool? choice) async {
    try {
      await saveData(key: 'vpn_agreement_choice', value: choice);
    } catch (e) {
      rethrow;
    }
  }

  // Get VPN Agreement Choice
  Future<bool?> getVpnAgreementChoice() async {
    try {
      return getData('vpn_agreement_choice');
    } catch (e) {
      return null; // Default value when no choice is saved
    }
  }

  Future saveVpnServer(VpnListModel vpnList) async {
    try {
      String jsonString = json.encode(vpnList.toJson());
      await saveData(key: 'vpn_server', value: jsonString);
    } catch (e) {
      rethrow;
    }
  }

  Future<VpnListModel?> getVpnServer() async {
    try {
      String? jsonString = await getData('vpn_server');
      if (jsonString != null) {
        jsonString = jsonString.trim();
        var res = VpnListModel.fromJson(json.decode(jsonString));
        return res;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future saveCountriesModel(CountriesModel countriesModel) async {
    try {
      String jsonString = json.encode(countriesModel.toJson());
      await saveData(key: 'countries_model', value: jsonString);
    } catch (e) {
      rethrow;
    }
  }

  Future<CountriesModel?> getCountriesModel() async {
    try {
      String? jsonString = await getData('countries_model');
      if (jsonString != null) {
        var res = CountriesModel.fromJson(json.decode(jsonString));
        return res;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future saveTarifModel(TarifModel countriesModel) async {
    try {
      String jsonString = json.encode(countriesModel.toJson());
      await saveData(key: 'tarif_model', value: jsonString);
    } catch (e) {
      rethrow;
    }
  }

  Future<TarifModel?> getTarifModel() async {
    try {
      String? jsonString = await getData('tarif_model');
      if (jsonString != null) {
        var res = TarifModel.fromJson(json.decode(jsonString));
        return res;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future saveCountriesFavorite(List<String> favorite) async {
    try {
      String jsonString = json.encode(favorite);
      await saveData(key: 'save_countries_favorite', value: jsonString);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<String>?> getCountriesFavorite() async {
    try {
      String? jsonString = await getData('save_countries_favorite');
      if (jsonString != null) {
        var res = List<String>.from(json.decode(jsonString));
        return res;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future saveThemeMode(String theme) async {
    try {
      await saveData(key: 'theme_mode', value: theme);
    } catch (e) {
      rethrow;
    }
  }

  Future<String?> getThemeMode() async {
    try {
      String? jsonString = await getData('theme_mode');
      if (jsonString != null) {
        return jsonString;
      } else {
        return "";
      }
    } catch (e) {
      return "";
    }
  }

  Future saveBaySubscription(String isBay) async {
    try {
      await saveData(key: 'bay_subscription', value: isBay);
    } catch (e) {
      rethrow;
    }
  }

  Future<String?> getBaySubscription() async {
    try {
      String? jsonString = await getData('bay_subscription');
      if (jsonString != null) {
        return jsonString;
      } else {
        return "";
      }
    } catch (e) {
      return "";
    }
  }

  Future saveFirstRun(bool val) async {
    try {
      await saveData(key: 'first_run', value: val);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> getFirstRun() async {
    try {
      bool? jsonString = await getData('first_run');
      if (jsonString != null) {
        return jsonString;
      } else {
        return true;
      }
    } catch (e) {
      return true;
    }
  }
}
