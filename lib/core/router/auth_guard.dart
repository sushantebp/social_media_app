import 'package:auto_route/auto_route.dart';
import 'package:social_media_app/core/core.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    final token = await SecureStorageService().read(AppConstant.tokenKey);

    if (token != null && token.isNotEmpty) {
      resolver.next(true);
    } else {
      router.replace(const UserLoginRoute());
    }
  }
}
