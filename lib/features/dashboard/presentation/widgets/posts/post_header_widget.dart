import 'package:flutter/material.dart';
import 'package:social_media_app/features/dashboard/dashboard.dart';

class PostHeaderWidget extends StatelessWidget {
  final GetPostAuthor author;
  final String createdAt;

  const PostHeaderWidget({
    super.key,
    required this.author,
    required this.createdAt,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(child: Icon(Icons.person)),
      title: Text(
        author.name,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(createdAt),
      trailing: const Icon(Icons.more_vert),
    );
  }
}
