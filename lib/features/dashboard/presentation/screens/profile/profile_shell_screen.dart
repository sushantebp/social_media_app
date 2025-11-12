import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ProfileShellScreen extends StatelessWidget {
  const ProfileShellScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoRouter();
  }
}
