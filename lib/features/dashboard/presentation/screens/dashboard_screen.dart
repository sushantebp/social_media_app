import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/core.dart';
import 'package:social_media_app/features/dashboard/dashboard.dart';

@RoutePage()
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  final List<PageRouteInfo<Object?>> _routes = const [
    PostRoute(),
    ChatRoute(),
    NotificationRoute(),
    ProfileRoute(),
  ];

  final List<NavigationDestination> _destinations = const [
    NavigationDestination(
      selectedIcon: Icon(Icons.article),
      icon: Icon(Icons.article_outlined),
      label: '',
    ),
    NavigationDestination(
      selectedIcon: Icon(Icons.chat),
      icon: Icon(Icons.chat_outlined),
      label: '',
    ),
    NavigationDestination(
      selectedIcon: Icon(Icons.notifications),
      icon: Icon(Icons.notifications_outlined),
      label: '',
    ),
    NavigationDestination(
      selectedIcon: Icon(Icons.person),
      icon: Icon(Icons.person_outline),
      label: '',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomBarCubit, bool>(
      builder: (context, isVisible) {
        return AutoTabsScaffold(
          routes: _routes,
          bottomNavigationBuilder: (context, tabsRouter) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: isVisible ? kBottomNavigationBarHeight * 1.25 : 0,
              child: Wrap(
                children: [
                  NavigationBar(
                    destinations: _destinations,
                    selectedIndex: tabsRouter.activeIndex,
                    onDestinationSelected: (index) =>
                        tabsRouter.setActiveIndex(index),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
