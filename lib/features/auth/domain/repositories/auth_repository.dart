import 'package:social_media_app/core/core.dart';
import 'package:social_media_app/features/auth/auth.dart';

abstract class AuthRepository {
  Future<Result<UserRegisterResponseModel>> registerUser(
    UserRegisterRequestModel request,
  );

  Future<void> logoutUser();
}
