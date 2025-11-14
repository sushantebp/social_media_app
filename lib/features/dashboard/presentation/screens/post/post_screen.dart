import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_media_app/core/core.dart';

@RoutePage()
class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      floatingActionButton: FloatingActionButton(
        child: const FaIcon(FontAwesomeIcons.feather),
        onPressed: () => context.router.push(const CreateNewPostRoute()),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSize.paddingMedium),
        child: Column(children: []),
      ),
    );
  }
}
