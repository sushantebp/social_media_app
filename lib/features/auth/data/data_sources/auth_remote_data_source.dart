import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:social_media_app/core/core.dart';
import 'package:social_media_app/features/auth/auth.dart';

abstract class AuthRemoteDataSource {
  Future<UserAuthResponseModel> registerUser(UserAuthRequestModel request);
  Future<String> verifyEmail(VerifyEmailRequestModel request);
  Future<UserAuthResponseModel> loginUser(UserAuthRequestModel request);

  Future<void> logoutUser();
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final DioClient _dioClient;
  AuthRemoteDataSourceImpl(this._dioClient);

  @override
  Future<UserAuthResponseModel> registerUser(
    UserAuthRequestModel request,
  ) async {
    final postData = request.toJson();
    try {
      final response = await _dioClient.dio.post(
        ApiEndpoint.register,
        data: postData,
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        final responseDataModel = UserAuthResponseModel.fromJson(response.data);
        return responseDataModel;
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
  Future<String> verifyEmail(VerifyEmailRequestModel request) async {
    final postData = request.toJson();
    try {
      final response = await _dioClient.dio.post(
        ApiEndpoint.verifyEmail,
        data: postData,
      );
      if (response.statusCode == 200) {
        final String message = response.data['message'] as String;
        return message;
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
  Future<UserAuthResponseModel> loginUser(UserAuthRequestModel request) async {
    final postData = request.toJson();

    try {
      final response = await _dioClient.dio.post(
        ApiEndpoint.login,
        data: postData,
      );

      if (response.statusCode == 200) {
        return UserAuthResponseModel.fromJson(response.data);
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
  Future<void> logoutUser() async {
    try {
      await _dioClient.dio.post(ApiEndpoint.logout);
    } on DioException catch (e) {
      throw DioAppException.fromDioError(e);
    } catch (e) {
      throw UnknownException("$e");
    }
  }
}
