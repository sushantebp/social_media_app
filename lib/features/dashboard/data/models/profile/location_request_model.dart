import 'package:freezed_annotation/freezed_annotation.dart';

part 'location_request_model.freezed.dart';
part 'location_request_model.g.dart';

@freezed
abstract class LocationRequestWrapper with _$LocationRequestWrapper {
  const factory LocationRequestWrapper({required LocationRequestData data}) =
      _LocationRequestWrapper;

  factory LocationRequestWrapper.fromJson(Map<String, dynamic> json) =>
      _$LocationRequestWrapperFromJson(json);
}

@freezed
abstract class LocationRequestData with _$LocationRequestData {
  const factory LocationRequestData({required UserLocationModel location}) =
      _LocationRequestData;

  factory LocationRequestData.fromJson(Map<String, dynamic> json) =>
      _$LocationRequestDataFromJson(json);
}

@freezed
abstract class UserLocationModel with _$UserLocationModel {
  const factory UserLocationModel({required double lat, required double lng}) =
      _UserLocationModel;

  factory UserLocationModel.fromJson(Map<String, dynamic> json) =>
      _$UserLocationModelFromJson(json);
}
