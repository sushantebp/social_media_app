// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_post_response_model.freezed.dart';
part 'create_post_response_model.g.dart';

@freezed
abstract class CreatePostResponseModel with _$CreatePostResponseModel {
  const factory CreatePostResponseModel({
    required String message,
    required PostData post,
  }) = _CreatePostResponseModel;

  factory CreatePostResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CreatePostResponseModelFromJson(json);
}

@freezed
abstract class PostData with _$PostData {
  const factory PostData({
    required String title,
    required String content,
    required String image,
    required String author,
    required int likesCounter,
    required List<String> likes,
    @JsonKey(name: '_id') required String id,
    required String createdAt,
    required String updatedAt,
  }) = _PostData;

  factory PostData.fromJson(Map<String, dynamic> json) =>
      _$PostDataFromJson(json);
}
