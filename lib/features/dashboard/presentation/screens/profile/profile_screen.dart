import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/core.dart';
import 'package:social_media_app/features/auth/auth.dart';
import 'package:social_media_app/features/dashboard/dashboard.dart';

@RoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProfileCubit>();
    final bloc = context.read<AuthBloc>();

    cubit.getUserProfile();

    return Scaffold(
      appBar: const MyAppBar(title: "Profile", centerTitle: false),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          state.whenOrNull(
            loaded: (_, _, successMessage) {
              if (successMessage != null && successMessage.isNotEmpty) {
                // showToast(message: successMessage);
              }
            },
          );
        },
        builder: (context, state) {
          return state.when(
            loading: () => const _ProfileSkeleton(),
            initial: () => const _ProfileSkeleton(),
            error: (errorMessage) =>
                Center(child: Text(errorMessage ?? "Something went wrong")),
            loaded: (user, _, successMessage) {
              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSize.paddingMedium,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: AppSize.marginLarge * 2),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: context.colorScheme.onSurface.withValues(
                                  alpha: 0.1,
                                ),
                              ),
                              padding: const EdgeInsets.all(3),
                              child: CircleAvatar(
                                radius: 42,
                                backgroundImage: NetworkImage(
                                  // user.profileImage ??
                                  "https://i.pravatar.cc/300",
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(width: 24),

                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              StatColumn(
                                // count: "${user.posts?.length ?? 0}",
                                count: "2",
                                label: "Posts",
                              ),
                              StatColumn(
                                // count: "${user.followers?.length ?? 0}",
                                count: "12",
                                label: "Followers",
                              ),
                              StatColumn(
                                // count: "${user.following?.length ?? 0}",
                                count: "34",
                                label: "Following",
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // ---------------- NAME + VERIFIED ----------------
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            user?.name ?? "Unknown User",
                            style: context.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),

                        if (user?.verified == true)
                          Icon(
                            Icons.verified,
                            color: Colors.blue.shade500,
                            size: 20,
                          ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    Text(
                      user?.email ?? "",
                      style: context.textTheme.bodyMedium,
                    ),

                    const SizedBox(height: 18),

                    // ---------------- INTERESTS ----------------
                    Text("Interests", style: context.textTheme.titleMedium),
                    const SizedBox(height: 6),

                    // Wrap(
                    //   spacing: 8,
                    //   runSpacing: 8,
                    //   children: (user?.hobbies?.isNotEmpty ?? false)
                    //       // ? user.hobbies
                    //       //       .map((h) => InterestChip(label: h))
                    //       //       .toList()
                    //       user?.hobbies.map((hobby)=> InterestChip(label: hobby)).toList()
                    //       : [InterestChip(label: "No interests added")],
                    // ),
                    const SizedBox(height: 20),

                    // ---------------- BIRTHDAY ----------------
                    Text("Birthday", style: context.textTheme.titleMedium),
                    const SizedBox(height: 6),

                    Row(
                      children: [
                        Icon(
                          Icons.cake,
                          color: context.colorScheme.primary,
                          size: 24,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          user?.dateOfBirth ?? "Not set",
                          style: context.textTheme.bodyMedium,
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    // ---------------- BUTTONS ROW ----------------
                    Row(
                      children: [
                        Expanded(
                          child: AppButton(
                            title: 'Edit Profile',
                            onPressed: () =>
                                context.router.push(const EditProfileRoute()),
                            type: AppButtonType.outlined,
                          ),
                        ),
                        const SizedBox(width: AppSize.marginMedium),
                        Expanded(
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: Theme.of(
                                context,
                              ).colorScheme.copyWith(primary: Colors.red),
                            ),
                            child: AppButton(
                              title: 'Log Out',
                              type: AppButtonType.outlined,
                              fgColor: Colors.red,
                              onPressed: () =>
                                  bloc.add(const LogoutSubmitted()),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

//
// --------------------- INTEREST CHIP ---------------------
//
class InterestChip extends StatelessWidget {
  final String label;
  const InterestChip({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSize.marginMedium,
        vertical: AppSize.marginMedium / 2,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.marginLarge),
        color: context.colorScheme.onSurface.withValues(alpha: 0.1),
      ),
      child: Text(label, style: context.textTheme.labelMedium),
    );
  }
}

//
// ---------------------- STAT COLUMN ----------------------
//
class StatColumn extends StatelessWidget {
  final String count;
  final String label;
  const StatColumn({super.key, required this.count, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          count,
          style: context.textTheme.labelLarge?.copyWith(fontSize: 17),
        ),
        const SizedBox(height: AppSize.marginSmall / 2),
        Text(label, style: context.textTheme.labelLarge),
      ],
    );
  }
}

//
// --------------------- SKELETON UI ----------------------
//
class _ProfileSkeleton extends StatelessWidget {
  const _ProfileSkeleton();

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: AppSize.paddingMedium),
      child: Column(
        children: [
          SizedBox(height: 40),

          Row(
            children: [
              ShimmerBox(width: 90, height: 90, radius: 50),
              SizedBox(width: 24),
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

          SizedBox(height: 20),
          ShimmerBox(width: double.infinity, height: 22),
          SizedBox(height: 8),
          ShimmerBox(width: 80, height: 16),
          ShimmerBox(width: 80, height: 16),

          SizedBox(height: 20),
          ShimmerBox(width: 120, height: 20),
          SizedBox(height: 8),

          Row(
            children: [
              ShimmerBox(width: 80, height: 30),
              SizedBox(width: 10),
              ShimmerBox(width: 80, height: 30),
            ],
          ),

          SizedBox(height: 30),

          Row(
            children: [
              Expanded(child: ShimmerBox(width: double.infinity, height: 45)),
              SizedBox(width: 12),
              Expanded(child: ShimmerBox(width: double.infinity, height: 45)),
            ],
          ),

          SizedBox(height: 40),
        ],
      ),
    );
  }
}

class ShimmerBox extends StatelessWidget {
  final double width;
  final double height;
  final double radius;

  const ShimmerBox({
    super.key,
    required this.width,
    required this.height,
    this.radius = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: context.colorScheme.onSurface.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}
