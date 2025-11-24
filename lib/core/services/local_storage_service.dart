import 'package:hive_ce_flutter/adapters.dart';
import 'package:injectable/injectable.dart';
import 'package:social_media_app/core/core.dart';
import 'package:social_media_app/features/auth/auth.dart';
import 'package:social_media_app/features/dashboard/dashboard.dart';
import 'package:social_media_app/hive_registrar.g.dart';

/// [_userInfo] define basic stuff of user like name,email
/// [_userDetails] define whole about user details like hobbies,their location etc
/// [_userLocation] define about user's location's lat and lang,basically coordinates
@lazySingleton
class LocalStorageService {
  LocalStorageService._();

  static final LocalStorageService _instance = LocalStorageService._();
  factory LocalStorageService() => _instance;

  LocalStorageService get instance => _instance;

  late Box<UserAuthData> _userInfo;
  late Box<LocalUserDetailsModel> _userLocalDetails;
  late Box<UserLocationModel> _userLocation;

  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapters();

    _userInfo = await Hive.openBox<UserAuthData>(AppConstant.userInfoBox);
    _userLocalDetails = await Hive.openBox<LocalUserDetailsModel>(
      AppConstant.userLocalDetailsBox,
    );

    _userLocation = await Hive.openBox<UserLocationModel>(
      AppConstant.userLcoationBox,
    );
  }

  // related to _userInfo
  Future<void> saveUserInfo(UserAuthData value) async =>
      await _userInfo.put(AppConstant.userInfoKey, value);

  UserAuthData? getUserInfo() => _userInfo.get(AppConstant.userInfoKey);

  Future<void> clearUserInfo() async =>
      await _userInfo.delete(AppConstant.userInfoKey);

  // related to _userLocalDetails
  Future<void> saveUserLocalDetails(LocalUserDetailsModel model) async =>
      await _userLocalDetails.put(AppConstant.userLocalDetailsBox, model);

  LocalUserDetailsModel? getUserLocalDetails() =>
      _userLocalDetails.get(AppConstant.userLocalDetailsBox);

  Future<void> clearUserLocalDetails() async =>
      await _userLocalDetails.delete(AppConstant.userLocalDetailsBox);

  // saving user location
  Future<void> saveUserLocation(UserLocationModel model) async =>
      await _userLocation.put(AppConstant.userLocationKey, model);

  UserLocationModel? getUserLocation() =>
      _userLocation.get(AppConstant.userLocationKey);

  Future<void> clearUserLocation() async =>
      await _userLocation.delete(AppConstant.userLocationKey);
}
