import 'package:flutter/material.dart';

class StepsScreen extends StatelessWidget {
  String steps;
   StepsScreen({super.key,required this.steps});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text(steps),
      ),
    );
  }
}