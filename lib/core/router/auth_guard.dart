part of 'app_router.dart';

/// [AuthGuard] prevents access to protected routes.
/// - If token exists → allow
/// - If token missing → redirect to [UserLoginRoute]
class AuthGuard extends AutoRouteGuard {
  AuthGuard._internal();

  static final AuthGuard _instance = AuthGuard._internal();
  factory AuthGuard() => _instance;

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
