import 'package:flutter/material.dart';

class DropdownProvider extends ChangeNotifier {
  String? selectedValue;
  List<String> items = ['Appetizers','Main Courses','Desserts'];

  void setSelectedValue(String? value) {
    selectedValue = value;
    notifyListeners(); 
  }
}
