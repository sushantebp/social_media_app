import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:social_media_app/core/core.dart';
import 'package:social_media_app/features/dashboard/dashboard.dart';

class ProfileBirthdaySection extends StatelessWidget {
  final LocalUserDetailsModel user;
  const ProfileBirthdaySection({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    String displayDate = "Not set";

    if (user.dateOfBirth != null) {
      final date = DateTime.tryParse(user.dateOfBirth!);
      if (date != null) {
        displayDate = DateFormat('MMM d, yyyy').format(date);
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Birthday", style: context.textTheme.titleMedium),
        const SizedBox(height: 6),
        Row(
          children: [
            Icon(Icons.cake, color: context.colorScheme.primary, size: 24),
            const SizedBox(width: 8),
            Text(displayDate, style: context.textTheme.bodyMedium),
          ],
        ),
      ],
    );
  }
}
