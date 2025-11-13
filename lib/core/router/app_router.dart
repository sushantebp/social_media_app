import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';

import 'package:social_media_app/features/auth/auth.dart';
import 'package:social_media_app/features/dashboard/dashboard.dart';
import 'package:social_media_app/features/splash/splash.dart';
import 'package:social_media_app/features/onboarding/onboarding.dart';

import 'package:social_media_app/core/core.dart';

part 'app_router.gr.dart';
part 'auth_guard.dart';

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
    // showoff,inital screen
    AutoRoute(initial: true, page: SplashRoute.page),
    AutoRoute(page: OnboardingRoute.page),
    // auth-related
    AutoRoute(page: UserRegisterRoute.page),
    AutoRoute(page: UserLoginRoute.page),
    AutoRoute(page: UserEmailVerifyRoute.page),
    AutoRoute(page: UserPasswordChangeRoute.page),
    // screen related to bottom-nav-bar (dashboard)
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
          children: [AutoRoute(page: ProfileRoute.page)],
        ),
      ],
    ),

    // screen assopciatge with post(dashboard)
    AutoRoute(page: CreateNewPostRoute.page, guards: [_authGuard]),
  ];
}
