import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_auth_request_model.freezed.dart';
part 'user_auth_request_model.g.dart';

@freezed
abstract class UserAuthRequestModel with _$UserAuthRequestModel {
  const factory UserAuthRequestModel({
    String? name,
    required String email,
    required String password,
  }) = _UserAuthRequestModel;

  factory UserAuthRequestModel.fromJson(Map<String, dynamic> json) =>
      _$UserAuthRequestModelFromJson(json);
}
