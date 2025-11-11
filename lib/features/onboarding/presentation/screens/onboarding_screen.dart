import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/core/core.dart';

@RoutePage()
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: const MyAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 40),
            // Illustration / Onboarding Image
            Expanded(
              child: Center(
                child: Image.asset(
                  AppImage.onboarding,
                  fit: BoxFit.contain,
                  width: 260,
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Header text
            Text(
              'Connect and Share Freely',
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),

            const SizedBox(height: 12),

            // App description
            Text(
              'Join a vibrant community where you can share your moments, '
              'connect with friends, and express yourself freely.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
                height: 1.4,
              ),
            ),

            const Spacer(),

            // Button to get started
            AppButton(
              title: 'Get Started',
              onPressed: () => context.router.replace(const UserLoginRoute()),
              width: double.infinity,
              type: AppButtonType.primary,
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
