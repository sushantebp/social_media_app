import 'package:freezed_annotation/freezed_annotation.dart';

part 'academic_response_model.freezed.dart';
part 'academic_response_model.g.dart';

@freezed
abstract class AcademicResponseModel with _$AcademicResponseModel {
  const factory AcademicResponseModel({
    required String status,
    required AcademicData data,
  }) = _AcademicResponseModel;

  factory AcademicResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AcademicResponseModelFromJson(json);
}

@freezed
abstract class AcademicData with _$AcademicData {
  const factory AcademicData({
    required List<AcademicQualificationItem> academicQualification,
  }) = _AcademicData;

  factory AcademicData.fromJson(Map<String, dynamic> json) =>
      _$AcademicDataFromJson(json);
}

@freezed
abstract class AcademicQualificationItem with _$AcademicQualificationItem {
  const factory AcademicQualificationItem({
    required int passedYear,
    required String degreeName,
  }) = _AcademicQualificationItem;

  factory AcademicQualificationItem.fromJson(Map<String, dynamic> json) =>
      _$AcademicQualificationItemFromJson(json);
}
