import 'package:social_media_app/core/core.dart';
import 'package:social_media_app/features/auth/auth.dart';

abstract class AuthLocalDataSource {
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> clearToken();

  Future<void> saveUserInfo(UserAuthData userInfo);
  Future<void> clearAll();
}

class AuthLocalDataSourceImpl extends AuthLocalDataSource {
  final SecureStorageService _secureStorageService;
  final LocalStorageService _localStorageService;
  AuthLocalDataSourceImpl(
    this._secureStorageService,
    this._localStorageService,
  );

  @override
  Future<void> saveToken(String token) async =>
      await _secureStorageService.write(AppConstant.tokenKey, token);

  @override
  Future<String?> getToken() async =>
      await _secureStorageService.read(AppConstant.tokenKey);

  @override
  Future<void> clearToken() async =>
      _secureStorageService.delete(AppConstant.tokenKey);

  @override
  Future<void> saveUserInfo(UserAuthData userInfo) async =>
      await _localStorageService.saveUserInfo(userInfo);

  @override
  Future<void> clearAll() async {
    await clearToken();
    await _localStorageService.clearUserInfo();
  }
}
