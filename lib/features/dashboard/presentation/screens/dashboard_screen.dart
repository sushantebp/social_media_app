import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
      selectedIcon: FaIcon(FontAwesomeIcons.solidNewspaper),
      icon: FaIcon(FontAwesomeIcons.newspaper),
      label: '',
    ),
    NavigationDestination(
      selectedIcon: FaIcon(FontAwesomeIcons.solidCommentDots),
      icon: FaIcon(FontAwesomeIcons.commentDots),
      label: '',
    ),
    NavigationDestination(
      selectedIcon: FaIcon(FontAwesomeIcons.solidBell),
      icon: FaIcon(FontAwesomeIcons.bell),
      label: '',
    ),
    NavigationDestination(
      selectedIcon: FaIcon(FontAwesomeIcons.solidUser),
      icon: FaIcon(FontAwesomeIcons.user),
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
              height: isVisible ? kBottomNavigationBarHeight * 1.3 : 0,
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
