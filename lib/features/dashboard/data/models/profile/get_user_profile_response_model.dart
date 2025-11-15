// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_user_profile_response_model.freezed.dart';
part 'get_user_profile_response_model.g.dart';

@freezed
abstract class GetUserProfileResponseModel with _$GetUserProfileResponseModel {
  const factory GetUserProfileResponseModel({required User user}) =
      _GetUserProfileResponseModel;

  factory GetUserProfileResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GetUserProfileResponseModelFromJson(json);
}

@freezed
abstract class User with _$User {
  const factory User({
    required VerificationCode verificationCode,
    @JsonKey(name: '_id') required String id,
    required String name,
    required String email,
    required String password,
    required List<String> hobbies,
    String? dateOfBirth,
    required List<String> followers,
    required List<String> following,
    String? resetPasswordToken,
    required List<String> loginIp,
    required List<String> whitelist,
    required bool verified,
    required int defaultVerificationCode,
    required List<String> academicQualification,
    @JsonKey(name: '__v') required int v,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

@freezed
abstract class VerificationCode with _$VerificationCode {
  const factory VerificationCode({required String createdAt}) =
      _VerificationCode;

  factory VerificationCode.fromJson(Map<String, dynamic> json) =>
      _$VerificationCodeFromJson(json);
}
