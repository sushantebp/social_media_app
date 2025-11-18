import 'package:flutter/material.dart';
import 'package:social_media_app/core/core.dart';
import 'package:social_media_app/features/dashboard/dashboard.dart';

class ProfileNameEmailSection extends StatelessWidget {
  final LocalUserDetailsModel user;
  const ProfileNameEmailSection({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Flexible(
              child: Text(
                user.name,
                style: context.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(width: 6),
            if (user.verified)
              Icon(Icons.verified, color: Colors.blue.shade500, size: 20),
          ],
        ),
        const SizedBox(height: 6),
        Text(user.email, style: context.textTheme.bodyMedium),
      ],
    );
  }
}
