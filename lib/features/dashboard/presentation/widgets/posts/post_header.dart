import 'package:flutter/material.dart';

import 'package:social_media_app/core/core.dart';
import 'package:social_media_app/features/dashboard/data/data.dart';

/// Widget for displaying post author information
class PostHeader extends StatelessWidget {
  final GetPostAuthor author;

  const PostHeader({super.key, required this.author});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: context.colorScheme.primary,
            child: Center(
              child: Text(
                author.name.isNotEmpty ? author.name[0].toUpperCase() : '?',
                style: context.textTheme.titleLarge,
              ),
            ),
          ),
          const SizedBox(width: AppSize.marginMedium),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(author.name, style: context.textTheme.titleMedium),
              ],
            ),
          ),
          AppButton(
            type: AppButtonType.text,
            title: '',
            icon: Icons.more_vert,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
