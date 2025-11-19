import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/core.dart';
import 'package:social_media_app/features/dashboard/dashboard.dart';

@RoutePage()
class SelectDobScreen extends StatefulWidget {
  const SelectDobScreen({super.key});

  @override
  State<SelectDobScreen> createState() => _SelectDobScreenState();
}

class _SelectDobScreenState extends State<SelectDobScreen> {
  DateTime? selectedDob;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: "Select your date of birth",
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSize.marginLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSize.marginLarge),
            Text(
              "Select Your Date of Birth",
              style: context.textTheme.bodySmall,
            ),
            const SizedBox(height: 20),

            /// DOB DISPLAY
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade400),
              ),
              child: Text(
                selectedDob == null
                    ? "No date selected"
                    : "${selectedDob!.year}-${selectedDob!.month}-${selectedDob!.day}",
                style: const TextStyle(fontSize: 16),
              ),
            ),

            const SizedBox(height: 20),

            /// Pick Date
            AppButton(
              title: "Choose Date",
              onPressed: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: selectedDob ?? DateTime(2000),
                  firstDate: DateTime(1950),
                  lastDate: DateTime.now(),
                );

                if (picked != null) {
                  setState(() {
                    selectedDob = picked;
                  });
                  if (!context.mounted) return;
                  // Update cubit
                  context.read<ProfileCubit>().updateDob(picked);
                }
              },
            ),

            const Spacer(),

            /// Continue
            AppButton(
              title: "Continue",
              onPressed: () {
                if (selectedDob != null) {
                  context.router.push(const SelectAcademicQRoute());
                } else {
                  ToastHelper.warning(context, "Please select a DOB");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
