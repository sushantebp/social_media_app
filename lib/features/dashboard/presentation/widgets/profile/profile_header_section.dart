import 'package:flutter/material.dart';
import 'package:social_media_app/core/core.dart';

import 'package:social_media_app/features/dashboard/dashboard.dart';

class ProfileHeaderSection extends StatelessWidget {
  final LocalUserDetailsModel user;
  const ProfileHeaderSection({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          children: [
            Container(
              decoration: BoxDecoration(shape: BoxShape.circle),
              padding: const EdgeInsets.all(3),
              child: CircleAvatar(
                radius: 42,
                child: Text(
                  user.name[0],
                  style: context.textTheme.displaySmall,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 24),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              StatColumn(
                count: "${user.followers?.length ?? 0}",
                label: "Followers",
              ),
              StatColumn(
                count: "${user.following?.length ?? 0}",
                label: "Following",
              ),
            ],
          ),
        ),
      ],
    );
  }
}
