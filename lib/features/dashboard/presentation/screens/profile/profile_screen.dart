// import 'package:auto_route/auto_route.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:social_media_app/core/core.dart';
// import 'package:social_media_app/features/auth/auth.dart';
// import 'package:social_media_app/features/dashboard/dashboard.dart';

// @RoutePage()
// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     context.read<ProfileCubit>().getUserProfile();

//     return Scaffold(
//       appBar: const MyAppBar(title: "Profile", centerTitle: false),
//       body: BlocBuilder<ProfileCubit, ProfileState>(
//         builder: (context, state) {
//           return state.when(
//             initial: () => const Center(child: CircularProgressIndicator()),
//             loading: () =>
//                 const Center(child: CircularProgressIndicator.adaptive()),
//             error: (message) => Center(
//               child: Padding(
//                 padding: const EdgeInsets.all(24),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Icon(Icons.error_outline, size: 64),
//                     const SizedBox(height: 16),
//                     Text(
//                       message ?? "Something went wrong",
//                       style: TextStyle(
//                         color: Colors.red.shade700,
//                         fontSize: 16,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             loaded: (userDetails, successMessage) {
//               final ud = userDetails;
//               return SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     // PROFILE HEADER SECTION
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                         vertical: 20,
//                         horizontal: 16,
//                       ),
//                       child: Column(
//                         children: [
//                           Row(
//                             children: [
//                               Stack(
//                                 children: [
//                                   Container(
//                                     decoration: BoxDecoration(
//                                       shape: BoxShape.circle,
//                                       color: context.colorScheme.onSurface,
//                                     ),
//                                     padding: const EdgeInsets.all(3),
//                                     child: CircleAvatar(
//                                       radius: 42,
//                                       child: CircleAvatar(
//                                         radius: 40,
//                                         child: Text(
//                                           ud?.name.isNotEmpty == true
//                                               ? ud!.name[0].toUpperCase()
//                                               : "?",
//                                           style: const TextStyle(
//                                             fontSize: 36,
//                                             fontWeight: FontWeight.w600,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   // Verified Badge
//                                   if (ud?.verified == true)
//                                     Positioned(
//                                       right: 0,
//                                       bottom: 0,
//                                       child: Container(
//                                         padding: const EdgeInsets.all(4),
//                                         decoration: const BoxDecoration(
//                                           shape: BoxShape.circle,
//                                         ),
//                                       ),
//                                     ),
//                                 ],
//                               ),
//                               const SizedBox(width: 24),
//                               // Stats
//                               Expanded(
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceEvenly,
//                                   children: [
//                                     // _buildStatColumn("0", "Posts"),
//                                     _buildStatColumn(
//                                       "${ud?.followers?.length ?? 0}",
//                                       "Followers",
//                                     ),
//                                     _buildStatColumn(
//                                       "${ud?.following?.length ?? 0}",
//                                       "Following",
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 16),
//                           // Name and Verified Badge
//                           Row(
//                             children: [
//                               Flexible(
//                                 child: Text(
//                                   ud?.name ?? "Unknown",
//                                   style: const TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                   maxLines: 1,
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                               ),
//                               if (ud?.verified == true) ...[
//                                 const SizedBox(width: 4),
//                                 Icon(
//                                   Icons.verified,
//                                   color: Colors.blue.shade500,
//                                   size: 18,
//                                 ),
//                               ],
//                             ],
//                           ),
//                           const SizedBox(height: 4),
//                           // Email
//                           Align(
//                             alignment: Alignment.centerLeft,
//                             child: Text(
//                               ud?.email ?? "No email",
//                               style: TextStyle(fontSize: 14),
//                             ),
//                           ),
//                           const SizedBox(height: 16),
//                           // Action Buttons
//                           Row(
//                             children: [
//                               Expanded(
//                                 child: _buildActionButton(
//                                   "Edit Profile",
//                                   onPressed: () => context.router.push(
//                                     const EditProfileRoute(),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     // ADDITIONAL INFO SECTION
//                     if (ud?.dateOfBirth != null ||
//                         (ud?.hobbies != null && ud!.hobbies!.isNotEmpty))
//                       Container(
//                         width: double.infinity,
//                         padding: const EdgeInsets.all(16),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             if (ud?.dateOfBirth != null) ...[
//                               _buildInfoRow(
//                                 Icons.cake_outlined,
//                                 "Birthday",
//                                 ud!.dateOfBirth!,
//                               ),
//                             ],
//                             if (ud?.hobbies != null &&
//                                 ud!.hobbies!.isNotEmpty) ...[
//                               if (ud.dateOfBirth != null)
//                                 const SizedBox(height: 12),
//                               _buildInfoRow(
//                                 Icons.favorite_border,
//                                 "Interests",
//                                 ud.hobbies!.join(", "),
//                               ),
//                             ],
//                           ],
//                         ),
//                       ),
//                     const SizedBox(height: 8),
//                     // LOGOUT SECTION
//                     SizedBox(
//                       width: double.infinity,
//                       child: AppButton(
//                         onPressed: () => _showLogoutDialog(context),
//                         title: 'Log Out',
//                         icon: Icons.logout,
//                         type: AppButtonType.outlined,
//                       ),
//                     ),
//                     const SizedBox(height: 24),
//                   ],
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildStatColumn(String count, String label) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Text(
//           count,
//           style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//         ),
//         const SizedBox(height: 2),
//         Text(
//           label,
//           style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
//         ),
//       ],
//     );
//   }

//   Widget _buildActionButton(String text, {VoidCallback? onPressed}) {
//     return InkWell(
//       onTap: onPressed,
//       child: Container(
//         padding: const EdgeInsets.symmetric(vertical: 8),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Center(
//           child: Text(
//             text,
//             style: const TextStyle(
//               fontWeight: FontWeight.w600,
//               fontSize: 14,
//               color: Colors.black87,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildInfoRow(IconData icon, String label, String value) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Icon(icon, size: 20, color: Colors.grey.shade600),
//         const SizedBox(width: 12),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 label,
//                 style: TextStyle(
//                   fontSize: 13,
//                   color: Colors.grey.shade600,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               const SizedBox(height: 2),
//               Text(
//                 value,
//                 style: const TextStyle(fontSize: 14, color: Colors.black87),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   void _showLogoutDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (ctx) => AlertDialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//         title: const Text(
//           "Log Out",
//           style: TextStyle(fontWeight: FontWeight.w600),
//         ),
//         content: const Text("Are you sure you want to log out?"),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(ctx).pop(),
//             child: Text(
//               "Cancel",
//               style: TextStyle(color: Colors.grey.shade700),
//             ),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.of(ctx).pop();
//               context.read<AuthBloc>().add(const LogoutSubmitted());
//             },
//             child: Text(
//               "Log Out",
//               style: TextStyle(
//                 color: Colors.red.shade600,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/core.dart';
import 'package:social_media_app/features/dashboard/dashboard.dart';

@RoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProfileCubit>();

    return Scaffold(
      appBar: const MyAppBar(title: "Profile", centerTitle: false),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        // TODO : yo garnu parcha
        // build when there is change in userDetails
        // buildWhen: (previous, current) => ,
        listener: (context, state) {},
        builder: (context, state) {
          return BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              return state.when(
                // initially i think hai ,i would use skeleton response here for now static
                // ki ta get from localstorage data to display
                // initial: () => const Center(child: Text("Initial stage")),
                loading: () =>
                    const Center(child: CircularProgressIndicator.adaptive()),
                error: (errorMessage) {
                  return Center(child: Text(errorMessage!));
                },
                loaded: (userDetails, successMessage) {
                  return SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSize.paddingMedium,
                    ),
                    child: Column(children: []),
                  );
                },
                initial: () {
                  return SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSize.paddingMedium,
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 16,
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: context.colorScheme.onSurface
                                              .withValues(alpha: 0.23),
                                        ),
                                        padding: const EdgeInsets.all(3),
                                        child: const CircleAvatar(
                                          radius: 42,
                                          child: CircleAvatar(
                                            radius: 40,
                                            child: Text(
                                              "S",
                                              style: TextStyle(
                                                fontSize: 36,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),

                                      // Verified Badge (static example)
                                    ],
                                  ),
                                  const SizedBox(width: 24),
                                  // Stats
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        buildStatColumn("12", "Followers"),
                                        buildStatColumn("34", "Following"),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              // Name and verified badge
                              Row(
                                children: [
                                  const Flexible(
                                    child: Text(
                                      "Samir",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Icon(
                                    Icons.verified,
                                    color: Colors.blue.shade500,
                                    size: 18,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              // Email
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "samir@example.com",
                                  style: context.textTheme.titleMedium,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // edit profile section,
                        AppButton(
                          title: 'Edit Profile',
                          onPressed: () {},
                          type: AppButtonType.outlined,
                        ),
                        const SizedBox(height: AppSize.marginMedium),
                        // logout section
                        SizedBox(
                          width: double.infinity,
                          child: AppButton(
                            title: 'Log Out',
                            onPressed: () {},
                            type: AppButtonType.outlined,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

Widget buildStatColumn(String count, String label) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        count,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      ),
      const SizedBox(height: 2),
      Text(label, style: TextStyle(fontSize: 13, color: Colors.grey.shade600)),
    ],
  );
}
