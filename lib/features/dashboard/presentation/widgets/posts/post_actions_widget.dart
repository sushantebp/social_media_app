import 'package:flutter/material.dart';

class PostActionsWidget extends StatelessWidget {
  final int likes;

  const PostActionsWidget({super.key, required this.likes});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          const Icon(Icons.favorite_border),
          const SizedBox(width: 8),
          Text("$likes likes"),
          const Spacer(),
          const Icon(Icons.chat_bubble_outline),
        ],
      ),
    );
  }
}
