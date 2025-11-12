import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce/hive.dart';

part 'user_register_response_model.freezed.dart';
part 'user_register_response_model.g.dart';

@freezed
abstract class UserRegisterResponseModel with _$UserRegisterResponseModel {
  const factory UserRegisterResponseModel({
    required String message,
    required UserRegisterData data,
  }) = _UserRegisterResponseModel;

  factory UserRegisterResponseModel.fromJson(Map<String, dynamic> json) =>
      _$UserRegisterResponseModelFromJson(json);
}

@freezed
abstract class UserRegisterData with _$UserRegisterData {
  const factory UserRegisterData({
    required String token,
    required UserModel user,
  }) = _UserRegisterData;

  factory UserRegisterData.fromJson(
    Map<String, dynamic> json,
  ) => _$UserRegisterDataFromJson({
    // flatten API response fields into nested structure
    "token": json["token"],
    "user": {"id": json["id"], "name": json["name"], "email": json["email"]},
  });
}

@freezed
@HiveType(typeId: 1)
abstract class UserModel with _$UserModel {
  const factory UserModel({
    @HiveField(0) required String id,
    @HiveField(1) required String name,
    @HiveField(2) required String email,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
