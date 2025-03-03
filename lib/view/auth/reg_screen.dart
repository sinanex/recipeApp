import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipieapp/controller/auth_controller.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
   RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _emailController,
            ),
            TextField(
              controller: _passwordController,
            ),
            ElevatedButton(onPressed: (){
              context.read<AuthController>().registerUser(email: _emailController.text, password: _passwordController.text);
            }, child: Text('Register'))
          ],
        ),
      ),
    );
  }
}
