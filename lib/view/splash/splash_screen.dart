import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:recipieapp/view/auth/login_screen.dart';
import 'package:recipieapp/view/bottomBAr/bottom_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), checkLogin);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text('splash screen')
      ),
    );
  }

  Future<void> checkLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool? isLoggedIn = pref.getBool('auth');
    log(isLoggedIn.toString());
    if (isLoggedIn == true) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => BottomBar()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }
}
