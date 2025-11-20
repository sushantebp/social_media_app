import 'package:social_media_app/core/core.dart';
import 'package:social_media_app/features/auth/auth.dart';

abstract class AuthRepository {
  Future<Result<UserAuthResponseModel>> registerUser(
    UserAuthRequestModel request,
  );

  Future<Result<String>> verifyEmail(VerifyEmailRequestModel request);

  Future<Result<UserAuthResponseModel>> loginUser(UserAuthRequestModel request);

  Future<void> logoutUser();
}
