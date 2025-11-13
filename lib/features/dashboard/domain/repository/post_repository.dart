import 'package:social_media_app/core/core.dart';
import 'package:social_media_app/features/dashboard/dashboard.dart';
import 'package:social_media_app/features/dashboard/data/models/posts/get_post_response_model.dart';
import 'package:social_media_app/features/dashboard/data/models/posts/get_user_feed_response_model.dart';

abstract class PostRepository {
  Future<Result<CreatePostResponseModel>> createNewPost(
    CreatePostRequestModel request,
  );
  // get posts(paginated)
  Future<Result<GetPostResponseModel>> getPosts();
  // get user feeds
  Future<Result<GetUserFeedResponseModel>> getFeed();

  Future<Result<CreatePostResponseModel>> getPostById(String id);

  Future<Result<CreatePostResponseModel>> updatePost(String id);

  // response are still unsure for them
  // they are need to be defined
  Future<Result> deletePost(String id);

  Future<Result> togglePost();
}
