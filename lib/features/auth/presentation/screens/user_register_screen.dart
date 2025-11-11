import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/core/core.dart';

@RoutePage()
class UserRegisterScreen extends StatelessWidget {
  const UserRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: const MyAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(AppSize.paddingMedium),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSize.marginExtraLarge),

            // Header
            Text(
              'Create Account ✨',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: AppSize.marginSmall),
            Text(
              'Join and start connecting with people today.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),

            const SizedBox(height: AppSize.marginExtraLarge * 1.2),

            // Name field
            const CustomTextField(
              placeholder: "Enter your full name",
              label: 'Full Name',
            ),
            const SizedBox(height: AppSize.marginMedium),

            // Email field
            const CustomTextField(
              placeholder: "Enter your email",
              label: 'Email',
            ),
            const SizedBox(height: AppSize.marginMedium),

            // Password field
            const CustomTextField(
              placeholder: "Create a password",
              label: 'Password',
              isPassword: true,
            ),
            const SizedBox(height: AppSize.marginLarge),

            // Register Button
            SizedBox(
              width: double.infinity,
              child: AppButton(
                icon: Icons.person_add_alt_1_rounded,
                title: "Register",
                onPressed: () =>
                    context.router.push(UserEmailVerifyRoute(email: "")),
              ),
            ),

            const Spacer(),

            // Login redirect
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account?",
                  style: theme.textTheme.bodyMedium,
                ),
                AppButton(
                  title: "Login",
                  onPressed: () => context.pushRoute(const UserLoginRoute()),
                  type: AppButtonType.text,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
