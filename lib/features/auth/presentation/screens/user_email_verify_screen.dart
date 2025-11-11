import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/core/core.dart';

@RoutePage()
class UserEmailVerifyScreen extends StatelessWidget {
  final String email;

  const UserEmailVerifyScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(allowBack: true),
      body: Padding(
        padding: const EdgeInsets.all(AppSize.paddingLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSize.marginExtraLarge),

            // Header
            Text(
              'Verify Your Email',
              style: context.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: context.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: AppSize.marginSmall),
            Text(
              'We sent a verification code to:',
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              email,
              style: context.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: context.colorScheme.primary,
              ),
            ),

            const SizedBox(height: AppSize.marginExtraLarge * 1.5),

            // Verification Code Input
            const CustomTextField(
              placeholder: 'Enter verification code',
              label: 'Verification Code',
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: AppSize.marginLarge),

            // Verify Button
            SizedBox(
              width: double.infinity,
              child: AppButton(title: 'Verify', onPressed: () {}),
            ),

            const SizedBox(height: AppSize.marginMedium),

            // Resend Code
            Center(
              child: AppButton(
                title: 'Resend Code',
                onPressed: () {},
                type: AppButtonType.text,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
