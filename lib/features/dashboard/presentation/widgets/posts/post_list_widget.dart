import 'package:flutter/material.dart';
import 'package:social_media_app/features/dashboard/dashboard.dart';
import 'post_item_widget.dart';

class PostListWidget extends StatelessWidget {
  final List<GetPostItem> posts;

  const PostListWidget({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (_, index) => PostItemWidget(postItem: posts[index]),
    );
  }
}
