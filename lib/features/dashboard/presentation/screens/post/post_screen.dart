import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/features/dashboard/dashboard.dart';
import 'package:social_media_app/features/dashboard/presentation/widgets/posts/post_list_widget.dart';

@RoutePage()
class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PostCubit>();
    cubit.getPosts();

    return BlocConsumer<PostCubit, PostState>(
      buildWhen: (previous, current) => previous != current,
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: state.when(
            initial: () {
              return const Center(child: Text("Post will be loaded"));
            },
            loading: () {
              return const Center(
                child: Text("hmmm... should use skeleton here,while loading"),
              );
            },
            loaded: (_, postResponse, _, _) {
              final posts = postResponse?.postList ?? [];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: PostListWidget(posts: posts),
              );
            },
            error: (errorMessage) {
              return Center(
                child: Text(errorMessage ?? "Failed to fetch posts."),
              );
            },
          ),
        );
      },
    );
  }
}
