import 'package:flutter/material.dart';
import 'package:social_media_app/core/core.dart';

/// Widget for displaying pagination information and controls
class PaginationInfo extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final int totalPosts;
  final bool hasNextPage;
  final bool hasPrevPage;

  const PaginationInfo({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.totalPosts,
    required this.hasNextPage,
    required this.hasPrevPage,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final textTheme = context.textTheme;

    return Container(
      padding: const EdgeInsets.all(AppSize.paddingLarge),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        children: [
          // ---------------- PAGE INFO ----------------
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Page $currentPage of $totalPages',
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(width: AppSize.marginSmall),
              Text('•', style: TextStyle(color: colorScheme.outline)),
              const SizedBox(width: AppSize.marginSmall),
              Text(
                '$totalPosts total posts',
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),

          const SizedBox(height: AppSize.marginLarge),

          // ---------------- PAGE CONTROLS ----------------
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppButton(
                title: "Previous",
                icon: Icons.chevron_left,
                type: AppButtonType.outlined,
                onPressed: hasPrevPage ? () {} : null,
                height: 40,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSize.paddingMedium,
                ),
              ),

              const SizedBox(width: AppSize.marginMedium),

              AppButton(
                title: "Next",
                icon: Icons.chevron_right,
                type: AppButtonType.outlined,
                onPressed: hasNextPage ? () {} : null,
                height: 40,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSize.paddingMedium,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
