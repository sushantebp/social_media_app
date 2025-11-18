import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/core.dart';
import 'package:social_media_app/features/auth/auth.dart';

class ProfileButtonsSection extends StatelessWidget {
  const ProfileButtonsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final router = context.router;
    final bloc = context.read<AuthBloc>();

    void onLogout() {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Log Out", style: context.textTheme.titleLarge),
          content: Text(
            "Are you sure to logout?",
            style: context.textTheme.titleMedium,
          ),
          actions: [
            AppButton(
              type: AppButtonType.text,
              onPressed: () => Navigator.of(context).pop(),
              title: "No",
            ),
            AppButton(
              type: AppButtonType.text,
              onPressed: () {
                bloc.add(const LogoutSubmitted());
                router.replace(const UserLoginRoute());
              },
              title: "Yes",
            ),
          ],
        ),
      );
    }

    return Row(
      children: [
        Expanded(
          child: AppButton(
            title: 'Edit Profile',
            onPressed: () => router.push(const EditProfileRoute()),
            type: AppButtonType.outlined,
          ),
        ),
        const SizedBox(width: AppSize.marginMedium),
        Expanded(
          child: Theme(
            data: Theme.of(context).copyWith(
              colorScheme: Theme.of(
                context,
              ).colorScheme.copyWith(primary: Colors.red),
            ),
            child: AppButton(
              title: 'Log Out',
              type: AppButtonType.outlined,
              fgColor: Colors.red,
              onPressed: () => onLogout(),
            ),
          ),
        ),
      ],
    );
  }
}
