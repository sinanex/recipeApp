import 'package:flutter/material.dart';
import 'package:recipieapp/services/auth_services.dart';

class AuthController extends ChangeNotifier {
  AuthServices authServices = AuthServices();
  void loginUser({required String email, required String password}) async {
    authServices.loginUser(email, password);
  }

  void registerUser({required String email, required String password}) {
    authServices.registerUser(email, password);
  }
}
