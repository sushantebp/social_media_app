import 'package:freezed_annotation/freezed_annotation.dart';

part 'common_response_model.freezed.dart';
part 'common_response_model.g.dart';

@freezed
abstract class CommonResponseModel with _$CommonResponseModel {
  const factory CommonResponseModel({
    required String status,
    required String message,
    String? name,
  }) = _CommonResponseModel;

  factory CommonResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CommonResponseModelFromJson(json);
}
