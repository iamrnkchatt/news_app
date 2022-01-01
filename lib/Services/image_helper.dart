import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

import 'package:image_picker/image_picker.dart';

class ImageHelper {
  static Future<File?> pickImageFromGallery({
    required BuildContext context,
    required CropStyle cropStyle,
    required String title,
  }) async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    var file = File(pickedFile!.path);
    return file;
  }

  static Future<File?> pickImageFromCamera({
    required BuildContext context,
    required CropStyle cropStyle,
    required String title,
  }) async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.camera);
    var file = File(pickedFile!.path);
    return file;
  }
}
