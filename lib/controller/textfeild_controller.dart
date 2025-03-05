import 'package:flutter/material.dart';

class TextfeildController extends ChangeNotifier {
    List<TextEditingController> controllers = [TextEditingController()];
  List<TextEditingController> Qtycontrollers = [TextEditingController()];
  List<Widget> textFields = [TextField()];

  void addTextfeild() {
    textFields.add(TextField());
    controllers.add(TextEditingController());
    Qtycontrollers.add(TextEditingController());
    notifyListeners();
  }

  void removeTextfeild(int index) {
    if (textFields.length > 1) {
      Qtycontrollers.removeAt(index);
      textFields.removeAt(index);
      controllers.removeAt(index);
      notifyListeners();
    }
  }
  
}