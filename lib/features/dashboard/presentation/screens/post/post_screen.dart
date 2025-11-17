import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_media_app/core/core.dart';
import 'package:social_media_app/features/dashboard/dashboard.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final cubit = context.read<PostCubit>();
    cubit.fetchPosts(refresh: true);

    // Infinite scrolling
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 100) {
        cubit.fetchPosts();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _showSubscribeDialog(BuildContext context, String url) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.lock_outline,
                size: 60,
                color: context.colorScheme.primary,
              ),
              const SizedBox(height: 16),
              const Text(
                "Premium Required",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                "You need to subscribe to create a new post. Unlock premium features and start posting!",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AppButton(
                    type: AppButtonType.text,
                    onPressed: () => Navigator.of(ctx).pop(),
                    title: "Cancel",
                  ),
                  AppButton(
                    onPressed: () async {
                      Navigator.of(ctx).pop();
                      if (await canLaunchUrl(Uri.parse(url))) {
                        await launchUrl(
                          Uri.parse(url),
                          mode: LaunchMode.externalApplication,
                        );
                      } else {
                        if (!context.mounted) return;
                        ToastHelper.error(
                          context,
                          "Could not open subscription page",
                        );
                      }
                    },
                    title: "Subscribe Now",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PostCubit>();

    return BlocListener<PostCubit, PostState>(
      listener: (context, state) {
        state.whenOrNull(
          error: (msg) =>
              ToastHelper.error(context, msg ?? "Something went wrong"),
          loaded: (postResponse, message, url) {
            if (message != null && url == null) {
              ToastHelper.success(context, message);
            }
          },
        );
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const FaIcon(FontAwesomeIcons.feather),
          onPressed: () async {
            final isSubscribed = await cubit.isSubscribe();
            if (!context.mounted) return;

            if (isSubscribed) {
              context.pushRoute(const CreateNewPostRoute());
            } else {
              await cubit.subscribe();
              final state = cubit.state;
              state.maybeWhen(
                loaded: (postResponse, message, url) {
                  if (url != null) {
                    _showSubscribeDialog(context, url);
                  } else {
                    ToastHelper.error(
                      context,
                      "Failed to get subscription URL",
                    );
                  }
                },
                orElse: () => null,
              );
            }
          },
        ),
        body: BlocBuilder<PostCubit, PostState>(
          builder: (context, state) {
            final posts = cubit.posts;

            return state.maybeWhen(
              loading: () => posts.isEmpty
                  ? const Center(child: CircularProgressIndicator.adaptive())
                  : _buildPostList(posts, cubit),
              loadingMore: (_) =>
                  _buildPostList(posts, cubit, isLoadingMore: true),
              postsLoaded: (_, __) => _buildPostList(posts, cubit),
              orElse: () => posts.isEmpty
                  ? const Center(child: Text("No posts found"))
                  : _buildPostList(posts, cubit),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPostList(
    List<GetPostItem> posts,
    PostCubit cubit, {
    bool isLoadingMore = false,
  }) {
    return RefreshIndicator(
      onRefresh: () async => cubit.fetchPosts(refresh: true),
      child: ListView.separated(
        controller: _scrollController,
        itemCount: posts.length + (isLoadingMore ? 1 : 0),
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          if (index < posts.length) {
            final post = posts[index].post;
            return ListTile(
              title: Text(post.title),
              subtitle: Text(post.content),
              leading: post.image.isNotEmpty
                  ? Image.network(
                      post.image,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    )
                  : null,
            );
          } else {
            return const Padding(
              padding: EdgeInsets.all(16),
              child: Center(child: CircularProgressIndicator()),
            );
          }
        },
      ),
    );
  }
}

/// when post is empty ---> no post
/// 
