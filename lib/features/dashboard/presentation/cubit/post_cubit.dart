import 'dart:io';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:social_media_app/core/core.dart';
import 'package:social_media_app/features/dashboard/dashboard.dart';

part 'post_state.dart';
part 'post_cubit.freezed.dart';

class PostCubit extends BaseCubit<PostState> {
  final PostRepository _postRepository;
  PostCubit(this._postRepository) : super(const _Initial());

  /// Subscription URL
  Future<void> subscribe() async {
    emit(const _Loading());

    try {
      final result = await _postRepository.subscribe();
      await result.fold(
        (failure) async {
          emit(_Error(failure.message ?? "Failed to subscribe"));
        },
        (url) async {
          // Fetch posts after subscribing
          final postsResult = await _postRepository.getPosts();
          postsResult.fold(
            (failure) {
              // If fetching posts fails, still emit subscription success
              emit(
                _Loaded(
                  successMessage: "Subscription acquired",
                  url: url,
                  postResponse: null,
                ),
              );
            },
            (posts) {
              // Emit loaded state with posts + subscription info
              emit(
                _Loaded(
                  successMessage: "Subscription acquired",
                  url: url,
                  posts: posts,
                ),
              );
            },
          );
        },
      );
    } catch (e) {
      emit(_Error(e.toString()));
    }
  }

  /// Check subscription status
  Future<bool> isSubscribe() async {
    final result = await _postRepository.isSubscribe();
    return result.fold((failure) => false, (isSubscribed) => isSubscribed);
  }

  /// Create new post
  Future<void> createPost({
    required String title,
    required String content,
    File? image,
  }) async {
    emit(const _Loading());

    final request = CreatePostRequestModel(
      title: title,
      content: content,
      image: image,
    );

    try {
      final result = await _postRepository.createNewPost(request);
      result.fold(
        (failure) => emit(_Error(failure.message ?? "Failed to create post")),
        (success) => emit(
          _Loaded(successMessage: success.message, postResponse: success),
        ),
      );
    } catch (e) {
      emit(_Error(e.toString()));
    }
  }

  Future<void> getPosts() async {
    emit(const _Loading());
    try {
      final result = await _postRepository.getPosts();

      result.fold(
        (failure) {
          emit(_Error(failure.message ?? "Failed to get posts."));
        },
        (posts) {
          emit(_Loaded(posts: posts));
        },
      );
    } catch (e) {
      emit(_Error(e.toString()));
    }
  }
}
