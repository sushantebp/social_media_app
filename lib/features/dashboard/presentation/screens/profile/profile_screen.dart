import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/core.dart';
import 'package:social_media_app/features/dashboard/dashboard.dart';

@RoutePage()
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().getUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Scaffold(
          appBar: const MyAppBar(title: "Profile", centerTitle: false),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSize.paddingMedium,
            ),
            child: state.when(
              initial: () => const ProfileInitial(),
              loading: () => const ProfileLoading(),
              loaded: (userDetails, _, _, _, _) =>
                  ProfileDetailsLoaded(user: userDetails!),
              error: (errorMessage) => ProfileError(
                message: errorMessage ?? "Failed to fetch profile",
              ),
            ),
          ),
        );
      },
    );
  }
}

//
// ---------------- PROFILE LOADED ----------------
class ProfileDetailsLoaded extends StatelessWidget {
  final LocalUserDetailsModel user;

  const ProfileDetailsLoaded({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileHeaderSection(user: user),
          const SizedBox(height: AppSize.spaceLarge),
          ProfileNameEmailSection(user: user),
          const SizedBox(height: AppSize.spaceMedium),
          ProfileInterestsSection(user: user),
          const SizedBox(height: AppSize.spaceMedium),
          ProfileBirthdaySection(user: user),
          const SizedBox(height: AppSize.spaceLarge),
          ProfileButtonsSection(),
          const SizedBox(height: AppSize.spaceExtraLarge),
        ],
      ),
    );
  }
}

//
// ---------------- PROFILE INITIAL ----------------
class ProfileInitial extends StatelessWidget {
  const ProfileInitial({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Fetching profile...", style: context.textTheme.bodyMedium),
    );
  }
}

//
// ---------------- PROFILE LOADING ----------------
class ProfileLoading extends StatelessWidget {
  const ProfileLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: AppSize.spaceMedium),
          Row(
            children: const [
              ShimmerBox(width: 90, height: 90, radius: AppSize.radiusLarge),
              SizedBox(width: AppSize.spaceLarge),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ShimmerBox(width: 40, height: 20),
                    ShimmerBox(width: 40, height: 20),
                    ShimmerBox(width: 40, height: 20),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSize.spaceMedium),
          const ShimmerBox(width: double.infinity, height: 22),
          const SizedBox(height: AppSize.spaceSmall),
          const ShimmerBox(width: 80, height: 16),
          const SizedBox(height: AppSize.spaceSmall),
          const ShimmerBox(width: 80, height: 16),
          const SizedBox(height: AppSize.spaceMedium),
          const ShimmerBox(width: 120, height: 20),
          const SizedBox(height: AppSize.spaceSmall),
          Row(
            children: const [
              ShimmerBox(width: 80, height: 30),
              SizedBox(width: AppSize.spaceSmall),
              ShimmerBox(width: 80, height: 30),
            ],
          ),
          const SizedBox(height: AppSize.spaceLarge),
          Row(
            children: const [
              Expanded(child: ShimmerBox(width: double.infinity, height: 45)),
              SizedBox(width: AppSize.spaceMedium),
              Expanded(child: ShimmerBox(width: double.infinity, height: 45)),
            ],
          ),
          const SizedBox(height: AppSize.spaceExtraLarge),
        ],
      ),
    );
  }
}

//
// ---------------- PROFILE ERROR ----------------
class ProfileError extends StatelessWidget {
  final String message;

  const ProfileError({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            color: Theme.of(context).colorScheme.error,
            size: 60,
          ),
          const SizedBox(height: AppSize.spaceMedium),
          Text(
            message,
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontSize: AppSize.fontMedium),
          ),
          const SizedBox(height: AppSize.spaceLarge),
          AppButton(
            title: "Retry",
            onPressed: () => context.read<ProfileCubit>().getUserProfile(),
            type: AppButtonType.outlined,
          ),
        ],
      ),
    );
  }
}
