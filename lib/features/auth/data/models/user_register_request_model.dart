import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_register_request_model.freezed.dart';
part 'user_register_request_model.g.dart';

@freezed
abstract class UserRegisterRequestModel with _$UserRegisterRequestModel {
  const factory UserRegisterRequestModel({
    required String name,
    required String email,
    required String password,
  }) = _UserRegisterRequestModel;

  factory UserRegisterRequestModel.fromJson(Map<String, dynamic> json) =>
      _$UserRegisterRequestModelFromJson(json);
}
