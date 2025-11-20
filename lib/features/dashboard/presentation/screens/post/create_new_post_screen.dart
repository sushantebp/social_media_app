import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media_app/core/core.dart';
import 'package:social_media_app/features/dashboard/presentation/presentation.dart';

@RoutePage()
class CreateNewPostScreen extends StatefulWidget {
  const CreateNewPostScreen({super.key});

  @override
  State<CreateNewPostScreen> createState() => _CreateNewPostScreenState();
}

class _CreateNewPostScreenState extends State<CreateNewPostScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  File? _selectedImage;

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => _selectedImage = File(picked.path));
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PostCubit>();

    return BlocListener<PostCubit, PostState>(
      listener: (context, state) {
        state.whenOrNull(
          error: (msg) {
            ToastHelper.error(context, msg ?? "Something went wrong");
          },
          loaded: (_, _, _, message) {
            ToastHelper.success(context, message ?? "Post created!");
            Navigator.of(context).pop(true);
          },
        );
      },
      child: Scaffold(
        appBar: MyAppBar(
          allowBack: true,
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.close_sharp),
          ),
          title: 'Create Post',
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSize.paddingLarge),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                /// Title
                CustomTextField(
                  controller: _titleController,
                  label: 'Title',
                  placeholder: 'Enter post title',
                  prefix: const Icon(Icons.title_outlined),
                  isRounded: true,
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Enter title' : null,
                ),
                const SizedBox(height: AppSize.marginMedium),

                /// Content
                CustomTextField(
                  controller: _contentController,
                  label: 'Content',
                  placeholder: 'Write something...',
                  prefix: const Icon(Icons.text_snippet_outlined),
                  maxLines: 5,
                  isRounded: true,
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Enter content' : null,
                ),
                const SizedBox(height: AppSize.marginMedium),

                /// Image Picker
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    height: 180,
                    decoration: BoxDecoration(
                      color: context.colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(AppSize.radiusLarge),
                      border: Border.all(
                        color: context.colorScheme.primary.withValues(
                          alpha: 0.5,
                        ),
                        width: 1.5,
                      ),
                    ),
                    child: _selectedImage != null
                        ? Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  AppSize.radiusLarge,
                                ),
                                child: Image.file(
                                  _selectedImage!,
                                  width: double.infinity,
                                  height: 180,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: 8,
                                right: 8,
                                child: CircleAvatar(
                                  radius: 16,
                                  child: GestureDetector(
                                    onTap: () => setState(() {
                                      _selectedImage = null;
                                    }),
                                    child: const Icon(Icons.close, size: 18),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_a_photo_outlined,
                                  size: 40,
                                  color: context.colorScheme.primary,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Add Image',
                                  style: TextStyle(
                                    color: context.colorScheme.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),
                ),

                const SizedBox(height: AppSize.marginExtraLarge),

                /// Submit Button
                AppButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      cubit.createPost(
                        title: _titleController.text,
                        content: _contentController.text,
                        image: _selectedImage,
                      );
                    }
                  },
                  title: 'Post',
                  icon: Icons.send,
                  bgColor: context.colorScheme.primary,
                  height: 50,
                  borderRadius: AppSize.radiusLarge,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
