import 'package:freezed_annotation/freezed_annotation.dart';

part 'hobbies_response_model.freezed.dart';
part 'hobbies_response_model.g.dart';

@freezed
abstract class HobbiesResponseModel with _$HobbiesResponseModel {
  const factory HobbiesResponseModel({
    required String status,
    required HobbiesData data,
  }) = _HobbiesResponseModel;

  factory HobbiesResponseModel.fromJson(Map<String, dynamic> json) =>
      _$HobbiesResponseModelFromJson(json);
}

@freezed
abstract class HobbiesData with _$HobbiesData {
  const factory HobbiesData({required List<String> hobbies}) = _HobbiesData;

  factory HobbiesData.fromJson(Map<String, dynamic> json) =>
      _$HobbiesDataFromJson(json);
}
