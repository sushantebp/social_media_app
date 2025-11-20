import 'package:flutter/material.dart';
import 'package:social_media_app/core/core.dart';

class StatColumn extends StatelessWidget {
  final String count;
  final String label;
  const StatColumn({super.key, required this.count, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          count,
          style: context.textTheme.labelLarge?.copyWith(fontSize: 17),
        ),
        const SizedBox(height: AppSize.marginSmall / 2),
        Text(label, style: context.textTheme.labelLarge),
      ],
    );
  }
}
