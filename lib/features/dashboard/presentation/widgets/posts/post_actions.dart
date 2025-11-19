import 'package:flutter/material.dart';
import 'package:social_media_app/core/core.dart';

/// Widget for post actions (like, comment, share)
class PostActions extends StatelessWidget {
  final int likesCount;
  final bool isLiked;

  const PostActions({
    super.key,
    required this.likesCount,
    this.isLiked = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSize.paddingMedium,
        vertical: AppSize.paddingSmall,
      ),
      child: Row(
        children: [
          // Like Button
          AppButton(
            icon: isLiked ? Icons.favorite : Icons.favorite_border,
            title: likesCount.toString(),
            type: AppButtonType.text,
            fgColor: isLiked
                ? Colors.red
                : theme.onSurface.withValues(alpha: 0.7),
            onPressed: () {},
            padding: const EdgeInsets.symmetric(
              horizontal: AppSize.paddingSmall,
              vertical: AppSize.paddingExtraSmall,
            ),
          ),

          const SizedBox(width: AppSize.spaceMedium),

          // Comment Button
          AppButton(
            icon: Icons.comment_outlined,
            type: AppButtonType.text,
            fgColor: theme.onSurface.withValues(alpha: 0.7),
            onPressed: () {},
            padding: const EdgeInsets.symmetric(
              horizontal: AppSize.paddingSmall,
              vertical: AppSize.paddingExtraSmall,
            ),
          ),
        ],
      ),
    );
  }
}
