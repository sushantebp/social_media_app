import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ChatShellScreen extends StatelessWidget {
  const ChatShellScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoRouter();
  }
}