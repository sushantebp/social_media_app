import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/features/auth/auth.dart';

import 'package:social_media_app/features/dashboard/dashboard.dart';

@RoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AuthBloc>();

    return NotificationListener<UserScrollNotification>(
      onNotification: (notification) {
        final cubit = context.read<BottomBarCubit>();
        if (notification.direction == ScrollDirection.reverse) {
          cubit.hide();
        } else if (notification.direction == ScrollDirection.forward) {
          cubit.show();
        }
        return false;
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [],
          ),
        ),
      ),
    );
  }
}
