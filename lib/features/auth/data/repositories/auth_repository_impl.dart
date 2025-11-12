import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/core.dart';
import 'package:social_media_app/features/auth/auth.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;
  final AuthLocalDataSource _authLocalDataSource;
  AuthRepositoryImpl(this._authRemoteDataSource, this._authLocalDataSource);
  @override
  Future<Result<UserRegisterResponseModel>> registerUser(
    UserRegisterRequestModel request,
  ) async {
    try {
      final response = await _authRemoteDataSource.registerUser(request);

      await _authLocalDataSource.saveToken(response.data.token);

      await _authLocalDataSource.saveUserInfo(response.data.user);

      return Right(response);
    } catch (e) {
      return Left(UnknownException("Something bad happens : $e"));
    }
  }

  @override
  Future<Result<CommonResponseModel>> verifyEmail(
    VerifyEmailRequestModel request,
  ) async {
    try {
      final response = await _authRemoteDataSource.verifyEmail(request);
      return Right(response);
    } catch (e) {
      return Left(UnknownException("Something bad happened: $e"));
    }
  }

  @override
  Future<Result<UserRegisterResponseModel>> loginUser(
    UserLoginRequestModel request,
  ) async {
    try {
      final response = await _authRemoteDataSource.loginUser(request);

      await _authLocalDataSource.saveToken(response.data.token);

      await _authLocalDataSource.saveUserInfo(response.data.user);

      return Right(response);
    } catch (e) {
      return Left(UnknownException("Something bad happens : $e"));
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
