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
      result.fold(
        (failure) => emit(_Error(failure.message ?? "Failed to subscribe")),
        (url) =>
            emit(_Loaded(successMessage: "Subscription required", url: url)),
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

  /// ----------------------
  /// Pagination logic for posts
  /// ----------------------
  final List<GetPostItem> _posts = [];
  int _currentPage = 1;
  bool _hasNextPage = true;
  bool _isLoadingMore = false;

  List<GetPostItem> get posts => List.unmodifiable(_posts);

  Future<void> fetchPosts({bool refresh = false}) async {
    if (_isLoadingMore) return;

    if (refresh) {
      _currentPage = 1;
      _hasNextPage = true;
      _posts.clear();
    }

    if (!_hasNextPage) return;

    _isLoadingMore = true;
    emit(PostState.loadingMore(_posts));

    try {
      final result = await _postRepository.getPosts(
        page: _currentPage,
        limit: 10,
      );

      result.fold(
        (failure) => emit(_Error(failure.message ?? "Failed to fetch posts")),
        (data) {
          _posts.addAll(data.postList);
          _currentPage++;
          _hasNextPage = data.hasNextPage;
          emit(_PostsLoaded(posts: _posts, hasNextPage: _hasNextPage));
        },
      );
    } catch (e) {
      emit(_Error(e.toString()));
    } finally {
      _isLoadingMore = false;
    }
  }
}
