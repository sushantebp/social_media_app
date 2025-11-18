import 'package:flutter/material.dart';
import 'package:social_media_app/core/core.dart';

/// Widget for displaying post title and content
class PostContent extends StatelessWidget {
  final String title;
  final String content;
  final int? maxLines;

  const PostContent({
    super.key,
    required this.title,
    required this.content,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSize.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: context.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSize.spaceSmall),
          Text(
            content,
            style: context.textTheme.bodyMedium?.copyWith(height: 1.4),
            maxLines: maxLines,
            overflow: maxLines != null ? TextOverflow.ellipsis : null,
          ),
        ],
      ),
    );
  }
}
