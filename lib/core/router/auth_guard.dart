part of 'app_router.dart';

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
