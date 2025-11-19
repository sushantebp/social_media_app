import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/core.dart';
import 'package:social_media_app/features/dashboard/dashboard.dart';

@RoutePage()
class SelectHobbieScreen extends StatefulWidget {
  const SelectHobbieScreen({super.key});

  @override
  State<SelectHobbieScreen> createState() => _SelectHobbieScreenState();
}

class _SelectHobbieScreenState extends State<SelectHobbieScreen> {
  final List<String> hobbies = [
    "Reading",
    "Sports",
    "Gardening",
    "Cooking",
    "Traveling",
    "Photography",
    "Arts and Crafts",
    "Music",
    "Fitness",
    "Gaming",
  ];

  final List<String> selectedHobbies = [];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: const MyAppBar(title: "Select your hobby", centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(AppSize.marginLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSize.marginLarge),
            const Text(
              "Select Your Hobbies",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),

            /// ------------------ Choice Chips ------------------
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: hobbies.map((hobbie) {
                final isSelected = selectedHobbies.contains(hobbie);

                return ChoiceChip(
                  label: Text(hobbie),
                  selected: isSelected,
                  selectedColor: colorScheme.primary.withValues(alpha: 0.2),
                  checkmarkColor: colorScheme.primary,
                  onSelected: (value) {
                    setState(() {
                      if (value) {
                        selectedHobbies.add(hobbie);
                      } else {
                        selectedHobbies.remove(hobbie);
                      }
                    });
                  },
                );
              }).toList(),
            ),

            const Spacer(),
            Expanded(
              child: AppButton(
                title: "Next",
                onPressed: () {
                  if (selectedHobbies.isEmpty) {
                    ToastHelper.warning(
                      context,
                      "Please select at least one hobby",
                    );
                    return;
                  }
                  context.read<ProfileCubit>().updateHobbies(selectedHobbies);
                  context.router.replaceAll([const DashboardRoute()]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
