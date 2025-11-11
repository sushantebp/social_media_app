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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSize.paddingMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: kToolbarHeight),
              const SizedBox(height: AppSize.marginExtraLarge),
              Text('Verify Your Email', style: context.textTheme.headlineSmall),
              const SizedBox(height: AppSize.marginSmall),
              Text(
                'We sent a verification code to:',
                style: context.textTheme.bodyMedium,
              ),
              const SizedBox(height: 4),
              Text(email, style: context.textTheme.bodyMedium),
              const SizedBox(height: AppSize.marginExtraLarge * 1.5),
              const CustomTextField(
                placeholder: 'Enter verification code',
                label: 'Verification Code',
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: AppSize.marginLarge),
              SizedBox(
                width: double.infinity,
                child: AppButton(title: 'Verify', onPressed: () {}),
              ),
              const SizedBox(height: AppSize.marginMedium),
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
      ),
    );
  }
}
