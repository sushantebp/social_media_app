// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_user_profile_response_model.freezed.dart';
part 'get_user_profile_response_model.g.dart';

@freezed
abstract class UserAcademicsProfileResponseModel
    with _$UserAcademicsProfileResponseModel {
  const factory UserAcademicsProfileResponseModel({required UserAcademics user}) =
      _UserAcademicsProfileResponseModel;

  factory UserAcademicsProfileResponseModel.fromJson(Map<String, dynamic> json) =>
      _$UserAcademicsProfileResponseModelFromJson(json);
}

@freezed
abstract class UserAcademics with _$UserAcademics {
  const factory UserAcademics({
    required VerificationCodeAcademics verificationCode,
    @JsonKey(name: '_id') required String id,
    required String name,
    required String email,
    required String password,
    required List<String> hobbies,
    String? dateOfBirth, // could also be DateTime? with converter
    required List<String> followers,
    required List<String> following,
    String? resetPasswordToken,
    required List<String> loginIp,
    required List<String> whitelist,
    required bool verified,
    required int defaultVerificationCode,
    required List<AcademicItem> academicQualification,
    @JsonKey(name: '__v') required int version,
  }) = _UserAcademics;

  factory UserAcademics.fromJson(Map<String, dynamic> json) =>
      _$UserAcademicsFromJson(json);
}

@freezed
abstract class VerificationCodeAcademics with _$VerificationCodeAcademics {
  const factory VerificationCodeAcademics({
    required String createdAt, // or DateTime
  }) = _VerificationCodeAcademics;

  factory VerificationCodeAcademics.fromJson(Map<String, dynamic> json) =>
      _$VerificationCodeAcademicsFromJson(json);
}

@freezed
abstract class AcademicItem with _$AcademicItem {
  const factory AcademicItem({
    required int passedYear,
    required String degreeName,
    @JsonKey(name: '_id') required String id,
  }) = _AcademicItem;

  factory AcademicItem.fromJson(Map<String, dynamic> json) =>
      _$AcademicItemFromJson(json);
}
