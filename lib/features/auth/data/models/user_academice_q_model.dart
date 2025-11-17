import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_academice_q_model.freezed.dart';
part 'user_academice_q_model.g.dart';

@freezed
abstract class UserAcademiceQModel with _$UserAcademiceQModel {
  const factory UserAcademiceQModel({
    required String passedYear,
    required String degreeName,
  }) = _UserAcademiceQModel;

  factory UserAcademiceQModel.fromJson(Map<String, dynamic> json) =>
      _$UserAcademiceQModelFromJson(json);
}
