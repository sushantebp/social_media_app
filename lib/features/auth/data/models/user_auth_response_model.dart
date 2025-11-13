import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce_flutter/adapters.dart';

part 'user_auth_response_model.freezed.dart';
part 'user_auth_response_model.g.dart';

@freezed
abstract class UserAuthResponseModel with _$UserAuthResponseModel {
  const factory UserAuthResponseModel({
    required String message,
    required UserAuthData data,
  }) = _UserAuthResponseModel;

  factory UserAuthResponseModel.fromJson(Map<String, dynamic> json) =>
      _$UserAuthResponseModelFromJson(json);
}

@freezed
@HiveType(typeId: 1)
abstract class UserAuthData with _$UserAuthData {
  const factory UserAuthData({
    String? token,
    @HiveField(0) required String id,
    @HiveField(1) required String name,
    @HiveField(2) required String email,
  }) = _UserAuthData;

  factory UserAuthData.fromJson(Map<String, dynamic> json) =>
      _$UserAuthDataFromJson(json);
}
