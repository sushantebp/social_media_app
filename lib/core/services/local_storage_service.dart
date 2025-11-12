import 'package:hive_ce_flutter/adapters.dart';
import 'package:social_media_app/core/core.dart';
import 'package:social_media_app/features/auth/auth.dart';

import 'package:social_media_app/hive_registrar.g.dart';

class LocalStorageService {
  LocalStorageService._();

  static final LocalStorageService _instance = LocalStorageService._();
  factory LocalStorageService() => _instance;

  late Box<UserModel> _userInfo;

  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapters();

    _userInfo = await Hive.openBox<UserModel>(AppConstant.userInfoBox);
  }

  Future<void> saveUserInfo(UserModel value) async =>
      await _userInfo.put(AppConstant.userInfoKey, value);

  UserModel? getUserInfo() => _userInfo.get(AppConstant.userInfoKey);

  Future<void> clearUserInfo() async =>
      await _userInfo.delete(AppConstant.userInfoKey);
}
