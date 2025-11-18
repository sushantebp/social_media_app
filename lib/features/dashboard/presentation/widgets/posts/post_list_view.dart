import 'package:flutter/material.dart';
import 'package:social_media_app/core/core.dart';
import 'package:social_media_app/features/dashboard/dashboard.dart';

/// Main widget to display paginated list of posts
class PostListView extends StatelessWidget {
  final GetPostResponseModel responseModel;

  const PostListView({super.key, required this.responseModel});

  @override
  Widget build(BuildContext context) {
    final posts = responseModel.postList;

    return Column(
      children: [
        // ---------------- POSTS LIST ----------------
        Expanded(
          child: posts.isEmpty
              ? const Center(
                  child: Text(
                    "No posts available",
                    style: TextStyle(fontSize: 16),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.only(bottom: AppSize.paddingLarge),
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    final item = posts[index];

                    return PostCard(postItem: item);
                  },
                ),
        ),

        // ---------------- PAGINATION ----------------
        // PaginationInfo(
        //   currentPage: responseModel.currentPage,
        //   totalPages: responseModel.totalPages,
        //   totalPosts: responseModel.totalPosts,
        //   hasNextPage: responseModel.hasNextPage,
        //   hasPrevPage: responseModel.hasPrevPage,
        // ),
      ],
    );
  }
}
