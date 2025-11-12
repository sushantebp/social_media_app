import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_login_request_model.freezed.dart';
part 'user_login_request_model.g.dart';

@freezed
abstract class UserLoginRequestModel with _$UserLoginRequestModel {
  const factory UserLoginRequestModel({
    required String email,
    required String password,
  }) = _UserLoginRequestModel;

  factory UserLoginRequestModel.fromJson(Map<String, dynamic> json) =>
      _$UserLoginRequestModelFromJson(json);
}
