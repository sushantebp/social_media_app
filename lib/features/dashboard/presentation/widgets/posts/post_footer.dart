import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:social_media_app/core/core.dart';

/// Widget for displaying post footer information (timestamp)
class PostFooter extends StatelessWidget {
  final String createdAt;
  final String? updatedAt;

  const PostFooter({super.key, required this.createdAt, this.updatedAt});

  /// Formats the timestamp as relative
  String _formatDateTime(String dateTimeStr) {
    try {
      final dateTime = DateTime.parse(dateTimeStr);
      final now = DateTime.now();
      final difference = now.difference(dateTime);

      if (difference.inDays > 7) {
        // Older than 1 week → show full date
        return DateFormat('MMM d, yyyy').format(dateTime);
      } else if (difference.inDays > 0) {
        return '${difference.inDays}d ago';
      } else if (difference.inHours > 0) {
        return '${difference.inHours}h ago';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes}m ago';
      } else {
        return 'Just now';
      }
    } catch (e) {
      return dateTimeStr;
    }
  }

  @override
  Widget build(BuildContext context) {
    final timeText = _formatDateTime(createdAt);
    final edited = updatedAt != null && updatedAt != createdAt;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSize.paddingMedium,
        vertical: AppSize.paddingSmall,
      ),
      child: Row(
        children: [
          Icon(
            Icons.access_time,
            size: 14,
            color: context.colorScheme.onSurface.withValues(alpha: 0.5),
          ),
          const SizedBox(width: AppSize.marginSmall / 2),

          Text(
            timeText,
            style: TextStyle(
              fontSize: 12,
              color: context.colorScheme.onSurface.withValues(alpha: 0.22),
            ),
          ),
          if (edited) ...[
            const SizedBox(width: AppSize.marginSmall),
            Text(
              '• Edited',
              style: TextStyle(
                fontSize: 12,
                color: context.colorScheme.onSurface.withValues(alpha: 0.22),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
