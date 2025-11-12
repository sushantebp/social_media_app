import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/constants/app_size.dart';
import 'package:social_media_app/core/core.dart';
import 'package:social_media_app/features/dashboard/dashboard.dart';

@RoutePage()
class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSize.paddingMedium,
          ),
          child: ListView.builder(
            itemCount: 20,
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  title: Text('Post $index'),
                  subtitle: Text('This is a sample post description.'),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
