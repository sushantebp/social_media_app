import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_post_response_model.freezed.dart';
part 'create_post_response_model.g.dart';

/// Represents the response returned after creating a post
@freezed
abstract class CreatePostResponseModel with _$CreatePostResponseModel {
  const factory CreatePostResponseModel({
    required String status,
    required PostData data,
  }) = _CreatePostResponseModel;

  factory CreatePostResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CreatePostResponseModelFromJson(json);
}

/// Wrapper for post data in the response
@freezed
abstract class PostData with _$PostData {
  const factory PostData({required PostModel post}) = _PostData;

  factory PostData.fromJson(Map<String, dynamic> json) =>
      _$PostDataFromJson(json);
}

/// Represents the post object itself
@freezed
abstract class PostModel with _$PostModel {
  const factory PostModel({
    required String id,
    required String title,
    required String content,
    required String image,
    required AuthorModel author,
    required int likesCounter,
    required String createdAt,
    required String updatedAt,
  }) = _PostModel;

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);
}

/// Represents the author object inside a post
@freezed
abstract class AuthorModel with _$AuthorModel {
  const factory AuthorModel({required String id, required String name}) =
      _AuthorModel;

  factory AuthorModel.fromJson(Map<String, dynamic> json) =>
      _$AuthorModelFromJson(json);
}
