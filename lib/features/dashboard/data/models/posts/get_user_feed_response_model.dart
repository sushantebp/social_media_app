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
    required FeedPagination pagination,
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
    required FeedAuthor author,
    required int likesCounter,
    required String createdAt,
    required String updatedAt,
  }) = _FeedPost;

  factory FeedPost.fromJson(Map<String, dynamic> json) =>
      _$FeedPostFromJson(json);
}

@freezed
abstract class FeedAuthor with _$FeedAuthor {
  const factory FeedAuthor({required String id, required String name}) =
      _FeedAuthor;

  factory FeedAuthor.fromJson(Map<String, dynamic> json) =>
      _$FeedAuthorFromJson(json);
}

@freezed
abstract class FeedPagination with _$FeedPagination {
  const factory FeedPagination({
    required int currentPage,
    required int totalPages,
    required int totalPosts,
  }) = _FeedPagination;

  factory FeedPagination.fromJson(Map<String, dynamic> json) =>
      _$FeedPaginationFromJson(json);
}
