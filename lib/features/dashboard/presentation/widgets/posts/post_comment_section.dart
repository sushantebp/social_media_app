import 'package:flutter/material.dart';
import 'package:social_media_app/features/dashboard/dashboard.dart';
import 'package:intl/intl.dart';
import 'package:social_media_app/core/core.dart';

/// Widget for displaying latest comments
class PostCommentSection extends StatelessWidget {
  final List<GetPostComment> comments;
  final int maxCommentsToShow;

  const PostCommentSection({
    super.key,
    required this.comments,
    this.maxCommentsToShow = 3,
  });

  @override
  Widget build(BuildContext context) {
    final displayComments = comments.take(maxCommentsToShow).toList();

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSize.paddingMedium,
        vertical: AppSize.paddingSmall,
      ),
      decoration: BoxDecoration(
        color: context.colorScheme.onSurface.withValues(alpha: 0.05),
        border: Border(
          top: BorderSide(
            color: context.colorScheme.onSurface.withValues(alpha: 0.1),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.comment,
                size: 16,
                color: context.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
              const SizedBox(width: AppSize.spaceSmall),
              Text(
                'Recent Comments (${comments.length})',
                style: context.textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: context.colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSize.spaceSmall),
          ...displayComments.map((comment) => _CommentItem(comment: comment)),
          if (comments.length > maxCommentsToShow)
            TextButton(
              onPressed: () {
                // View all comments
              },
              child: Text(
                'View all ${comments.length} comments',
                style: context.textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: context.colorScheme.primary,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Individual comment item widget
class _CommentItem extends StatelessWidget {
  final GetPostComment comment;

  const _CommentItem({required this.comment});

  String _formatTimeAgo(String? createdAt) {
    if (createdAt == null) return '';
    try {
      final dateTime = DateTime.parse(createdAt);
      final now = DateTime.now();
      final difference = now.difference(dateTime);

      if (difference.inDays >= 7) {
        return DateFormat('MMM d, yyyy').format(dateTime);
      } else if (difference.inDays >= 1) {
        return '${difference.inDays}d ago';
      } else if (difference.inHours >= 1) {
        return '${difference.inHours}h ago';
      } else if (difference.inMinutes >= 1) {
        return '${difference.inMinutes}m ago';
      } else {
        return 'Just now';
      }
    } catch (e) {
      return createdAt;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSize.spaceSmall),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 12,
            backgroundColor: context.colorScheme.onSurface.withValues(
              alpha: 0.3,
            ),
            child: Text(
              comment.authorName?.isNotEmpty == true
                  ? comment.authorName![0].toUpperCase()
                  : '?',
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.onPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: AppSize.spaceSmall),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colorScheme.onSurface,
                    ),
                    children: [
                      TextSpan(
                        text: comment.authorName ?? 'Unknown',
                        style: context.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const TextSpan(text: ' '),
                      TextSpan(
                        text: comment.content ?? '',
                        style: context.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                if (comment.createdAt != null)
                  Text(
                    _formatTimeAgo(comment.createdAt),
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colorScheme.onSurface.withValues(
                        alpha: 0.6,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
