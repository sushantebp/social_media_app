import 'package:flutter/material.dart';
import 'package:social_media_app/core/core.dart';

/// Widget for displaying post image
class PostImage extends StatelessWidget {
  final String imageUrl;
  final double? height;

  const PostImage({super.key, required this.imageUrl, this.height});

  @override
  Widget build(BuildContext context) {
    final displayHeight = height ?? 300;

    return Image.network(
      imageUrl,
      width: double.infinity,
      height: displayHeight,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return SizedBox(
          height: displayHeight,
          child: Center(
            child: CircularProgressIndicator.adaptive(
              valueColor: AlwaysStoppedAnimation(context.colorScheme.primary),
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                  : null,
              strokeWidth: AppSize.radiusSmall,
            ),
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return Container(
          height: displayHeight,
          color: context.colorScheme.onSurface.withValues(alpha: 0.1),
          child: Center(
            child: Icon(
              Icons.broken_image,
              size: 50,
              color: context.colorScheme.onSurface.withValues(alpha: 0.4),
            ),
          ),
        );
      },
    );
  }
}
