import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_dob_response.freezed.dart';
part 'update_dob_response.g.dart';

@freezed
abstract class UpdateDobResponse with _$UpdateDobResponse {
  const factory UpdateDobResponse({
    required String status,
    required UpdateDobData data,
  }) = _UpdateDobResponse;

  factory UpdateDobResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateDobResponseFromJson(json);
}

@freezed
abstract class UpdateDobData with _$UpdateDobData {
  const factory UpdateDobData({
    required String dateOfBirth, // format "YYYY-MM-DD"
  }) = _UpdateDobData;

  factory UpdateDobData.fromJson(Map<String, dynamic> json) =>
      _$UpdateDobDataFromJson(json);
}
