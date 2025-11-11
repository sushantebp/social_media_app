import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:social_media_app/core/core.dart';
import 'package:social_media_app/features/onboarding/onboarding.dart';

@RoutePage()
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OnboardingCubit>();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSize.paddingLarge),
          child: Column(
            children: [
              const SizedBox(height: AppSize.spaceExtraLarge),
              Expanded(
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppSize.radiusLarge),
                    child: Image.asset(
                      AppImage.onboarding,
                      fit: BoxFit.contain,
                      width: 400,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: AppSize.spaceLarge),
              Text(
                'Connect and Share Freely',
                textAlign: TextAlign.center,
                style: context.textTheme.headlineSmall,
              ),

              const SizedBox(height: AppSize.spaceMedium),
              Text(
                'Join a vibrant community where you can share your moments, '
                'connect with friends, and express yourself freely.',
                textAlign: TextAlign.center,
                style: context.textTheme.bodyMedium,
              ),

              const SizedBox(height: AppSize.spaceExtraLarge),
              AppButton(
                title: 'Get Started',
                onPressed: () {
                  cubit.completeOnboarding();
                  context.router.replace(const UserLoginRoute());
                },
                width: double.infinity,
                type: AppButtonType.primary,
              ),

              const SizedBox(height: AppSize.spaceExtraLarge),
            ],
          ),
        ),
      ),
    );
  }
}
