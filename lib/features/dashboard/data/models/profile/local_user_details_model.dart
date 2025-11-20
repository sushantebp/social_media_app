// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce_flutter/adapters.dart';

import 'get_user_profile_response_model.dart';

part 'local_user_details_model.freezed.dart';
part 'local_user_details_model.g.dart';

@HiveType(typeId: 2)
abstract class LocalUserDetailsModel with _$LocalUserDetailsModel {
  const factory LocalUserDetailsModel({
    @HiveField(0) required String id,
    @HiveField(1) required String name,
    @HiveField(2) required String email,
    @HiveField(3) required bool verified,
    @HiveField(4) String? dateOfBirth,
    @HiveField(5) List<String>? hobbies,
    @HiveField(6) List<String>? followers,
    @HiveField(7) List<String>? following,
    @HiveField(8) int? defaultVerificationCode,
  }) = _LocalUserDetailsModel;

  /// Create LocalUserDetailsModel from backend UserAcademics model
  factory LocalUserDetailsModel.fromUserAcademics(UserAcademics user) =>
      LocalUserDetailsModel(
        id: user.id,
        name: user.name,
        email: user.email,
        verified: user.verified,
        dateOfBirth: user.dateOfBirth,
        hobbies: user.hobbies,
        followers: user.followers,
        following: user.following,
        defaultVerificationCode: user.defaultVerificationCode,
      );

  factory LocalUserDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$LocalUserDetailsModelFromJson(json);
}
