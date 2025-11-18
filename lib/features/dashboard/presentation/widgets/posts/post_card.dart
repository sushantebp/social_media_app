import 'package:flutter/material.dart';
import 'package:social_media_app/features/dashboard/dashboard.dart';
import 'package:social_media_app/core/core.dart';

/// Individual post card widget
class PostCard extends StatelessWidget {
  final GetPostItem postItem;

  const PostCard({super.key, required this.postItem});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        vertical: AppSize.marginSmall,
        horizontal: AppSize.marginSmall,
      ),
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: context.colorScheme.onSurface.withValues(alpha: 0.5),
        ),
        borderRadius: BorderRadius.circular(AppSize.radiusLarge),
      ),
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppSize.radiusLarge),
        onTap: () {},
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---------------- POST HEADER ----------------
            PostHeader(author: postItem.post.author),

            // ---------------- POST IMAGE ----------------
            if (postItem.post.image.isNotEmpty)
              PostImage(imageUrl: postItem.post.image, height: 300),

            // ---------------- POST CONTENT ----------------
            PostContent(
              title: postItem.post.title,
              content: postItem.post.content,
              maxLines: 5,
            ),

            // ---------------- POST ACTIONS ----------------
            PostActions(
              likesCount: postItem.post.likesCounter,
              // need to pass here bool is liked or not
              // for now false
              isLiked: false,
            ),

            // ---------------- COMMENTS ----------------
            if (postItem.latestComment.isNotEmpty)
              PostCommentSection(comments: postItem.latestComment),

            // ---------------- POST FOOTER ----------------
            PostFooter(
              createdAt: postItem.post.createdAt,
              updatedAt: postItem.post.updatedAt,
            ),
          ],
        ),
      ),
    );
  }
}
