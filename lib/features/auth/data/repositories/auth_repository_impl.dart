import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/core.dart';
import 'package:social_media_app/features/auth/auth.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;
  final AuthLocalDataSource _authLocalDataSource;
  AuthRepositoryImpl(this._authRemoteDataSource, this._authLocalDataSource);
  @override
  Future<Result<UserAuthResponseModel>> registerUser(
    UserAuthRequestModel request,
  ) async {
    try {
      final response = await _authRemoteDataSource.registerUser(request);
      return Right(response);
    } on DioException catch (e) {
      throw DioAppException.fromDioError(e);
    } catch (e) {
      return Left(UnknownException("$e"));
    }
  }

  @override
  Future<Result<String>> verifyEmail(VerifyEmailRequestModel request) async {
    try {
      final response = await _authRemoteDataSource.verifyEmail(request);
      return Right(response);
    } on DioException catch (e) {
      throw DioAppException.fromDioError(e);
    } catch (e) {
      return Left(UnknownException("$e"));
    }
  }

  @override
  Future<Result<UserAuthResponseModel>> loginUser(
    UserAuthRequestModel request,
  ) async {
    try {
      final response = await _authRemoteDataSource.loginUser(request);

      await _authLocalDataSource.saveToken(response.data.token ?? "");

      await _authLocalDataSource.saveUserInfo(response.data);

      return Right(response);
    } on DioException catch (e) {
      throw DioAppException.fromDioError(e);
    } catch (e) {
      return Left(UnknownException("$e"));
    }
  }

  @override
  Future<void> logoutUser() async {
    try {
      await _authRemoteDataSource.logoutUser();
    } catch (_) {}
    await _authLocalDataSource.clearAll();
  }
}
