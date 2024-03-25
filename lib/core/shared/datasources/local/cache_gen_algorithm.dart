import 'dart:convert';

import 'package:basic_utils/basic_utils.dart';
import 'package:vpn/core/shared/datasources/local/secure_storage.dart';
import 'package:vpn/core/shared/model/security_model.dart';

class CacheGenAlgorithm {
  CacheGenAlgorithm(this._secureStorage);
  final SecureStorage _secureStorage;

  Future saveSecurityDataAlgithms(SecurityModel securityModel) async {
    String jsonString = json.encode(securityModel.toJsonInit());
    await _secureStorage.saveData(key: 'security', value: jsonString);
  }

  Future<SecurityModel?> getSecurityDataAlgithms() async {
    String? jsonString = await _secureStorage.getData('security');
    if (jsonString != null) {
      var res = SecurityModel.fromJson(json.decode(jsonString));
      return res;
    } else {
      return null;
    }
  }

  void saveRSAPrivateKey(RSAPrivateKey privateKey) async {
    final private = CryptoUtils.encodeRSAPrivateKeyToPemPkcs1(privateKey);
    _secureStorage.saveData(key: 'RSAPrivateKey', value: private);
  }

  Future<RSAPrivateKey?> getSavedRSAPrivateKey() async {
    try {
      String? privateKeyData = await _secureStorage.getData('RSAPrivateKey');
      if (privateKeyData != null) {
        final key = CryptoUtils.rsaPrivateKeyFromPemPkcs1(privateKeyData);
        return key;
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  void saveRSAPublicKey(RSAPublicKey privateKey) async {
    final private = CryptoUtils.encodeRSAPublicKeyToPemPkcs1(privateKey);
    _secureStorage.saveData(key: 'RSAPublicKey', value: private);
  }

  Future<RSAPublicKey?> getSavedRSAPublicKey() async {
    try {
      String? privateKeyData = await _secureStorage.getData('RSAPublicKey');
      if (privateKeyData != null) {
        final key = CryptoUtils.rsaPublicKeyFromPemPkcs1(privateKeyData);
        return key;
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }
}
