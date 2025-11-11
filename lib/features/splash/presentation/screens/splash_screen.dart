import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/core.dart';
import 'package:social_media_app/features/onboarding/cubit/onboarding_cubit.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    );

    _controller.forward();

    Timer(const Duration(seconds: 2), () {
      if (!mounted) return;

      final onboardingCubit = context.read<OnboardingCubit>();
      if (onboardingCubit.state) {
        context.router.replace(const UserLoginRoute());
      } else {
        context.router.replace(const OnboardingRoute());
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: context.colorScheme.surface,
        child: Center(
          child: ScaleTransition(
            scale: _animation,
            child: Image.asset(
              AppIcon.appIcon,
              width: context.screenWidth * 0.34,
              height: context.screenHeight * 0.2,
            ),
          ),
        ),
      ),
    );
  }
}
