import 'package:flutter/material.dart';
import 'package:social_media_app/features/dashboard/dashboard.dart';

class PostCommentsWidget extends StatelessWidget {
  final List<GetPostComment> comments;

  const PostCommentsWidget({super.key, required this.comments});

  @override
  Widget build(BuildContext context) {
    if (comments.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...comments.map((c) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                      text: "${c.authorName ?? 'User'}: ",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: c.content ?? ""),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
