import 'dart:io';
import 'package:dio/dio.dart';

class CreatePostRequestModel {
  final String title;
  final String content;
  final File? image;

  const CreatePostRequestModel({
    required this.title,
    required this.content,
    this.image,
  });

  Future<FormData> toFormData() async {
    final Map<String, dynamic> fields = {'title': title, 'content': content};

    // Only attach image if it exists
    if (image != null) {
      fields['image'] = await MultipartFile.fromFile(
        image!.path,
        filename: image!.path.split('/').last,
      );
    }

    return FormData.fromMap(fields);
  }
}
