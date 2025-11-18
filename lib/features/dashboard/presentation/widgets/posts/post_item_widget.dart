import 'package:flutter/material.dart';
import 'package:social_media_app/features/dashboard/dashboard.dart';
import 'post_header_widget.dart';
import 'post_image_widget.dart';
import 'post_actions_widget.dart';
import 'post_comments_widget.dart';

class PostItemWidget extends StatelessWidget {
  final GetPostItem postItem;

  const PostItemWidget({super.key, required this.postItem});

  @override
  Widget build(BuildContext context) {
    final post = postItem.post;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PostHeaderWidget(author: post.author, createdAt: post.createdAt),
        PostImageWidget(imageUrl: post.image),
        PostActionsWidget(likes: post.likesCounter),
        PostCommentsWidget(comments: postItem.latestComment),
        const Divider(),
      ],
    );
  }
}
