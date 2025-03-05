import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipieapp/services/image_services.dart';

class ImgProviderController extends ChangeNotifier {
  File? selectedImge;

  String? imgUrl;
ImageServices services = ImageServices();
void uploadImage() async {
  try {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    
    if (image != null) {
      selectedImge = File(image.path);
      notifyListeners();

      imgUrl = await services.uploadImage(selectedImge!);
      
      notifyListeners();
    } else {
      log("No image selected");
    }
  } catch (e) {
    debugPrint("Error uploading image: $e");
  }
  notifyListeners();
}

  }

