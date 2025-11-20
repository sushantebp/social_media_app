// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_post_response_model.freezed.dart';
part 'get_post_response_model.g.dart';

@freezed
abstract class GetPostResponseModel with _$GetPostResponseModel {
  const factory GetPostResponseModel({
    required List<GetPostItem> postList,
    required int currentPage,
    required int totalPages,
    required int totalPosts,
    required bool hasNextPage,
    required bool hasPrevPage,
  }) = _GetPostResponseModel;

  factory GetPostResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GetPostResponseModelFromJson(json);
}

@freezed
abstract class GetPostItem with _$GetPostItem {
  const factory GetPostItem({
    required GetPostPost post,
    required List<GetPostComment> latestComment,
  }) = _GetPostItem;

  factory GetPostItem.fromJson(Map<String, dynamic> json) =>
      _$GetPostItemFromJson(json);
}

@freezed
abstract class GetPostPost with _$GetPostPost {
  const factory GetPostPost({
    @JsonKey(name: "_id") required String id,
    required String title,
    required String content,
    required String image,
    required GetPostAuthor author,
    required int likesCounter,
    required List<String> likes,
    required String createdAt,
    required String updatedAt,
    @JsonKey(name: "__v") required int v,
  }) = _GetPostPost;

  factory GetPostPost.fromJson(Map<String, dynamic> json) =>
      _$GetPostPostFromJson(json);
}

@freezed
abstract class GetPostAuthor with _$GetPostAuthor {
  const factory GetPostAuthor({
    @JsonKey(name: "_id") required String id,
    required String name,
  }) = _GetPostAuthor;

  factory GetPostAuthor.fromJson(Map<String, dynamic> json) =>
      _$GetPostAuthorFromJson(json);
}

@freezed
abstract class GetPostComment with _$GetPostComment {
  const factory GetPostComment({
    @JsonKey(name: "_id") String? id,
    String? content,
    String? authorName,
    String? createdAt,
  }) = _GetPostComment;

  factory GetPostComment.fromJson(Map<String, dynamic> json) =>
      _$GetPostCommentFromJson(json);
}
