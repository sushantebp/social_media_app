import 'package:flutter/material.dart';

class PostImageWidget extends StatelessWidget {
  final String imageUrl;

  const PostImageWidget({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      width: double.infinity,
      height: 300,
      fit: BoxFit.cover,
    );
  }
}
