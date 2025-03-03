import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipieapp/services/image_services.dart';

class ImgController extends ChangeNotifier {
  File? selectedImge;
ImageServices services = ImageServices();
  void uploadImage() async {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image != null) {
        selectedImge = File(image.path);
        notifyListeners();
      }
   services.uploadImage(selectedImge!);

    }
  }

