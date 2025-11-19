import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/core.dart';
import 'package:social_media_app/features/dashboard/dashboard.dart';

@RoutePage()
class UserRegisterFormScreen extends StatefulWidget {
  const UserRegisterFormScreen({super.key});

  @override
  State<UserRegisterFormScreen> createState() => _UserRegisterFormScreenState();
}

class _UserRegisterFormScreenState extends State<UserRegisterFormScreen> {
  final _formKey = GlobalKey<FormState>();
  DateTime? _selectedDob;
  final _hobbiesController = TextEditingController();
  final _degreeController = TextEditingController();
  final _yearController = TextEditingController();
  final List<String> _hobbiesList = [];
  final List<AcademicQualificationItem> _academicsList = [];

  @override
  void dispose() {
    _hobbiesController.dispose();
    _degreeController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDob) {
      setState(() {
        _selectedDob = picked;
      });
    }
  }

  void _addHobby() {
    if (_hobbiesController.text.trim().isNotEmpty) {
      setState(() {
        _hobbiesList.add(_hobbiesController.text.trim());
        _hobbiesController.clear();
      });
    }
  }

  void _removeHobby(int index) => setState(() => _hobbiesList.removeAt(index));

  void _addAcademic() {
    if (_degreeController.text.trim().isNotEmpty &&
        _yearController.text.trim().isNotEmpty) {
      final year = int.tryParse(_yearController.text.trim());
      if (year != null) {
        setState(() {
          _academicsList.add(
            AcademicQualificationItem(
              passedYear: year,
              degreeName: _degreeController.text.trim(),
            ),
          );
          _degreeController.clear();
          _yearController.clear();
        });
      }
    }
  }

  void _removeAcademic(int index) =>
      setState(() => _academicsList.removeAt(index));

  void _submit(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final profileCubit = context.read<ProfileCubit>();

      if (_selectedDob != null) profileCubit.updateDob(_selectedDob!);
      if (_hobbiesList.isNotEmpty) profileCubit.updateHobbies(_hobbiesList);
      if (_academicsList.isNotEmpty) {
        profileCubit.updateAcademicQualification(
          AcademicData(academicQualification: _academicsList),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final textTheme = context.textTheme;

    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        state.maybeWhen(
          loaded: (_, __, ___, ____, successMessage) {
            if (successMessage != null && successMessage.isNotEmpty) {
              ToastHelper.success(context, successMessage);
              context.router.push(const SubscribeRoute());
            }
          },
          error: (errorMessage) {
            if (errorMessage != null && errorMessage.isNotEmpty) {
              ToastHelper.error(context, errorMessage);
            }
          },
          orElse: () {},
        );
      },
      builder: (context, state) {
        final isLoading = state.maybeWhen(
          loading: () => true,
          orElse: () => false,
        );

        return Scaffold(
          appBar: const MyAppBar(title: "About you", centerTitle: false),
          body: AbsorbPointer(
            absorbing: isLoading,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Date of Birth
                    Text('Date of Birth *', style: textTheme.titleMedium),
                    const SizedBox(height: 8),
                    InkWell(
                      onTap: () => _selectDate(context),
                      child: InputDecorator(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          _selectedDob == null
                              ? 'Select date of birth'
                              : '${_selectedDob!.day}/${_selectedDob!.month}/${_selectedDob!.year}',
                          style: textTheme.bodyMedium,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Hobbies
                    Text('Hobbies (Optional)', style: textTheme.titleMedium),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            controller: _hobbiesController,
                            placeholder: 'Enter hobby',
                            showClearButtonOnTyping: true,
                          ),
                        ),
                        const SizedBox(width: 8),
                        AppButton(
                          icon: Icons.add,
                          onPressed: _addHobby,
                          type: AppButtonType.text,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: _hobbiesList
                          .asMap()
                          .entries
                          .map(
                            (entry) => Chip(
                              label: Text(entry.value),
                              onDeleted: () => _removeHobby(entry.key),
                              backgroundColor:
                                  colorScheme.surfaceContainerHighest,
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 24),

                    // Academic
                    Text(
                      'Academic Qualification (Optional)',
                      style: textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    CustomTextField(
                      controller: _degreeController,
                      placeholder: 'Degree Name',
                      showClearButtonOnTyping: true,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            controller: _yearController,
                            placeholder: 'Passed Year',
                            keyboardType: TextInputType.number,
                            showClearButtonOnTyping: true,
                          ),
                        ),
                        const SizedBox(width: 8),
                        AppButton(
                          icon: Icons.add,
                          onPressed: _addAcademic,
                          type: AppButtonType.text,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _academicsList.length,
                      itemBuilder: (context, index) {
                        final academic = _academicsList[index];
                        return Card(
                          color: colorScheme.surfaceContainerHighest,
                          child: ListTile(
                            title: Text(
                              academic.degreeName,
                              style: textTheme.bodyMedium,
                            ),
                            subtitle: Text(
                              'Passed Year: ${academic.passedYear}',
                              style: textTheme.bodySmall,
                            ),
                            trailing: IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: colorScheme.error,
                              ),
                              onPressed: () => _removeAcademic(index),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 32),

                    SizedBox(
                      width: double.infinity,
                      child: AppButton(
                        title: 'Complete Registration',
                        onPressed: () => _submit(context),
                        isLoading: isLoading,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
