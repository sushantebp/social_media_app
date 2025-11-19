import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/core/core.dart';
import 'package:social_media_app/features/auth/auth.dart';
import 'package:social_media_app/features/dashboard/dashboard.dart';
import 'package:social_media_app/features/onboarding/onboarding.dart';
import 'package:social_media_app/features/splash/splash.dart';

part 'app_router.gr.dart';
part 'auth_guard.dart';

/// Main application router.
/// Has public (auth) routes + protected dashboard routes
/// Uses [AuthGuard] to block unauthenticated access

@AutoRouterConfig(replaceInRouteName: 'Page|Screen,Route')
class AppRouter extends RootStackRouter {
  final _authGuard = AuthGuard();

  AppRouter._internal();
  static final AppRouter _instance = AppRouter._internal();
  factory AppRouter() => _instance;
  static AppRouter get instance => _instance;

  @override
  RouteType get defaultRouteType => RouteType.material();

  @override
  List<AutoRoute> get routes => [
    // showoff page
    AutoRoute(initial: true, page: SplashRoute.page),
    AutoRoute(page: OnboardingRoute.page),
    // Public auth routes
    AutoRoute(page: UserLoginRoute.page),
    AutoRoute(page: UserRegisterRoute.page),
    AutoRoute(page: UserEmailVerifyRoute.page),
    AutoRoute(page: UserRegisterFormRoute.page),
    AutoRoute(page: UserPasswordChangeRoute.page),

    // Dashboard (protected)
    AutoRoute(
      page: DashboardRoute.page,
      guards: [_authGuard],
      children: [
        AutoRoute(
          page: PostShellRoute.page,
          children: [AutoRoute(page: PostRoute.page)],
        ),
        AutoRoute(
          page: ChatShellRoute.page,
          children: [AutoRoute(page: ChatRoute.page)],
        ),
        AutoRoute(
          page: NotificationShellRoute.page,
          children: [AutoRoute(page: NotificationRoute.page)],
        ),
        AutoRoute(
          page: ProfileShellRoute.page,
          children: [
            AutoRoute(page: ProfileRoute.page),
            AutoRoute(page: EditProfileRoute.page),
          ],
        ),
      ],
    ),

    // Post creation (protected)
    AutoRoute(page: CreateNewPostRoute.page, guards: [_authGuard]),
    AutoRoute(page: SubscribeRoute.page, guards: [_authGuard]),
  ];
}
