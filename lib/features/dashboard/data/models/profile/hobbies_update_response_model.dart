// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'hobbies_update_response_model.freezed.dart';
part 'hobbies_update_response_model.g.dart';

@freezed
abstract class HobbiesUpdateResponseModel with _$HobbiesUpdateResponseModel {
  const factory HobbiesUpdateResponseModel({required UserHobbiesUpdate user}) =
      _HobbiesUpdateResponseModel;

  factory HobbiesUpdateResponseModel.fromJson(Map<String, dynamic> json) =>
      _$HobbiesUpdateResponseModelFromJson(json);
}

@freezed
abstract class UserHobbiesUpdate with _$UserHobbiesUpdate {
  const factory UserHobbiesUpdate({
    @JsonKey(name: '_id') required String id,
    String? name,
    String? email,
    String? password,
    DateTime? dateOfBirth,
    required HobbiesVerificationCode verificationCode,
    required List<String> hobbies,
    required List<String> followers,
    required List<String> following,
    String? resetPasswordToken,
    required List<String> loginIp,
    required List<String> whitelist,
    required bool verified,
    required int defaultVerificationCode,
    required List<AcademicQualificationItemHobbies> academicQualification,
    @JsonKey(name: '__v') required int version,
  }) = _UserHobbiesUpdate;

  factory UserHobbiesUpdate.fromJson(Map<String, dynamic> json) =>
      _$UserHobbiesUpdateFromJson(json);
}

@freezed
abstract class HobbiesVerificationCode with _$HobbiesVerificationCode {
  const factory HobbiesVerificationCode({required DateTime createdAt}) =
      _HobbiesVerificationCode;

  factory HobbiesVerificationCode.fromJson(Map<String, dynamic> json) =>
      _$HobbiesVerificationCodeFromJson(json);
}

@freezed
abstract class AcademicQualificationItemHobbies
    with _$AcademicQualificationItemHobbies {
  const factory AcademicQualificationItemHobbies({
    required int passedYear,
    required String degreeName,
    @JsonKey(name: '_id') required String id,
  }) = _AcademicQualificationItemHobbies;

  factory AcademicQualificationItemHobbies.fromJson(
    Map<String, dynamic> json,
  ) => _$AcademicQualificationItemHobbiesFromJson(json);
}
