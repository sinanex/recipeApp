import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipieapp/controller/img_controller.dart';

class AddScreen extends StatelessWidget {
  const AddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 60),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
  context.read<ImgController>().uploadImage();
              },
              child: Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(color: Colors.black),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: Colors.black,
                      content: Container(
                        width: double.infinity,
                        height: 60,
                        decoration: BoxDecoration(color: Colors.black),
                      ),
                    );
                  },
                );
              },
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          Text('incredians'),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(child: customTextfeild()),
                SizedBox(width: 20),
                Expanded(child: customTextfeild()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  TextField customTextfeild() {
    return TextField(
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }


}
