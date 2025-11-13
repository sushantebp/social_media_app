import 'package:social_media_app/core/core.dart';

class SplashCubit extends BaseCubit<bool> {
  SplashCubit() : super(false);

  Future<bool> isAuthenticated() async {
    final token = await SecureStorageService().read(AppConstant.tokenKey);
    return token != null && token.isNotEmpty;
  }
}
