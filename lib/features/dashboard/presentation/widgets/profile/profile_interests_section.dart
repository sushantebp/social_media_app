import 'package:flutter/material.dart';
import 'package:social_media_app/core/core.dart';
import 'package:social_media_app/features/dashboard/dashboard.dart';

class ProfileInterestsSection extends StatelessWidget {
  final LocalUserDetailsModel user;
  const ProfileInterestsSection({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final hobbies = user.hobbies ?? [];

    final displayedHobbies = hobbies.length > 5
        ? hobbies.sublist(0, 5)
        : hobbies;

    final remainingCount = hobbies.length - displayedHobbies.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Interests", style: context.textTheme.titleMedium),
        const SizedBox(height: 6),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ...displayedHobbies.map((hobby) => InterestChip(label: hobby)),
            if (remainingCount > 0)
              InterestChip(label: "+$remainingCount more"),

            if (hobbies.isEmpty)
              const InterestChip(label: "No interests added"),
          ],
        ),
      ],
    );
  }
}
