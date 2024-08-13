import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

Future<File?> pickImage() async {
  try {
    final XFile? xFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    return xFile != null ? File(xFile.path) : null;
  } catch (e) {
    debugPrint(e.toString());
    return null;
  }
}
