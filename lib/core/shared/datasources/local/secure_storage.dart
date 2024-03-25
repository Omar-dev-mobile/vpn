import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static final SecureStorage _singleton = SecureStorage._internal();
  factory SecureStorage() => _singleton;
  SecureStorage._internal() {
    _secureStorage = FlutterSecureStorage(
      aOptions: _getAndroidOptions(),
    );
  }

  late FlutterSecureStorage _secureStorage;

  saveData({
    required String key,
    required dynamic value,
  }) async {
    try {
      await _secureStorage.write(key: key, value: value);
    } catch (e) {
      rethrow;
    }
  }

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  dynamic getData(String key) async {
    try {
      return await _secureStorage.read(key: key);
    } catch (e) {
      rethrow;
    }
  }

  deleteSecureData(String key) async {
    await _secureStorage.delete(key: key);
  }

  Future<void> deleteAllSecureData() async {
    await _secureStorage.deleteAll(aOptions: _getAndroidOptions());
  }

  Future<bool> containsKeyInSecureData(String key) async {
    var containsKey = await _secureStorage.containsKey(
        key: key, aOptions: _getAndroidOptions());
    return containsKey;
  }
}
