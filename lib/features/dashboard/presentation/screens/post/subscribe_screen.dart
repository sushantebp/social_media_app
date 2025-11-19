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

    return Scaffold(
      appBar: const MyAppBar(title: "Subscribe", centerTitle: true),
      body: BlocListener<PostCubit, PostState>(
        listener: (context, state) async {
          // Check if loaded state contains a subscription URL
          state.maybeWhen(
            loaded: (_, _, successMessage, url) async {
              if (url != null && url.isNotEmpty) {
                final uri = Uri.parse(url);

                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                } else {
                  if (!context.mounted) return;
                  ToastHelper.error(
                    context,
                    "Could not open subscription link.",
                  );
                }
              } else if (successMessage != null && successMessage.isNotEmpty) {
                ToastHelper.success(context, successMessage);
                router.replace(const DashboardRoute());
              }
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
                "Please subscribe to access the latest posts and updates.",
                style: context.textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSize.spaceExtraLarge),
              AppButton(
                title: "Subscribe Now",
                onPressed: () => cubit.subscribe(),
                type: AppButtonType.primary,
                width: double.infinity,
                height: 50,
              ),
              const SizedBox(height: AppSize.spaceMedium),
              AppButton(
                title: "Maybe Later",
                onPressed: () => Navigator.of(context).pop(),
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
