part of 'post_cubit.dart';

@freezed
abstract class PostState with _$PostState {
  const factory PostState.initial() = _Initial;

  const factory PostState.loading() = _Loading;

  const factory PostState.loaded({
    CreatePostResponseModel? postResponse,
    String? successMessage,
    String? url,
  }) = _Loaded;

  const factory PostState.error(String? errorMessage) = _Error;

  // Pagination states
  const factory PostState.loadingMore(List<GetPostItem> posts) = _LoadingMore;

  const factory PostState.postsLoaded({
    required List<GetPostItem> posts,
    required bool hasNextPage,
  }) = _PostsLoaded;
}
