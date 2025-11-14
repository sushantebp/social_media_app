import 'package:freezed_annotation/freezed_annotation.dart';

part 'location_request_model.freezed.dart';
part 'location_request_model.g.dart';

@freezed
abstract class LocationRequestModel with _$LocationRequestModel {
  const factory LocationRequestModel({required LocationModel location}) =
      _LocationRequestModel;

  factory LocationRequestModel.fromJson(Map<String, dynamic> json) =>
      _$LocationRequestModelFromJson(json);
}

/// Response model after updating location
@freezed
abstract class LocationResponseModel with _$LocationResponseModel {
  const factory LocationResponseModel({
    required String status,
    required LocationDataModel data,
  }) = _LocationResponseModel;

  factory LocationResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LocationResponseModelFromJson(json);
}

/// Inner data of response
@freezed
abstract class LocationDataModel with _$LocationDataModel {
  const factory LocationDataModel({required LocationModel location}) =
      _LocationDataModel;

  factory LocationDataModel.fromJson(Map<String, dynamic> json) =>
      _$LocationDataModelFromJson(json);
}

/// Location model used in both request and response
@freezed
abstract class LocationModel with _$LocationModel {
  const factory LocationModel({
    required String type, // e.g. "Point"
    required List<double> coordinates, // [latitude, longitude]
  }) = _LocationModel;

  factory LocationModel.fromJson(Map<String, dynamic> json) =>
      _$LocationModelFromJson(json);
}
