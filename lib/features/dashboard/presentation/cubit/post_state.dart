part of 'post_cubit.dart';

@freezed
abstract class PostState with _$PostState {
  const factory PostState.initial() = _Initial;

  const factory PostState.loading() = _Loading;

  const factory PostState.loaded({
    CreatePostResponseModel? postResponse,
    GetPostResponseModel? posts,

    String? successMessage,
    String? url,
  }) = _Loaded;

  const factory PostState.error(String? errorMessage) = _Error;
}
