import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/core.dart';
import 'package:social_media_app/features/dashboard/dashboard.dart';

@RoutePage()
class SelectAcademicQScreen extends StatefulWidget {
  const SelectAcademicQScreen({super.key});

  @override
  State<SelectAcademicQScreen> createState() => _SelectAcademicQScreenState();
}

class _SelectAcademicQScreenState extends State<SelectAcademicQScreen> {
  String? selectedDegree;
  int? selectedPassedYear;

  final List<AcademicQualificationItem> qualifications = [];

  final degrees = [
    "SEE / SLC",
    "+2 / Intermediate",
    "Bachelor",
    "Master",
    "PhD",
  ];

  final years = List<int>.generate(60, (i) => DateTime.now().year - i);

  void addAcademic() {
    if (selectedDegree != null && selectedPassedYear != null) {
      setState(() {
        qualifications.add(
          AcademicQualificationItem(
            passedYear: selectedPassedYear!,
            degreeName: selectedDegree!,
          ),
        );
      });
    }
  }

  void updateAcademic() {
    if (qualifications.isEmpty) return;

    final request = AcademicData(academicQualification: qualifications);

    context.read<ProfileCubit>().updateAcademicQualification(request);

    context.router.push(const SelectHobbieRoute());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(AppSize.marginLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Add Academic Qualification",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 24),

            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: "Degree",
                border: OutlineInputBorder(),
              ),
              items: degrees
                  .map((deg) => DropdownMenuItem(value: deg, child: Text(deg)))
                  .toList(),
              onChanged: (v) => selectedDegree = v,
            ),
            const SizedBox(height: 20),

            DropdownButtonFormField<int>(
              decoration: const InputDecoration(
                labelText: "Passed Year",
                border: OutlineInputBorder(),
              ),
              items: years
                  .map(
                    (yr) =>
                        DropdownMenuItem(value: yr, child: Text(yr.toString())),
                  )
                  .toList(),
              onChanged: (v) => selectedPassedYear = v,
            ),
            const SizedBox(height: 20),

            AppButton(title: "Add", onPressed: addAcademic),

            const SizedBox(height: 20),
            const Text(
              "Your Entries:",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),

            Expanded(
              child: ListView.builder(
                itemCount: qualifications.length,
                itemBuilder: (context, index) {
                  final item = qualifications[index];
                  return Card(
                    child: ListTile(
                      title: Text(item.degreeName),
                      subtitle: Text("Year: ${item.passedYear}"),
                    ),
                  );
                },
              ),
            ),

            AppButton(title: "Save & Continue", onPressed: updateAcademic),
          ],
        ),
      ),
    );
  }
}
