import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipieapp/controller/auth_controller.dart';
import 'package:recipieapp/controller/img_controller.dart';
import 'package:recipieapp/view/bottomBAr/bottom_bar.dart';
import 'package:recipieapp/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  RegisterScreen({super.key});

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
                'Register',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 50),
              Consumer<ImgProviderController>(
                builder: (context, imgProvider, child) {
                  return GestureDetector(
                    onTap: () => imgProvider.uploadImage(),
                    child: CircleAvatar(
                      radius: 50,
                      child:
                          imgProvider.selectedImge == null
                              ? const Icon(
                                Icons.person,
                                size: 50,
                                color: Colors.white,
                              )
                              : ClipOval(
                                child: Image.file(
                                  File(imgProvider.selectedImge!.path),
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 40),
              customTextfeild(_nameController, 'Name'),
              const SizedBox(height: 20),
              customTextfeild(_emailController, 'Email'),
              const SizedBox(height: 20),
              customTextfeild(_passwordController, 'Password'),
              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: () {
                  String email = _emailController.text.trim();
                  String password = _passwordController.text.trim();
                  String name = _nameController.text.trim();

                  if (name.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please enter your name')),
                    );
                    return;
                  }

                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Enter a valid email')),
                    );
                    return;
                  }

                  if (password.length < 6) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Password must be at least 6 characters'),
                      ),
                    );
                    return;
                  }

                  Provider.of<AuthController>(context, listen: false)
                      .registerUser(
                        email: email,
                        password: password,
                        name: name,
                        imageUrl:
                            context.read<ImgProviderController>().imgUrl ?? '',
                      )
                      .then((value)async {
                        SharedPreferences _pref = await SharedPreferences.getInstance();
                        _pref.setBool('auth', true);
                        if (value == 'reg success') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BottomBar(),
                            ),
                          );
                        }
                      });
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
                  'Register',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),

              const SizedBox(height: 20),

              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  print('Navigate to Login screen');
                },
                child: const Text(
                  'Already have an account? Login',
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
