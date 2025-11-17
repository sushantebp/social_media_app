import 'package:social_media_app/core/core.dart';
import 'package:social_media_app/features/dashboard/dashboard.dart';

abstract class PostRepository {
  Future<Result<String>> subscribe();
  Future<Result<bool>> isSubscribe();

  Future<Result<CreatePostResponseModel>> createNewPost(
    CreatePostRequestModel request,
  );
  Future<Result<GetPostResponseModel>> getPosts({int page = 1, int limit = 10});

  
  Future<Result<GetUserFeedResponseModel>> getFeed({
    int page = 1,
    int limit = 10,
  });

  Future<Result<CreatePostResponseModel>> getPostById(String id);

  Future<Result<CreatePostResponseModel>> updatePost(String id);

  Future<Result> deletePost(String id);
  // like/unlike post
  Future<Result> togglePost();
}
