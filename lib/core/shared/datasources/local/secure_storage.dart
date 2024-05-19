import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static final SecureStorage _singleton = SecureStorage._internal();
  factory SecureStorage() => _singleton;
  SecureStorage._internal() {
    _secureStorage = FlutterSecureStorage(
      aOptions: _getAndroidOptions(),
      iOptions: _getIOSOptions(),
      mOptions: _getMacOSOptions(),
    );
  }

  late FlutterSecureStorage _secureStorage;

  Future<void> saveData({
    required String key,
    required String value,
  }) async {
    try {
      await _secureStorage.write(key: key, value: value);
    } catch (e) {
      rethrow;
    }
  }

  Future<String?> getData(String key) async {
    try {
      return await _secureStorage.read(key: key);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteSecureData(String key) async {
    await _secureStorage.delete(key: key);
  }

  Future<void> deleteAllSecureData() async {
    await _secureStorage.deleteAll();
  }

  Future<bool> containsKeyInSecureData(String key) async {
    var containsKey = await _secureStorage.containsKey(key: key);
    return containsKey;
  }

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  IOSOptions _getIOSOptions() => const IOSOptions(
        accessibility: KeychainAccessibility.first_unlock,
      );

  MacOsOptions _getMacOSOptions() => const MacOsOptions(
        accessibility: KeychainAccessibility.unlocked,
      );
}
