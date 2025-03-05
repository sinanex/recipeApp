import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:recipieapp/services/auth_services.dart';

class AuthController extends ChangeNotifier {
  String? username;
  String? image;
  AuthServices authServices = AuthServices();
  Future<String?> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final message = await authServices.loginUser(email, password);
      return message;
    } catch (e) {
      log(e.toString());
    }
  }

  Future<String?> registerUser({
    required String imageUrl,
    required String email,
    required String password,
    required String name,
  }) {
    final message = authServices.registerUser(email, password, name, imageUrl);
    return message;
  }

 Future<Map<String, dynamic>> getUserData() async {
  
  try {
    final userData = await authServices.getUserData();

    if (userData.isNotEmpty) {
      
      image = userData['image'] ?? ''; 
      username = userData['name'] ?? 'Unknown'; 

      log('User image: $image');
      log('Username: $username');

      notifyListeners(); 
      return userData;
    }
  } catch (e) {
    log(e.toString());
  }

  notifyListeners(); 
  return {};
}

}
