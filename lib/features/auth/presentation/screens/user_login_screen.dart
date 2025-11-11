import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/core/core.dart';

@RoutePage()
class UserLoginScreen extends StatelessWidget {
  const UserLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final router = context.router;
    return Scaffold(
      appBar: const MyAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(AppSize.paddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSize.marginExtraLarge),
            Text(
              'Welcome Back 👋',
              style: context.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: context.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: AppSize.marginSmall),
            Text(
              'Log in to continue sharing and exploring.',
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: AppSize.marginExtraLarge * 1.2),
            const CustomTextField(
              placeholder: "Enter your email",
              label: 'Email',
            ),
            const SizedBox(height: AppSize.marginMedium),
            const CustomTextField(
              placeholder: "Enter your password",
              label: 'Password',
              isPassword: true,
            ),
            const SizedBox(height: AppSize.marginLarge),
            SizedBox(
              width: double.infinity,
              child: AppButton(
                icon: Icons.login_rounded,
                title: "Login",
                onPressed: () {},
              ),
            ),
            const SizedBox(height: AppSize.marginMedium),
            Align(
              alignment: Alignment.centerRight,
              child: AppButton(
                title: "Forgot Password?",
                onPressed: () => router.push(const UserPasswordChangeRoute()),
                type: AppButtonType.text,
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account?",
                  style: context.textTheme.bodyMedium,
                ),
                AppButton(
                  title: "Register",
                  onPressed: () => router.push(const UserRegisterRoute()),
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
