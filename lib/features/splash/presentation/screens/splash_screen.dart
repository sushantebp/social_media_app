import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/core/core.dart';

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

    // Navigate to login after 2 seconds
    Timer(const Duration(seconds: 2), () {
      if (mounted) {
        // in future me will use logic
        // to check for to go to login or onboarding screen
        // for now jus to onboarding
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
            child: Image.asset(AppIcon.appIcon, width: 120, height: 120),
          ),
        ),
      ),
    );
  }
}
