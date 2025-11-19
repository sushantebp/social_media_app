import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_media_app/core/core.dart';
import 'package:social_media_app/features/dashboard/dashboard.dart';

@RoutePage()
class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PostCubit>().getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostCubit, PostState>(
      builder: (context, state) {
        return SafeArea(
          top: true,
          child: Scaffold(
            floatingActionButton: const FAB(),
            body: state.when(
              initial: () => const _PostInitial(),
              loading: () => const _PostLoading(),
              loaded: (_, postResponse, _, _) =>
                  _PostLoaded(responseModel: postResponse!),
              error: (errorMessage) =>
                  _PostError(message: errorMessage ?? "Failed to fetch posts"),
            ),
          ),
        );
      },
    );
  }
}

class FAB extends StatelessWidget {
  const FAB({super.key});

  @override
  Widget build(BuildContext context) {
    final router = context.router;
    final cubit = context.read<PostCubit>();

    return FloatingActionButton(
      heroTag: "Add Post",
      shape: const CircleBorder(),
      backgroundColor: context.colorScheme.onSurface,
      onPressed: () async {
        final isSub = await cubit.isSubscribe();
        if (!isSub) {
          router.push(const SubscribeRoute());
        } else {
          router.push(const CreateNewPostRoute());
        }
      },
      child: FaIcon(
        FontAwesomeIcons.fileCirclePlus,
        color: context.colorScheme.surface,
      ),
    );
  }
}

class _PostLoaded extends StatelessWidget {
  final GetPostResponseModel responseModel;
  const _PostLoaded({required this.responseModel});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => context.read<PostCubit>().getPosts(),
      child: PostListView(responseModel: responseModel),
    );
  }
}

class _PostError extends StatelessWidget {
  final String message;

  const _PostError({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, color: context.colorScheme.error, size: 60),
          const SizedBox(height: AppSize.spaceMedium),
          Text(
            message,
            textAlign: TextAlign.center,
            style: context.textTheme.bodyMedium,
          ),
          const SizedBox(height: AppSize.spaceLarge),
          AppButton(
            title: "Retry",
            onPressed: () => context.read<PostCubit>().getPosts(),
            type: AppButtonType.outlined,
          ),
        ],
      ),
    );
  }
}

class _PostLoading extends StatelessWidget {
  const _PostLoading();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: 4,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ==== HEADER ====
                  Row(
                    children: [
                      const ShimmerBox(width: 40, height: 40, radius: 50),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          ShimmerBox(width: 120, height: 12),
                          SizedBox(height: 6),
                          ShimmerBox(width: 80, height: 10),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // ==== IMAGE ====
                  const ShimmerBox(
                    width: double.infinity,
                    height: 200,
                    radius: 12,
                  ),

                  const SizedBox(height: 12),

                  // ==== TITLE + CONTENT ====
                  const ShimmerBox(width: 150, height: 14),
                  const SizedBox(height: 8),
                  const ShimmerBox(width: double.infinity, height: 12),
                  const SizedBox(height: 6),
                  const ShimmerBox(width: double.infinity, height: 12),
                  const SizedBox(height: 6),
                  const ShimmerBox(width: 180, height: 12),

                  const SizedBox(height: 12),

                  // ==== ACTIONS (like row) ====
                  Row(
                    children: const [
                      ShimmerBox(width: 24, height: 24, radius: 50),
                      SizedBox(width: 8),
                      ShimmerBox(width: 40, height: 12),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // ==== COMMENTS SECTION ====
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      ShimmerBox(width: double.infinity, height: 10),
                      SizedBox(height: 6),
                      ShimmerBox(width: 200, height: 10),
                    ],
                  ),

                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _PostInitial extends StatelessWidget {
  const _PostInitial();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Fetching Post...", style: context.textTheme.bodyMedium),
    );
  }
}
