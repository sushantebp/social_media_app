import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_academic_request.freezed.dart';
part 'create_academic_request.g.dart';

@freezed
abstract class CreateAcademicRequest with _$CreateAcademicRequest {
  const factory CreateAcademicRequest({
    required List<AcademicQualificationItem> academicQualification,
  }) = _CreateAcademicRequest;

  factory CreateAcademicRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateAcademicRequestFromJson(json);
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
