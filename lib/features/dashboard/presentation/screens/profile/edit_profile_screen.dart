import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/core.dart';
import 'package:social_media_app/features/dashboard/dashboard.dart';

/// things that are need to update/delete
/// hobbies,academcie q,dob,location
@RoutePage()
class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProfileCubit>();
    final user = cubit.state.maybeWhen(
      loaded: (userDetails, _, _, _, _) => userDetails,
      orElse: () => null,
    );

    final dobController = TextEditingController(text: user?.dateOfBirth ?? "");
    final hobbiesController = TextEditingController(
      text: user?.hobbies?.join(", ") ?? "",
    );

    return Scaffold(
      appBar: const MyAppBar(
        title: "Edit Profile",
        centerTitle: false,
        allowBack: true,
      ),
      body: BlocListener<ProfileCubit, ProfileState>(
        listener: (context, state) {
          state.maybeWhen(
            loaded: (userDetails, _, _, _, message) {
              if (message != null && message.isNotEmpty) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(message)));
              }
            },
            orElse: () {},
          );
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // ===== HOBBIES =====
              _buildSectionLabel("Hobbies"),
              TextFormField(
                controller: hobbiesController,
                decoration: const InputDecoration(
                  hintText: "Enter your hobbies separated by comma",
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        final hobbies = hobbiesController.text
                            .split(",")
                            .map((e) => e.trim())
                            .toList();
                        cubit.updateHobbies(hobbies);
                      },
                      child: const Text("Update Hobbies"),
                    ),
                  ),
                  const SizedBox(width: 8),
                  if ((user?.hobbies ?? []).isNotEmpty)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: cubit.deleteHobby,
                        child: const Text("Delete Hobbies"),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 24),

              // ===== DATE OF BIRTH =====
              _buildSectionLabel("Date of Birth"),
              TextFormField(
                controller: dobController,
                readOnly: true,
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate:
                        DateTime.tryParse(dobController.text) ??
                        DateTime(2000, 1, 1),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (date != null) {
                    dobController.text = date
                        .toIso8601String()
                        .split("T")
                        .first;
                  }
                },
                decoration: const InputDecoration(
                  hintText: "Select Date of Birth",
                ),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  if (dobController.text.isNotEmpty) {
                    cubit.updateDob(DateTime.parse(dobController.text));
                  }
                },
                child: const Text("Update Date of Birth"),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}

/// CRUD operation
/// hobbbies,academiceq,dob, location(optional)
@RoutePage()
class ScreenEditProfile extends StatelessWidget {
  const ScreenEditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: "Edit Profile",
        allowBack: true,
        centerTitle: false,
      ),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          state.maybeWhen(
            orElse: () {},
            loaded: (_, __, ___, ____, successMessage) {
              ToastHelper.success(context, successMessage!);
            },
            error: (errorMessage) {
              ToastHelper.error(context, errorMessage!);
            },
          );
        },
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () => _ProfileNotLoaded(),
            loaded: (userDetails, hobbies, dob, academics, _) =>
                _LoadedProfileData(),
          );
        },
      ),
    );
  }
}

class _ProfileNotLoaded extends StatelessWidget {
  const _ProfileNotLoaded();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, color: context.colorScheme.error, size: 60),
          const SizedBox(height: AppSize.spaceLarge),
        ],
      ),
    );
  }
}

class _LoadedProfileData extends StatelessWidget {
  const _LoadedProfileData();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: AppSize.paddingMedium),
      child: Column(
        children: [
          // ui of hobbie
          //
        ],
      ),
    );
  }
}
