import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_media_app/core/core.dart';
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
            children: [
              AppButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(
                        "Logout",
                        style: context.textTheme.displaySmall,
                      ),
                      content: Text('Are you sure you want to logout?'),
                      actions: [
                        AppButton(
                          onPressed: () => Navigator.of(context).pop(),
                          title: "Cancel",
                        ),
                        const SizedBox(width: 12),
                        AppButton(
                          onPressed: () {
                            bloc.add(const LogoutSubmitted());
                            ToastHelper.info(context, "Logout successful");
                            context.router.replace(const UserLoginRoute());
                          },
                          title: "Sure",
                        ),
                      ],
                    ),
                  );
                },
                title: 'Logout',
                icon: FontAwesomeIcons.rightFromBracket,
                bgColor: Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
