import 'package:flutter/material.dart';
import 'package:social_media_app/core/core.dart';

class CustomProfileTile extends StatelessWidget {
  final String label;
  final String value;
  final IconData? icon;

  const CustomProfileTile({
    super.key,
    required this.label,
    required this.value,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(AppSize.paddingMedium),
      margin: const EdgeInsets.symmetric(vertical: AppSize.marginSmall),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.radiusLarge),
        color: theme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          if (icon != null)
            Icon(icon, size: 26, color: theme.colorScheme.primary),
          if (icon != null) const SizedBox(width: AppSize.spaceMedium),

          // TEXT BLOCK
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: theme.textTheme.bodySmall!.copyWith(
                    fontSize: AppSize.fontSmall,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
                const SizedBox(height: AppSize.spaceSmall / 2),
                Text(
                  value.isEmpty ? "Not provided" : value,
                  style: theme.textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
