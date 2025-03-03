import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipieapp/controller/recipe_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Hi muhammed sinan'),
          Text('Feartured'),

          Container(color: Colors.black, width: double.infinity, height: 200),
          Text('Catogary'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(onPressed: () {}, child: Text('data')),
              ElevatedButton(onPressed: () {}, child: Text('data')),
              ElevatedButton(onPressed: () {}, child: Text('data')),
            ],
          ),

          Text('Popular Recipies'),

          SizedBox(
            height: 200,
            child: Consumer<RecipeController>(
              builder:
                  (context, value, child) => ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: value.recipes.length,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        child: Image.network(value.recipes[index].image),
                        width: 200,
                      );
                    },
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
