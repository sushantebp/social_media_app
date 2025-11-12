import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/core/core.dart';

@RoutePage()
class UserPasswordChangeScreen extends StatelessWidget {
  const UserPasswordChangeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSize.paddingMedium),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: kToolbarHeight),
                const SizedBox(height: AppSize.marginExtraLarge),
                Text(
                  'Update Your Password',
                  style: context.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: AppSize.marginSmall),
                Text(
                  'Enter your current password and choose a new one.',
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),

                const SizedBox(height: AppSize.marginExtraLarge * 1.2),
                // Old Password
                CustomTextField(
                  placeholder: 'Enter old password',
                  label: 'Old Password',
                  isPassword: true,
                  validator: (value) {
                    if (value?.isEmpty ?? false) {
                      return "Old Password is also required";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppSize.marginMedium),
                // New Password
                CustomTextField(
                  placeholder: 'Enter new password',
                  label: 'New Password',
                  isPassword: true,
                  validator: (value) {
                    if (value?.isEmpty ?? false) {
                      return "New Password is required";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppSize.marginLarge),
                // Update Button
                SizedBox(
                  width: double.infinity,
                  child: AppButton(
                    title: 'Update Password',
                    onPressed: () {
                      if (formKey.currentState?.validate() ?? false) {}
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
