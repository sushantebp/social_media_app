import 'package:dio/dio.dart';

import 'package:social_media_app/core/core.dart';
import 'package:social_media_app/features/auth/auth.dart';

abstract class AuthRemoteDataSource {
  Future<UserRegisterResponseModel> registerUser(
    UserRegisterRequestModel request,
  );
  Future<CommonResponseModel> verifyEmail(VerifyEmailRequestModel request);
  Future<UserRegisterResponseModel> loginUser(UserLoginRequestModel request);

  Future<void> logoutUser();
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final DioClient _dioClient;
  AuthRemoteDataSourceImpl(this._dioClient);

  @override
  Future<UserRegisterResponseModel> registerUser(
    UserRegisterRequestModel request,
  ) async {
    final postData = request.toJson();
    try {
      final response = await _dioClient.dio.post(
        ApiEndpoint.register,
        data: postData,
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        final responseDataModel = UserRegisterResponseModel.fromJson(
          response.data,
        );
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
      throw UnknownException("Unexpected error: $e");
    }
  }

  @override
  Future<CommonResponseModel> verifyEmail(
    VerifyEmailRequestModel request,
  ) async {
    final postData = request.toJson();
    try {
      final response = await _dioClient.dio.post(
        ApiEndpoint.verifyEmail,
        data: postData,
      );
      if (response.statusCode == 200) {
        return CommonResponseModel.fromJson(response.data);
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
      throw UnknownException("Unexpected error: $e");
    }
  }

  @override
  Future<UserRegisterResponseModel> loginUser(
    UserLoginRequestModel request,
  ) async {
    final postData = request.toJson();

    try {
      final response = await _dioClient.dio.post(
        ApiEndpoint.login,
        data: postData,
      );

      if (response.statusCode == 200) {
        return UserRegisterResponseModel.fromJson(response.data);
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
      throw UnknownException("Unexpected error: $e");
    }
  }

  @override
  Future<void> logoutUser() async {
    try {
      await _dioClient.dio.post(ApiEndpoint.logout);
    } on DioException catch (e) {
      throw DioAppException.fromDioError(e);
    } catch (e) {
      throw UnknownException("Unexpected error: $e");
    }
  }
}
