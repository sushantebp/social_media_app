import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/core.dart';
import 'package:social_media_app/features/dashboard/dashboard.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class SubscribeScreen extends StatelessWidget {
  const SubscribeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PostCubit>();
    final router = context.router;

    /// Handles subscription result
    Future<void> handleSubscription(String? url, String? successMessage) async {
      if (url != null && url.isNotEmpty) {
        final uri = Uri.parse(url);

        if (await canLaunchUrl(uri)) {
          // Open in-app webview and wait until the user closes it
          final launched = await launchUrl(
            uri,
            mode: LaunchMode.inAppWebView,
            webViewConfiguration: const WebViewConfiguration(
              enableDomStorage: true,
              enableJavaScript: true,
            ),
          );

          if (!launched) {
            if (!context.mounted) return;
            ToastHelper.error(context, "Could not open subscription link.");
            return;
          }

          // User closed the webview
          if (!context.mounted) return;
          ToastHelper.success(context, "Subscription process finished!");
          router.pop(); // Return to PostScreen
        } else {
          if (!context.mounted) return;
          ToastHelper.error(context, "Could not open subscription link.");
        }
      } else if (successMessage != null && successMessage.isNotEmpty) {
        // Fallback if URL not provided
        if (!context.mounted) return;
        ToastHelper.success(context, successMessage);
        router.pop(); // Return to PostScreen
      }
    }

    return Scaffold(
      body: BlocListener<PostCubit, PostState>(
        listener: (context, state) {
          state.maybeWhen(
            loaded: (_, _, successMessage, url) {
              handleSubscription(url, successMessage);
            },
            error: (message) {
              if (!context.mounted) return;
              ToastHelper.error(context, message ?? "Subscription failed");
            },
            orElse: () {},
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(AppSize.paddingLarge),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Please subscribe to add posts.",
                style: context.textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSize.spaceExtraLarge),
              AppButton(
                bgColor: Colors.red,
                title: "Subscribe Now",
                onPressed: () => cubit.subscribe(),
                type: AppButtonType.primary,
                width: double.infinity,
                height: 50,
              ),
              const SizedBox(height: AppSize.spaceMedium),
              AppButton(
                title: "Maybe Later",
                onPressed: () => router.pop(),
                type: AppButtonType.outlined,
                width: double.infinity,
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
