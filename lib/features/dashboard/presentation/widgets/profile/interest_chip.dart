import 'package:flutter/material.dart';
import 'package:social_media_app/core/core.dart';

class InterestChip extends StatelessWidget {
  final String label;
  const InterestChip({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSize.marginMedium,
        vertical: AppSize.marginMedium / 2,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.marginLarge),
        color: context.colorScheme.onSurface.withValues(alpha: 0.1),
      ),
      child: Text(label, style: context.textTheme.labelMedium),
    );
  }
}
