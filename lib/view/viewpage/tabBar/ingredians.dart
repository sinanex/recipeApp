import 'package:flutter/material.dart';

class IngredientsPage extends StatelessWidget {
  final Map<String, dynamic>? ingredients;

  IngredientsPage({super.key, required this.ingredients});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:
          ingredients == null || ingredients!.isEmpty
              ? Center(child: Text('No Ingredients Available'))
              : ListView.builder(
                itemCount: ingredients!.length,
                itemBuilder: (context, index) {
                  String key = ingredients!.keys.elementAt(index);
                  dynamic value = ingredients![key];

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Row(
                        children: [
                          Text(
                            key,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          Text(
                            value.toString(),
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(color: Colors.grey.shade200, blurRadius: 1),
                        ],
                        border: Border(
                          bottom: BorderSide(color: Colors.grey.shade300),
                        ),
                      ),
                    ),
                  );
                },
              ),
    );
  }
}
