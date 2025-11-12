import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/core/core.dart';

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
      label: 'Posts',
    ),
    NavigationDestination(
      selectedIcon: Icon(Icons.chat),
      icon: Icon(Icons.chat_outlined),
      label: 'Chat',
    ),
    NavigationDestination(
      selectedIcon: Icon(Icons.notifications),
      icon: Icon(Icons.notifications_outlined),
      label: 'Notifications',
    ),
    NavigationDestination(
      selectedIcon: Icon(Icons.person),
      icon: Icon(Icons.person_outline),
      label: 'Profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: _routes,
      bottomNavigationBuilder: (context, tabsRouter) => NavigationBar(
        destinations: _destinations,
        selectedIndex: tabsRouter.activeIndex,
        onDestinationSelected: (index) => tabsRouter.setActiveIndex(index),
      ),
    );
  }
}
