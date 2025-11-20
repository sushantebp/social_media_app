import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static final SecureStorageService _instance =
      SecureStorageService._internal();

  factory SecureStorageService() => _instance;

  late final FlutterSecureStorage _secureStorage;

  SecureStorageService get instance => _instance;

  /// use [AndroidOptions] and [IOSOptions] classes used for specific platforms
  /// to customize how secure storage behaves on Android and iOS devices.
  SecureStorageService._internal() {
    _secureStorage = FlutterSecureStorage(
      aOptions: _getAndroidOptions(),
      iOptions: _getIosOptions(),
    );
  }

  /// securely keys stored in Android Keystore.
  static AndroidOptions _getAndroidOptions() =>
      const AndroidOptions(encryptedSharedPreferences: true);

  ///  securely keys stored on iOS using the system Keychain
  static IOSOptions _getIosOptions() => const IOSOptions(
    accessibility: KeychainAccessibility.first_unlock,
    synchronizable: true,
  );

  Future<void> write(String key, String value) async =>
      await _secureStorage.write(key: key, value: value);

  Future<String?> read(String key) async => await _secureStorage.read(key: key);

  Future<void> delete(String key) async =>
      await _secureStorage.delete(key: key);
}
