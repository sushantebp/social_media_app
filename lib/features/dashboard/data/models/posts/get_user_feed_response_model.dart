import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_user_feed_response_model.freezed.dart';
part 'get_user_feed_response_model.g.dart';

@freezed
abstract class GetUserFeedResponseModel with _$GetUserFeedResponseModel {
  const factory GetUserFeedResponseModel({
    required String status,
    required GetUserFeedData data,
  }) = _GetUserFeedResponseModel;

  factory GetUserFeedResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GetUserFeedResponseModelFromJson(json);
}

@freezed
abstract class GetUserFeedData with _$GetUserFeedData {
  const factory GetUserFeedData({
    required List<FeedPost> posts,
    required Pagination pagination,
  }) = _GetUserFeedData;

  factory GetUserFeedData.fromJson(Map<String, dynamic> json) =>
      _$GetUserFeedDataFromJson(json);
}

@freezed
abstract class FeedPost with _$FeedPost {
  const factory FeedPost({
    required String id,
    required String title,
    required String content,
    required String image,
    required Author author,
    required int likesCounter,
    required String createdAt,
    required String updatedAt,
  }) = _FeedPost;

  factory FeedPost.fromJson(Map<String, dynamic> json) =>
      _$FeedPostFromJson(json);
}

@freezed
abstract class Author with _$Author {
  const factory Author({required String id, required String name}) = _Author;

  factory Author.fromJson(Map<String, dynamic> json) => _$AuthorFromJson(json);
}

@freezed
abstract class Pagination with _$Pagination {
  const factory Pagination({
    required int currentPage,
    required int totalPages,
    required int totalPosts,
  }) = _Pagination;

  factory Pagination.fromJson(Map<String, dynamic> json) =>
      _$PaginationFromJson(json);
}
