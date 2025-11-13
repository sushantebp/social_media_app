import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_post_response_model.freezed.dart';
part 'get_post_response_model.g.dart';

@freezed
abstract class GetPostResponseModel with _$GetPostResponseModel {
  const factory GetPostResponseModel({
    required String status,
    required GetPostData data,
  }) = _GetPostResponseModel;

  factory GetPostResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GetPostResponseModelFromJson(json);
}

@freezed
abstract class GetPostData with _$GetPostData {
  const factory GetPostData({
    required List<Post> posts,
    required Pagination pagination,
  }) = _GetPostData;

  factory GetPostData.fromJson(Map<String, dynamic> json) =>
      _$GetPostDataFromJson(json);
}

@freezed
abstract class Post with _$Post {
  const factory Post({
    required String id,
    required String title,
    required String content,
    required String image,
    required Author author,
    required int likesCounter,
    required String createdAt,
    required String updatedAt,
  }) = _Post;

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
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
