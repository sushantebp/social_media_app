import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/core.dart';
import 'package:social_media_app/features/dashboard/dashboard.dart';
import 'package:social_media_app/features/dashboard/data/models/profile/create_academic_request.dart';

@RoutePage()
class UserRegisterFormScreen extends StatefulWidget {
  const UserRegisterFormScreen({super.key});

  @override
  State<UserRegisterFormScreen> createState() => _UserRegisterFormScreenState();
}

class _UserRegisterFormScreenState extends State<UserRegisterFormScreen> {
  final _formKey = GlobalKey<FormState>();

  final dobController = TextEditingController();
  final hobbiesController = TextEditingController();
  final yearController = TextEditingController();
  final degreeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProfileCubit>();

    return Scaffold(
      appBar: AppBar(title: const Text("Complete Your Profile")),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {},
        builder: (context, state) {
          final isLoading = state is;

          return AbsorbPointer(
            absorbing: isLoading,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // ---- DOB ----
                    CustomTextField(
                      controller: dobController,
                      placeholder: "Date of Birth (YYYY-MM-DD)",
                      readOnly: true,
                      onTap: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime(2000),
                          firstDate: DateTime(1940),
                          lastDate: DateTime.now(),
                        );
                        if (picked != null) {
                          dobController.text = picked
                              .toIso8601String()
                              .split("T")
                              .first;
                        }
                      },
                      validator: (v) =>
                          v == null || v.isEmpty ? "Please select DOB" : null,
                    ),
                    const SizedBox(height: 12),

                    // ---- Hobbies ----
                    CustomTextField(
                      controller: hobbiesController,
                      placeholder: "Hobbies (comma separated)",
                      validator: (v) =>
                          v == null || v.isEmpty ? "Enter hobbies" : null,
                    ),
                    const SizedBox(height: 12),

                    // ---- Academic ----
                    CustomTextField(
                      controller: yearController,
                      placeholder: "Passed Year",
                      keyboardType: TextInputType.number,
                      validator: (v) =>
                          v == null || v.isEmpty ? "Required" : null,
                    ),
                    const SizedBox(height: 8),

                    CustomTextField(
                      controller: degreeController,
                      placeholder: "Degree Name",
                      validator: (v) =>
                          v == null || v.isEmpty ? "Required" : null,
                    ),

                    const SizedBox(height: 20),

                    // ---- Submit ----
                    AppButton(
                      title: isLoading ? "Saving..." : "Save & Continue",
                      onPressed: () async {
                        if (!_formKey.currentState!.validate()) return;

                        // DOB
                        final dob = DateTime.parse(dobController.text);
                        await cubit.updateDob(dob);

                        // Hobbies
                        final hobbies = hobbiesController.text
                            .split(",")
                            .map((e) => e.trim())
                            .toList();
                        await cubit.updateHobbies(hobbies);

                        // Location — no fields needed
                        await cubit.updateLocation();

                        // Academic qualification
                        final academicRequest = CreateAcademicRequest(
                          academicQualification: [
                            AcademicQualificationItem(
                              passedYear: int.parse(yearController.text),
                              degreeName: degreeController.text.trim(),
                            ),
                          ],
                        );
                        await cubit.updateAcademicQualification(
                          academicRequest,
                        );

                        // Navigate to Dashboard
                        context.router.replace(const DashboardRoute());
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
