import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipieapp/controller/auth_controller.dart';
import 'package:recipieapp/view/auth/reg_screen.dart';
import 'package:recipieapp/view/bottomBAr/bottom_bar.dart';
import 'package:recipieapp/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Let\'s get started',
                style: TextStyle(
                  fontSize: 20,

                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              customTextfeild(_emailController, 'Email'),
              const SizedBox(height: 20),

              customTextfeild(_passwordController, 'Password'),
              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: () async{
                  String email = _emailController.text.trim();
                  String password = _passwordController.text.trim();
                  if (email.isNotEmpty && password.isNotEmpty) {
                    context
                        .read<AuthController>()
                        .loginUser(email: email, password: password)
                        .then((message)async {

                          if (message == 'login success') {
                            SharedPreferences _pref = await SharedPreferences.getInstance();
                                      _pref.setBool('auth', true);
                                       log('logiinnnnnn');
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BottomBar(),
                              ),
                            );
                          }
                        });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please enter email and password'),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),

              const SizedBox(height: 20),

              TextButton(
                onPressed: () async {
                  SharedPreferences _pref =
                      await SharedPreferences.getInstance();
                  _pref.setBool('auth', true);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterScreen()),
                  );
                  print('Navigate to Sign-up screen');
                },
                child: const Text(
                  'Don\'t have an account? Sign Up',
                  style: TextStyle(color: Colors.blueAccent),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
