import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/core.dart';
import 'package:social_media_app/features/dashboard/dashboard.dart';

class PostRepositoryImpl extends PostRepository {
  final PostRemoteDataSource _remoteDataSource;
  PostRepositoryImpl(this._remoteDataSource);
  @override
  Future<Result<String>> subscribe() async {
    try {
      final url = await _remoteDataSource.subscribe();
      return Right(url);
    } on DioException catch (e) {
      return Left(DioAppException.fromDioError(e));
    } catch (e) {
      return Left(UnknownException("$e"));
    }
  }

  @override
  Future<Result<bool>> isSubscribe() async {
    try {
      final isSub = await _remoteDataSource.isSubscribe();
      return Right(isSub);
    } on DioException catch (e) {
      return Left(DioAppException.fromDioError(e));
    } catch (e) {
      return Left(UnknownException("$e"));
    }
  }

  @override
  Future<Result<CreatePostResponseModel>> createNewPost(
    CreatePostRequestModel request,
  ) async {
    try {
      final response = await _remoteDataSource.createNewPost(request);
      return Right(response);
    } on DioException catch (e) {
      return Left(DioAppException.fromDioError(e));
    } catch (e) {
      return Left(UnknownException("$e"));
    }
  }

  @override
  Future<Result<GetPostResponseModel>> getPosts({
    int page = 1,
    int limit = 10,
  }) {
    // TODO: implement getPosts
    throw UnimplementedError();
  }

  @override
  Future<Result> deletePost(String id) {
    // TODO: implement deletePost
    throw UnimplementedError();
  }

  @override
  Future<Result<GetUserFeedResponseModel>> getFeed({
    int page = 1,
    int limit = 10,
  }) {
    // TODO: implement getFeed
    throw UnimplementedError();
  }

  @override
  Future<Result<CreatePostResponseModel>> getPostById(String id) {
    // TODO: implement getPostById
    throw UnimplementedError();
  }

  @override
  Future<Result<CreatePostResponseModel>> updatePost(String id) {
    // TODO: implement updatePost
    throw UnimplementedError();
  }

  @override
  Future<Result> togglePost() {
    // TODO: implement togglePost
    throw UnimplementedError();
  }
}
