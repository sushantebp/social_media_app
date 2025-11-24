import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:social_media_app/core/core.dart';
import 'package:social_media_app/features/dashboard/dashboard.dart';

abstract class PostRemoteDataSource {
  Future<String> subscribe();
  Future<bool> isSubscribe();

  Future<CreatePostResponseModel> createNewPost(CreatePostRequestModel request);
  Future<GetPostResponseModel> getPosts({int page = 1, int limit = 10});
  Future<GetUserFeedResponseModel> getFeed({int page = 1, int limit = 10});

  Future<CreatePostResponseModel> getPostById(String id);

  Future<CreatePostResponseModel> updatePost(String id);

  Future<String> deletePost(String id);
  // like/unlike post
  Future<String> togglePost();
}

@LazySingleton(as: PostRemoteDataSource)
class PostRemoteDataSourceImpl extends PostRemoteDataSource {
  final DioClient _dioClient;
  PostRemoteDataSourceImpl(this._dioClient);

  @override
  Future<String> subscribe() async {
    try {
      final response = await _dioClient.dio.post(ApiEndpoint.subscription);

      if (response.statusCode == 200) {
        final data = response.data;
        if (data != null && data['url'] != null) {
          return data['url'] as String;
        } else {
          throw DioAppException.fromDioError(
            DioException(
              requestOptions: response.requestOptions,
              response: response,
              message: "URL not found in response",
            ),
          );
        }
      } else {
        throw DioAppException.fromDioError(
          DioException(
            requestOptions: response.requestOptions,
            response: response,
            message: "Unexpected server response",
          ),
        );
      }
    } on DioException catch (e) {
      throw DioAppException.fromDioError(e);
    } catch (e) {
      throw UnknownException("$e");
    }
  }

  @override
  Future<bool> isSubscribe() async {
    try {
      final response = await _dioClient.dio.get(ApiEndpoint.subscriptionStatus);
      if (response.statusCode == 200) {
        final subscription = SubscriptionStatusModel.fromJson(response.data);
        return subscription.isActive;
      } else {
        throw DioAppException.fromDioError(
          DioException(
            requestOptions: response.requestOptions,
            response: response,
            message: "Unexpected server response",
          ),
        );
      }
    } on DioException catch (e) {
      throw DioAppException.fromDioError(e);
    } catch (e) {
      throw UnknownException("$e");
    }
  }

  @override
  Future<CreatePostResponseModel> createNewPost(
    CreatePostRequestModel request,
  ) async {
    final formData = await request.toFormData();
    try {
      final subscribed = await isSubscribe();

      if (!subscribed) {
        throw DioException(
          message: "You must subscribe to create a post",
          requestOptions: RequestOptions(path: ApiEndpoint.createPost),
        );
      }

      final response = await _dioClient.dio.post(
        ApiEndpoint.createPost,
        data: formData,
      );

      if (response.statusCode == 200) {
        return CreatePostResponseModel.fromJson(response.data);
      }

      throw DioAppException.fromDioError(
        DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: "Unexpected server response",
        ),
      );
    } on DioException catch (e) {
      throw DioAppException.fromDioError(e);
    } catch (e) {
      throw UnknownException("$e");
    }
  }

  @override
  Future<GetPostResponseModel> getPosts({int page = 1, int limit = 10}) async {
    try {
      final response = await _dioClient.dio.get(
        ApiEndpoint.getPost,
        queryParameters: {'page': page, 'limit': limit},
      );

      if (response.statusCode == 200) {
        return GetPostResponseModel.fromJson(response.data);
      }
      throw DioAppException.fromDioError(
        DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: "Unexpected server response",
        ),
      );
    } on DioException catch (e) {
      throw DioAppException.fromDioError(e);
    } catch (e) {
      throw UnknownException("$e");
    }
  }

  @override
  Future<GetUserFeedResponseModel> getFeed({int page = 1, int limit = 10}) {
    // TODO: implement getFeed
    throw UnimplementedError();
  }

  @override
  Future<String> deletePost(String id) {
    // TODO: implement deletePost
    throw UnimplementedError();
  }

  @override
  Future<CreatePostResponseModel> getPostById(String id) async {
    // String endpoint = "${ApiEndpoint.getPostById}/$id";
    // try {
    //   final response = await _dioClient.dio.get(endpoint);
    //   if(response.statusCode == 200){

    //   }
    // } on DioException catch (e) {
    //   throw DioAppException.fromDioError(e);
    // } catch (e) {
    //   throw UnknownException("$e");
    // }
    // TODO: implement togglePost
    throw UnimplementedError();
  }

  @override
  Future<String> togglePost() {
    // TODO: implement togglePost
    throw UnimplementedError();
  }

  @override
  Future<CreatePostResponseModel> updatePost(String id) {
    // TODO: implement updatePost
    throw UnimplementedError();
  }
}
